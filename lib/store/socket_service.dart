import 'package:carea/constants/app_constants.dart';
import 'package:mobx/mobx.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'socket_service.g.dart';

class SocketService = _SocketService with _$SocketService;

abstract class _SocketService with Store {
  _SocketService() {
    socket = io.io(AppConstants.SOCKET_URL,
                    io.OptionBuilder()
                    .setTransports(['websocket'])
                    .disableAutoConnect()
                    .build());
  }

  @observable
  late io.Socket socket;

  @action
  void authSocket({required String userToken}) {
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer ${userToken}'
    };

  }
} 