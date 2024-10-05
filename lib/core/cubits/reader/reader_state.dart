part of 'reader_cubit.dart';

enum ReaderStatus { disconnected, connecting, connected }

class ReaderState extends Equatable {
  final String address;
  final String port;
  final ReaderStatus status;
  final List<RFIDModel> tagsFound;
  final bool handledDisconnect;
  final String? addressError;
  final String? portError;
  final String? connectionError;

  const ReaderState({
    required this.address,
    required this.port,
    required this.status,
    required this.tagsFound,
    required this.handledDisconnect,
    this.addressError,
    this.portError,
    this.connectionError,
  });

  factory ReaderState.initial() {
    return const ReaderState(
      address: '',
      port: '',
      status: ReaderStatus.disconnected,
      handledDisconnect: false,
      tagsFound: [],
    );
  }

  ReaderState copyWith({
    String? address,
    String? port,
    ReaderStatus? status,
    List<RFIDModel>? tagsFound,
    bool? handledDisconnect,
    String? addressError,
    String? portError,
    String? connectionError,
  }) {
    return ReaderState(
      address: address ?? this.address,
      port: port ?? this.port,
      status: status ?? this.status,
      tagsFound: tagsFound ?? this.tagsFound,
      handledDisconnect: handledDisconnect ?? this.handledDisconnect,
      addressError: addressError,
      portError: portError,
      connectionError: connectionError,
    );
  }

  @override
  List<Object?> get props => [
        address,
        port,
        status,
        tagsFound,
        handledDisconnect,
        addressError,
        portError,
        connectionError,
      ];
}
