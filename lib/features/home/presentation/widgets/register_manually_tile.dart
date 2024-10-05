import 'package:flutter/material.dart';

class RegisterManuallyTile extends StatelessWidget {
  const RegisterManuallyTile({
    required this.onPressed,
    super.key,
  });
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        "Register manually",
        textAlign: TextAlign.center,
      ),
      leading: const Visibility(
        visible: false,
        child: Icon(Icons.arrow_forward_ios_rounded),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onPressed,
    );
  }
}
