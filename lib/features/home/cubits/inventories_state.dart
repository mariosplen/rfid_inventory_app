part of 'inventories_cubit.dart';

class InventoriesState extends Equatable {
  final List<InventoryModel>? inventories;

  const InventoriesState({
    this.inventories,
  });

  factory InventoriesState.initial() {
    return const InventoriesState();
  }

  InventoriesState copyWith({
    List<InventoryModel>? inventories,
  }) {
    return InventoriesState(
      inventories: inventories ?? this.inventories,
    );
  }

  @override
  List<Object?> get props => [inventories];
}
