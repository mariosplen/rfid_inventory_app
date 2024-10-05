import 'package:flutter/material.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel(this.status, {super.key});
  final ReaderStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Status: "),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all()),
          child: Text(
            _getStatusText(status),
          ),
        ),
      ],
    );
  }

  String _getStatusText(ReaderStatus status) {
    switch (status) {
      case ReaderStatus.disconnected:
        return "Disconnected";
      case ReaderStatus.connecting:
        return "Connecting";
      case ReaderStatus.connected:
        return "Connected";
    }
  }
}
