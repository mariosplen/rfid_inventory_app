import 'package:flutter/material.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/core/models/rfid_model.dart';
import 'package:rfid_inventory_app/features/home/presentation/widgets/not_registered_tile.dart';

class NonRegisteredExpansionTile extends StatefulWidget {
  const NonRegisteredExpansionTile({
    required this.inventories,
    required this.rfidTags,
    required this.onTagPressed,
    required this.onTagOutOfRange,
    super.key,
  });
  final List<InventoryModel> inventories;
  final List<RFIDModel> rfidTags;
  final void Function(RFIDModel tag) onTagPressed;
  final void Function(RFIDModel tag) onTagOutOfRange;

  @override
  State<NonRegisteredExpansionTile> createState() =>
      _NonRegisteredExpansionTileState();
}

class _NonRegisteredExpansionTileState
    extends State<NonRegisteredExpansionTile> {
  bool isFreezed = false;
  List<RFIDModel> previousTags = [];

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now();
    final List<RFIDModel> nonRegisteredTags = isFreezed
        ? (previousTags.map(
            (tag) {
              return tag.copyWith(
                lastSeen: dateTime,
              );
            },
          ).toList())
        : widget.rfidTags.where((tag) {
            return !widget.inventories.any(
              (inventory) => inventory.items.any((item) => item.epc == tag.epc),
            );
          }).toList();
    previousTags = nonRegisteredTags;
    return ExpansionTile(
      shape: const RoundedRectangleBorder(),
      tilePadding: EdgeInsets.zero,
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          isFreezed ? Icons.play_arrow : Icons.pause,
          size: 34,
        ),
        onPressed: () {
          setState(() {
            isFreezed = !isFreezed;
          });
        },
      ),
      title: Text("${nonRegisteredTags.length} Non-Registered RFID Tags"),
      subtitle: Text(
        nonRegisteredTags.isEmpty
            ? "No RFID tags found that are not registered."
            : "Tap on an RFID tag to register it.",
      ),
      children: List.generate(
        nonRegisteredTags.length,
        (index) => Padding(
          padding: const EdgeInsets.only(top: 12),
          child: NonRegisteredTile(
            context: context,
            key: ValueKey(nonRegisteredTags[index].epc),
            tag: nonRegisteredTags[index],
            onPressed: () => widget.onTagPressed(nonRegisteredTags[index]),
            onOutOfRange: () =>
                widget.onTagOutOfRange(nonRegisteredTags[index]),
          ),
        ),
      ),
    );
  }
}
