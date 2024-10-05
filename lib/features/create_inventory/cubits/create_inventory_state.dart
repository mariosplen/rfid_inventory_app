part of 'create_inventory_cubit.dart';

class CreateInventoryState extends Equatable {
  final InventoryModel inventory;
  final bool isEditing;
  final bool success;

  final String? nameError;
  final String? descriptionError;
  final String? locationError;
  final String? noteError;

  const CreateInventoryState({
    required this.inventory,
    this.success = false,
    this.isEditing = false,
    this.nameError,
    this.descriptionError,
    this.locationError,
    this.noteError,
  });

  factory CreateInventoryState.initial() {
    return CreateInventoryState(
      inventory: InventoryModel.empty(),
    );
  }

  CreateInventoryState copyWith({
    InventoryModel? inventory,
    bool? success,
    bool? isEditing,
    String? nameError,
    String? descriptionError,
    String? locationError,
    String? noteError,
  }) {
    return CreateInventoryState(
      inventory: inventory ?? this.inventory,
      success: success ?? this.success,
      isEditing: isEditing ?? this.isEditing,
      nameError: nameError,
      descriptionError: descriptionError,
      locationError: locationError,
      noteError: noteError,
    );
  }

  @override
  List<Object?> get props => [
        inventory,
        success,
        isEditing,
        nameError,
        descriptionError,
        locationError,
        noteError,
      ];
}
