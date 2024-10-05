import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/core/models/item_model.dart';
import 'package:rfid_inventory_app/features/create_inventory/presentation/create_inventory_page.dart';
import 'package:rfid_inventory_app/features/create_item/presentation/create_item_page.dart';
import 'package:rfid_inventory_app/features/home/cubits/inventories_cubit.dart';
import 'package:rfid_inventory_app/features/inventory/presentation/widgets/item_card.dart';

@RoutePage()
class InventoryPage extends StatelessWidget {
  const InventoryPage({
    required this.inventoryId,
    super.key,
  });

  final String inventoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Builder(
        builder: (context) {
          final inventoriesState = context.watch<InventoriesCubit>().state;
          final readerState = context.watch<ReaderCubit>().state;
          final inventory = inventoriesState.inventories?.firstWhere(
            (inventory) => inventory.id == inventoryId,
            orElse: () => InventoryModel.empty(),
          );

          return Column(
            children: [
              Row(
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Container(
                      height: 100,
                    ),
                  ),
                  Text('Name: ${inventory?.name}'),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateInventoryPage(
                            inventory: inventory,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _onDeleteInventory(context, inventoryId),
                  ),
                ],
              ),
              Text('Description: ${inventory?.description}'),
              Text('Quantity: ${inventory?.location}'),
              Text('Price: ${inventory?.note}'),
              Expanded(
                child: ListView(
                  children: inventory?.items
                          .map(
                            (item) => ItemCard(
                              item: item,
                              isDetected: readerState.tagsFound
                                  .any((tag) => tag.epc == item.epc),
                              onDeleteTap: () => _onDeleteItem(context, item),
                              onEditTap: () => _onEditItem(context, item),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onEditItem(BuildContext context, ItemModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateItemPage(
          item: item,
        ),
      ),
    );
  }

  void _onDeleteItem(BuildContext context, ItemModel item) {
    context.read<InventoriesCubit>().deleteItem(item.epc);
  }

  void _onDeleteInventory(BuildContext context, String inventoryId) {
    Navigator.maybePop(context);
    context.read<InventoriesCubit>().deleteInventory(inventoryId);
  }
}
