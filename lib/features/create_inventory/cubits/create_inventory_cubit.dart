import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';

part 'create_inventory_state.dart';

class CreateInventoryCubit extends Cubit<CreateInventoryState> {
  CreateInventoryCubit({
    required InventoryModel inventory,
    required bool isEditing,
  }) : super(
          CreateInventoryState.initial()
              .copyWith(inventory: inventory, isEditing: isEditing),
        );

  final inventoriesBox = Hive.box<InventoryModel>("inventories");

  void onNameChanged(String name) {
    emit(
      state.copyWith(
        inventory: state.inventory.copyWith(name: name),
        descriptionError: state.descriptionError,
        locationError: state.locationError,
        noteError: state.noteError,
      ),
    );
  }

  void onDescriptionChanged(String description) {
    emit(
      state.copyWith(
        inventory: state.inventory.copyWith(description: description),
        locationError: state.locationError,
        nameError: state.nameError,
        noteError: state.noteError,
      ),
    );
  }

  void onLocationChanged(String location) {
    emit(
      state.copyWith(
        inventory: state.inventory.copyWith(location: location),
        descriptionError: state.descriptionError,
        nameError: state.nameError,
        noteError: state.noteError,
      ),
    );
  }

  void onNoteChanged(String note) {
    emit(
      state.copyWith(
        inventory: state.inventory.copyWith(note: note),
        descriptionError: state.descriptionError,
        locationError: state.locationError,
        nameError: state.nameError,
      ),
    );
  }

  (
    String? nameError,
    String? descriptionError,
    String? locationError,
    String? noteError,
  ) validate() {
    String? nameError;
    String? descriptionError;
    String? locationError;
    String? noteError;

    if (state.inventory.name.trim().isEmpty) {
      nameError = "Name cannot be empty";
    }
    if (state.inventory.description.trim().isEmpty) {
      descriptionError = "Description cannot be empty";
    }
    if (state.inventory.location.trim().isEmpty) {
      locationError = "Location cannot be empty";
    }
    if (state.inventory.note.trim().isEmpty) {
      noteError = "Notes cannot be empty";
    }
    return (nameError, descriptionError, locationError, noteError);
  }

  void onSubmitInventory() {
    final (nameError, descriptionError, locationError, noteError) = validate();

    if (nameError != null ||
        descriptionError != null ||
        locationError != null ||
        noteError != null) {
      emit(
        state.copyWith(
          nameError: nameError,
          descriptionError: descriptionError,
          locationError: locationError,
          noteError: noteError,
        ),
      );
      return;
    }

    if (state.isEditing) {
      final index = inventoriesBox.values
          .toList()
          .indexWhere((inv) => inv.id == state.inventory.id);
      inventoriesBox.putAt(index, state.inventory);
    } else {
      inventoriesBox.add(state.inventory);
    }
    emit(state.copyWith(success: true));
  }
}
