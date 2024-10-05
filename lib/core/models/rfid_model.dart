import 'package:equatable/equatable.dart';

class RFIDModel extends Equatable {
  final String epc;
  final DateTime lastSeen;
  final int signalStrength;

  const RFIDModel({
    required this.epc,
    required this.lastSeen,
    required this.signalStrength,
  });

  RFIDModel copyWith({
    String? epc,
    DateTime? lastSeen,
    int? signalStrength,
  }) {
    return RFIDModel(
      epc: epc ?? this.epc,
      lastSeen: lastSeen ?? this.lastSeen,
      signalStrength: signalStrength ?? this.signalStrength,
    );
  }

  RFIDModel.fromMap(Map<String, dynamic> map)
      : epc = map['EPC'],
        lastSeen = DateTime.now(),
        signalStrength = map['PeakRSSI'];

  @override
  List<Object> get props => [epc, lastSeen];
}
