import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/core/models/item_model.dart';
import 'package:rfid_inventory_app/features/create_inventory/presentation/create_inventory_page.dart';
import 'package:rfid_inventory_app/features/create_item/presentation/create_item_page.dart';
import 'package:rfid_inventory_app/features/home/cubits/inventories_cubit.dart';
import 'package:rfid_inventory_app/features/inventory/presentation/widgets/item_card.dart';

@RoutePage()
class InventoryPage extends StatefulWidget {
  const InventoryPage({
    required this.inventoryId,
    super.key,
  });

  final String inventoryId;

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int statusIndex = 0;

  List<ItemModel> shownItems = [];

  List<String> selectedTags = [];
  List<String> selectedCategories = [];
  List<String> selectedColors = [];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final inventoriesState = context.watch<InventoriesCubit>().state;
        final readerState = context.watch<ReaderCubit>().state;
        final inventory = inventoriesState.inventories?.firstWhere(
          (inventory) => inventory.id == widget.inventoryId,
          orElse: () => InventoryModel.empty(),
        );

        final allTags = inventory?.items.expand((item) => item.tags).toSet();

        final allCategories =
            inventory?.items.map((item) => item.category).toSet();

        final allColors = inventory?.items.map((item) => item.color).toSet();

        final statuses = ['All', 'Detected', 'Not Detected'];

        shownItems = inventory?.items.where((item) {
              if (statusIndex == 0) {
                return true;
              } else if (statusIndex == 1) {
                return readerState.tagsFound.any((tag) => tag.epc == item.epc);
              } else {
                return !readerState.tagsFound.any((tag) => tag.epc == item.epc);
              }
            }).toList() ??
            [];

        shownItems = shownItems.where((item) {
          if (selectedTags.isNotEmpty) {
            return item.tags.any((tag) => selectedTags.contains(tag));
          }
          return true;
        }).toList();

        shownItems = shownItems.where((item) {
          if (selectedCategories.isNotEmpty) {
            return selectedCategories.contains(item.category);
          }
          return true;
        }).toList();

        shownItems = shownItems.where((item) {
          if (selectedColors.isNotEmpty) {
            return selectedColors.contains(item.color);
          }
          return true;
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(inventory?.name ?? ''),
            actions: [
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
                onPressed: () =>
                    _onDeleteInventory(context, widget.inventoryId),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inventory?.description ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  inventory?.location ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                Text(
                  inventory?.note ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const Gap(24),
                Text(
                  'FILTERS',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            statusIndex = (statusIndex + 1) % statuses.length;
                          });
                        },
                        child: Text('Display: ${statuses[statusIndex]}'),
                      ),
                      const Gap(4),
                      MultiSelectDialogField(
                        items: allCategories
                                ?.map((category) =>
                                    MultiSelectItem(category, category))
                                .toList() ??
                            [],
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withOpacity(0.5),
                        ),
                        listType: MultiSelectListType.CHIP,
                        chipDisplay: MultiSelectChipDisplay.none(),
                        title: const Text('Categories'),
                        buttonText: const Text('Category'),
                        onConfirm: (values) {
                          debugPrint("hi");
                          setState(() {
                            selectedCategories = [...values];
                          });
                        },
                        initialValue: selectedCategories,
                      ),
                      const Gap(4),
                      MultiSelectDialogField(
                        items: allTags
                                ?.map((tag) => MultiSelectItem(tag, tag))
                                .toList() ??
                            [],
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withOpacity(0.5),
                        ),
                        listType: MultiSelectListType.CHIP,
                        chipDisplay: MultiSelectChipDisplay.none(),
                        title: const Text('Tags'),
                        buttonText: const Text('Tags'),
                        onConfirm: (values) {
                          setState(() {
                            selectedTags = [...values];
                          });
                        },
                        initialValue: selectedTags,
                      ),
                      const Gap(4),
                      MultiSelectDialogField(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiaryContainer
                              .withOpacity(0.5),
                        ),
                        selectedColor: Theme.of(context).primaryColorLight,
                        selectedItemsTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        items: allColors
                                ?.map((color) => MultiSelectItem(color, color))
                                .toList() ??
                            [],
                        listType: MultiSelectListType.CHIP,
                        chipDisplay: MultiSelectChipDisplay.none(),
                        title: const Text('Colors'),
                        buttonText: const Text('Color'),
                        onConfirm: (values) {
                          setState(() {
                            selectedColors = [...values];
                          });
                        },
                        initialValue: selectedColors,
                      ),
                    ],
                  ),
                ),
                const Gap(18),
                Expanded(
                  child: ListView(
                    children: shownItems
                        .map(
                          (item) => ItemCard(
                            item: item,
                            isDetected: readerState.tagsFound
                                .any((tag) => tag.epc == item.epc),
                            onDeleteTap: () => _onDeleteItem(context, item),
                            onEditTap: () => _onEditItem(context, item),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
