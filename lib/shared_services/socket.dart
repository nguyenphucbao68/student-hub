import 'package:carea/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  io.Socket getSocket(String token) {
    io.Socket socket = io.io(
        AppConstants.SOCKET_URL,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    SharedPreferences.getInstance().then((value) {
      socket.io.options?['extraHeaders'] = {
        'Authorization': 'Bearer ${token}',
      };

      return socket;
    });

    return socket;
  }
}
