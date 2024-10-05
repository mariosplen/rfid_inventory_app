import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/core/models/item_model.dart';
import 'package:rfid_inventory_app/core/router/app_router.dart';
import 'package:rfid_inventory_app/core/router/app_router.gr.dart';
import 'package:rfid_inventory_app/features/home/cubits/inventories_cubit.dart';
import 'package:rfid_inventory_app/firebase_options.dart';
import 'package:rfid_inventory_app/theme/app_theme.dart';
import 'package:rfid_inventory_app/theme/util.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final openSansLicense =
        await rootBundle.loadString('assets/fonts/Open_Sans/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Open_Sans'], openSansLicense);

    final robotoLicense =
        await rootBundle.loadString('assets/fonts/Roboto/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Roboto'], robotoLicense);
  });
  GoogleFonts.config.allowRuntimeFetching = false;

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(InventoryModelAdapter());
  await Hive.openBox<InventoryModel>('inventories');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Roboto", "Open Sans");

    AppTheme theme = AppTheme(textTheme);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReaderCubit()),
        BlocProvider(create: (context) => InventoriesCubit()),
      ],
      child: BlocListener<ReaderCubit, ReaderState>(
        listener: (context, state) {
          // redirect to connect page if there is a connection error and not already on connect page and not handled disconnect
          if (appRouter.current.name != ConnectRoute.name &&
              state.connectionError != null &&
              !state.handledDisconnect) {
            appRouter.replace(const ConnectRoute());
          }

          // redirect to home page when logged in and in connect page
          else if (appRouter.current.name == ConnectRoute.name &&
              state.status == ReaderStatus.connected) {
            appRouter.replace(const HomeRoute());
          }
        },
        child: MaterialApp.router(
          title: 'SnapRFID Inventory',
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          routerConfig: appRouter.config(),
        ),
      ),
    );
  }
}
