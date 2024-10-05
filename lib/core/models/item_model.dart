import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 1)
class ItemModel extends Equatable {
  @HiveField(0)
  final String epc;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String color;
  @HiveField(5)
  final List<String> tags;

  const ItemModel({
    required this.epc,
    required this.image,
    required this.name,
    required this.category,
    required this.color,
    required this.tags,
  });

  factory ItemModel.empty() {
    return const ItemModel(
      epc: '',
      image: '',
      name: '',
      category: '',
      color: '',
      tags: [],
    );
  }

  ItemModel copyWith({
    String? epc,
    String? image,
    String? name,
    String? category,
    String? color,
    List<String>? tags,
  }) {
    return ItemModel(
      epc: epc ?? this.epc,
      image: image ?? this.image,
      name: name ?? this.name,
      category: category ?? this.category,
      color: color ?? this.color,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object> get props => [epc, image, name, category, color, tags];
}
