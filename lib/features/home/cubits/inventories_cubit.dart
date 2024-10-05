import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';

part 'inventories_state.dart';

class InventoriesCubit extends Cubit<InventoriesState> {
  InventoriesCubit() : super(InventoriesState.initial());

  void loadInventories() {
    final inventoriesBox = Hive.box<InventoryModel>("inventories");
    emit(
      state.copyWith(
        inventories: inventoriesBox.values.toList(),
      ),
    );
  }

  void deleteInventory(String inventoryId) {
    final inventoriesBox = Hive.box<InventoryModel>("inventories");
    final index = inventoriesBox.values.toList().indexWhere(
          (inventory) => inventory.id == inventoryId,
        );
    inventoriesBox.deleteAt(index);
    emit(
      state.copyWith(
        inventories: inventoriesBox.values.toList(),
      ),
    );
  }

  void deleteItem(String itemEpc) {
    final inventoriesBox = Hive.box<InventoryModel>("inventories");
    final inventories = inventoriesBox.values.toList();
    final index = inventories.indexWhere(
      (inventory) => inventory.items.any((item) => item.epc == itemEpc),
    );
    final inventory = inventoriesBox.getAt(index);
    final itemIndex =
        inventory?.items.indexWhere((item) => item.epc == itemEpc);
    if (inventory != null && itemIndex != -1) {
      inventory.items.removeAt(itemIndex!);
      inventoriesBox.putAt(index, inventory);
      emit(
        state.copyWith(
          inventories: inventoriesBox.values.toList(),
        ),
      );
    }
  }

  void clearInventories() {
    final inventoriesBox = Hive.box<InventoryModel>("inventories");
    inventoriesBox.clear();
    emit(
      state.copyWith(
        inventories: [],
      ),
    );
  }
}
