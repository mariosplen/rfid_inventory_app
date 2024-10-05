import 'package:flutter/material.dart';

class NewInventoryCard extends StatelessWidget {
  const NewInventoryCard({
    required this.onPressed,
    super.key,
  });
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 144,
          padding: const EdgeInsets.all(8),
          child: const Center(
            child: Icon(
              Icons.add_rounded,
              size: 70,
            ),
          ),
        ),
      ),
    );
  }
}
