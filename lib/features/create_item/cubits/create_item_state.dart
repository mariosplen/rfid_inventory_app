part of 'create_item_cubit.dart';

class CreateItemState extends Equatable {
  final ItemModel item;
  final bool isEditing;
  final bool success;
  final bool aiError;
  final bool aiSuccess;

  final String? selectedInventoryId;

  final String? epcError;
  final String? nameError;
  final String? categoryError;
  final String? colorError;
  final String? tagsError;
  final String? inventoryError;

  final bool isLoadingAIResult;

  const CreateItemState({
    required this.item,
    required this.isEditing,
    required this.selectedInventoryId,
    this.isLoadingAIResult = false,
    this.success = false,
    this.aiError = false,
    this.aiSuccess = false,
    this.epcError,
    this.nameError,
    this.categoryError,
    this.colorError,
    this.tagsError,
    this.inventoryError,
  });

  factory CreateItemState.initial() {
    return CreateItemState(
      item: ItemModel.empty(),
      isEditing: false,
      selectedInventoryId: null,
    );
  }

  CreateItemState copyWith({
    ItemModel? item,
    bool? isEditing,
    bool? success,
    bool? isLoadingAIResult,
    bool? aiError,
    bool? aiSuccess,
    String? selectedInventoryId,
    String? epcError,
    String? nameError,
    String? categoryError,
    String? colorError,
    String? tagsError,
    String? inventoryError,
  }) {
    return CreateItemState(
      isEditing: isEditing ?? this.isEditing,
      item: item ?? this.item,
      selectedInventoryId: selectedInventoryId ?? this.selectedInventoryId,
      success: success ?? this.success,
      isLoadingAIResult: isLoadingAIResult ?? this.isLoadingAIResult,
      aiError: aiError ?? this.aiError,
      aiSuccess: aiSuccess ?? this.aiSuccess,
      epcError: epcError,
      nameError: nameError,
      categoryError: categoryError,
      colorError: colorError,
      tagsError: tagsError,
      inventoryError: inventoryError,
    );
  }

  @override
  List<Object?> get props => [
        item,
        selectedInventoryId,
        isEditing,
        success,
        isLoadingAIResult,
        aiError,
        aiSuccess,
        epcError,
        nameError,
        categoryError,
        colorError,
        tagsError,
        inventoryError,
      ];
}
