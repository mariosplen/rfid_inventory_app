import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return Card(
      color: Theme.of(context).colorScheme.onSecondary,
      child: Container(
        height: 180,
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.file(
                  File(item.image),
                  errorBuilder: (_, __, ___) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.no_photography_rounded,
                          size: 48,
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Gap(8),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    'Category: ${item.category}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const Gap(4),
                  Expanded(
                    child: Wrap(
                      children: List.generate(
                        item.tags.length,
                        (index) => Chip(
                          label: Text(item.tags[index]),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: onEditTap,
                        iconSize: 20,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDeleteTap,
                        iconSize: 20,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
