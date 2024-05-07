// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SocketService on _SocketService, Store {
  late final _$socketAtom =
      Atom(name: '_SocketService.socket', context: context);

  @override
  io.Socket get socket {
    _$socketAtom.reportRead();
    return super.socket;
  }

  bool _socketIsInitialized = false;

  @override
  set socket(io.Socket value) {
    _$socketAtom.reportWrite(value, _socketIsInitialized ? super.socket : null,
        () {
      super.socket = value;
      _socketIsInitialized = true;
    });
  }

  late final _$_SocketServiceActionController =
      ActionController(name: '_SocketService', context: context);

  @override
  void authSocket({required String userToken}) {
    final _$actionInfo = _$_SocketServiceActionController.startAction(
        name: '_SocketService.authSocket');
    try {
      return super.authSocket(userToken: userToken);
    } finally {
      _$_SocketServiceActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
socket: ${socket}
    ''';
  }
}
