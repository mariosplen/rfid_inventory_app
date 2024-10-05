import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';
import 'package:rfid_inventory_app/core/presentation/utils/snackbar_util.dart';
import 'package:rfid_inventory_app/core/router/app_router.gr.dart';
import 'package:rfid_inventory_app/features/home/cubits/inventories_cubit.dart';
import 'package:rfid_inventory_app/features/home/presentation/widgets/inventory_card.dart';
import 'package:rfid_inventory_app/features/home/presentation/widgets/new_inventory_card.dart';
import 'package:rfid_inventory_app/features/home/presentation/widgets/non_registered_expansion_tile.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final scannerBloc = context.watch<ReaderCubit>();
        final inventoriesCubit = context.watch<InventoriesCubit>()
          ..loadInventories();
        final scannerState = scannerBloc.state;
        final inventoriesState = inventoriesCubit.state;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'SnapRFID Inventory',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => context.router.push(const SettingsRoute()),
              ),
            ],
            leading: IconButton(
              icon:
                  Transform.flip(flipX: true, child: const Icon(Icons.logout)),
              onPressed: () {
                context.read<ReaderCubit>().disconnect();
                context.router.replace(const ConnectRoute());
              },
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    primary: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INVENTORIES',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          AlignedGridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                (inventoriesState.inventories?.length ?? 0) + 1,
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            itemBuilder: (context, index) {
                              if (index ==
                                  (inventoriesState.inventories?.length ?? 0)) {
                                return NewInventoryCard(
                                  onPressed: () => context.router
                                      .push(CreateInventoryRoute()),
                                );
                              }
                              return InventoryCard(
                                inventoryModel:
                                    inventoriesState.inventories![index],
                                rfidTags: scannerState.tagsFound,
                                onPressed: () => context.router.push(
                                  InventoryRoute(
                                    inventoryId:
                                        inventoriesState.inventories![index].id,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Gap(8),
                          Text(
                            'UNREGISTERED TAGS',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          NonRegisteredExpansionTile(
                            inventories: inventoriesState.inventories ?? [],
                            onTagPressed: (tag) {
                              if ((inventoriesState.inventories ?? [])
                                  .isEmpty) {
                                showInfoSnackBar(
                                  context,
                                  'You need to create an inventory first',
                                );
                                return;
                              }
                              context.router
                                  .push(CreateItemRoute(rfidModel: tag));
                            },
                            onTagOutOfRange: (tag) =>
                                scannerBloc.removeTag(tag),
                            rfidTags: scannerState.tagsFound,
                          ),
                          const Gap(24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
