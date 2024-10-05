import 'package:flutter/material.dart';
import 'package:rfid_inventory_app/core/models/rfid_model.dart';

class NonRegisteredTile extends StatefulWidget {
  const NonRegisteredTile({
    required this.tag,
    required this.onPressed,
    required this.onOutOfRange,
    required this.context,
    super.key,
  });
  final RFIDModel tag;
  final void Function() onPressed;
  final void Function() onOutOfRange;
  final BuildContext context;

  @override
  State<NonRegisteredTile> createState() => _NonRegisteredTileState();
}

class _NonRegisteredTileState extends State<NonRegisteredTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Theme.of(widget.context).colorScheme.primary,
      end: Colors.transparent,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCirc,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onOutOfRange();
      }
    });
  }

  @override
  void didUpdateWidget(covariant NonRegisteredTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tag.lastSeen != oldWidget.tag.lastSeen) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return InkWell(
          splashFactory: InkRipple.splashFactory,
          onTap: () => widget.onPressed(),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 3,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            title: Text(
              widget.tag.epc,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            tileColor: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
