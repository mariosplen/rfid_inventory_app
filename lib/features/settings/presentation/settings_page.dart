import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';
import 'package:rfid_inventory_app/core/router/app_router.gr.dart';
import 'package:rfid_inventory_app/features/home/cubits/inventories_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String apiKey = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        apiKey = value.getString("apiKey") ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                child: const Text('Clear all data'),
                onPressed: () =>
                    context.read<InventoriesCubit>().clearInventories(),
              ),
              ElevatedButton(
                child: const Text("Disconnect"),
                onPressed: () {
                  context.read<ReaderCubit>().disconnect();
                  context.router.replace(const ConnectRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
