import 'package:flutter/material.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/core/models/rfid_model.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({
    required this.inventoryModel,
    required this.rfidTags,
    required this.onPressed,
    super.key,
  });
  final InventoryModel inventoryModel;
  final List<RFIDModel> rfidTags;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final detectedTags = inventoryModel.items
        .where((item) => rfidTags.any((tag) => tag.epc == item.epc))
        .length;

    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 144,
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: detectedTags.toString(),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: ' / ',
                      style: TextStyle(fontSize: 30),
                    ),
                    TextSpan(
                      text: inventoryModel.items.length.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      inventoryModel.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      inventoryModel.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
