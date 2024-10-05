import 'package:flutter/material.dart';
import 'package:rfid_inventory_app/core/models/item_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.item,
    required this.isDetected,
    required this.onEditTap,
    required this.onDeleteTap,
    super.key,
  });
  final ItemModel item;
  final bool isDetected;
  final void Function() onEditTap;
  final void Function() onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        color: isDetected ? Colors.green : Colors.white,
        child: Row(
          children: [
            Column(
              children: [
                Text(item.name),
                Row(
                  children: item.tags.map((tag) => Text(tag)).toList(),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEditTap,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDeleteTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
