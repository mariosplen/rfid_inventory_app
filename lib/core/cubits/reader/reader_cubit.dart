import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rfid_inventory_app/core/models/rfid_model.dart';
import 'package:validator_regex/validator_regex.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit() : super(ReaderState.initial());

  StreamSubscription<dynamic>? _streamSubscription;
  WebSocketChannel? _socketChannel;
  Timer? _pingTimer;
  Timer? _garbageCollector;

  Future<void> connect() async {
    final (addressError, portError) = validate();
    if (addressError != null || portError != null) {
      emit(state.copyWith(addressError: addressError, portError: portError));
      return;
    }
    try {
      emit(state.copyWith(status: ReaderStatus.connecting));

      _socketChannel = WebSocketChannel.connect(
        Uri.parse('ws://${state.address}:${state.port}'),
      );
      await _socketChannel?.ready.timeout(const Duration(seconds: 10));

      emit(state.copyWith(status: ReaderStatus.connected));

      _pingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        _socketChannel?.sink.add('');
      });

      _garbageCollector = Timer.periodic(const Duration(seconds: 10), (timer) {
        final newTags = state.tagsFound
            .where(
              (tag) => DateTime.now().difference(tag.lastSeen).inSeconds < 6,
            )
            .toList();
        if (newTags.length != state.tagsFound.length) {
          emit(state.copyWith(tagsFound: newTags));
        }
      });

      _streamSubscription = _socketChannel?.stream.listen(
        (data) {
          final Map<String, dynamic> mapData = jsonDecode(data);
          final newTags = mapData['tags']
              .map<RFIDModel>((tag) => RFIDModel.fromMap(tag))
              .toList();
          final newFoundItems = [...state.tagsFound];
          for (final newTag in newTags) {
            final index =
                newFoundItems.indexWhere((tag) => tag.epc == newTag.epc);
            if (index != -1) {
              newFoundItems[index] = newTag;
            } else {
              newFoundItems.add(newTag);
            }
          }
          emit(state.copyWith(tagsFound: newFoundItems));
        },
        onDone: () {
          closeControllers();
          emit(
            state.copyWith(
              connectionError: 'Connection closed',
              status: ReaderStatus.disconnected,
              tagsFound: const [],
            ),
          );
        },
        onError: (e) {
          closeControllers();
          emit(
            state.copyWith(
              connectionError: e.toString(),
              status: ReaderStatus.disconnected,
              tagsFound: const [],
            ),
          );
        },
      );
    } catch (e) {
      closeControllers();
      emit(
        state.copyWith(
          connectionError: e.toString(),
          status: ReaderStatus.disconnected,
          tagsFound: const [],
        ),
      );
    }
  }

  void removeTag(RFIDModel tag) {
    final newTags = [...state.tagsFound];
    newTags.removeWhere((element) => element.epc == tag.epc);
    emit(state.copyWith(tagsFound: newTags));
  }

  (String? addressError, String? portError) validate() {
    String? addressError;
    String? portError;
    if (state.address.trim().isEmpty) {
      addressError = 'Address cannot be empty';
    }
    if (state.port.trim().isEmpty) {
      portError = 'Port cannot be empty';
    }

    if (!Validator.ipAddress(state.address.trim()) &&
        state.address.trim().isNotEmpty) {
      addressError = 'Invalid Address';
    }

    if (!Validator.digits(state.port.trim()) && state.port.trim().isNotEmpty) {
      portError = 'Invalid Port';
    }

    return (addressError, portError);
  }

  void disconnect() async {
    _streamSubscription?.cancel();
    _socketChannel?.sink.close();
    _pingTimer?.cancel();
    _garbageCollector?.cancel();
    emit(
      state.copyWith(
        status: ReaderStatus.disconnected,
        tagsFound: const [],
      ),
    );
  }

  void onAddressChanged(String address) {
    emit(state.copyWith(address: address, portError: state.portError));
  }

  void onPortChanged(String port) {
    emit(state.copyWith(port: port, addressError: state.addressError));
  }

  void setHandledDisconnectFlag(bool value) {
    emit(state.copyWith(handledDisconnect: value));
  }

  Future<void> closeControllers() async {
    _streamSubscription?.cancel();
    _socketChannel?.sink.close();
    _garbageCollector?.cancel();
    _pingTimer?.cancel();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _socketChannel?.sink.close();
    _pingTimer?.cancel();
    _garbageCollector?.cancel();
    return super.close();
  }

  void demoConnect() {
    emit(state.copyWith(status: ReaderStatus.connected));

    _garbageCollector = Timer.periodic(const Duration(seconds: 10), (timer) {
      final newTags = state.tagsFound
          .where(
            (tag) => DateTime.now().difference(tag.lastSeen).inSeconds < 3,
          )
          .toList();
      if (newTags.length != state.tagsFound.length) {
        emit(state.copyWith(tagsFound: newTags));
      }
    });

    final Map<String, int> tagsChance = {
      '300833B2DD00000000000001': 100,
      '300833B2DD00000000000002': 90,
      '300833B2DD00000000000003': 80,
      '300833B2DD00000000000004': 50,
      '300833B2DD00000000000005': 30,
    };

    Timer.periodic(const Duration(seconds: 3), (timer) {
      final List<RFIDModel> tagsGot = [];
      final time = DateTime.now();
      tagsChance.forEach((key, value) {
        if (Random().nextInt(100) < value) {
          tagsGot.add(RFIDModel(epc: key, lastSeen: time, signalStrength: 1));
        }
      });
      final newFoundItems = [...state.tagsFound];
      for (final newTag in tagsGot) {
        final index = newFoundItems.indexWhere((tag) => tag.epc == newTag.epc);
        if (index != -1) {
          newFoundItems[index] = newTag;
        } else {
          newFoundItems.add(newTag);
        }
      }
      emit(state.copyWith(tagsFound: newFoundItems));
    });
  }
}
