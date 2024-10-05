import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:rfid_inventory_app/core/models/item_model.dart';
import 'package:uuid/uuid.dart';

part 'inventory_model.g.dart';

@HiveType(typeId: 0)
class InventoryModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String location;
  @HiveField(4)
  final String note;
  @HiveField(5)
  final List<ItemModel> items;

  const InventoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.note,
    required this.items,
  });

  factory InventoryModel.empty() {
    return InventoryModel(
      id: const Uuid().v4(),
      name: "",
      description: "",
      location: "",
      note: "",
      items: const [],
    );
  }

  InventoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    String? note,
    List<ItemModel>? items,
  }) {
    return InventoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      note: note ?? this.note,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [id, name, description, location, note, items];
}
