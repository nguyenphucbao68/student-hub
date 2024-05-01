class AppConstants {
  // static const String BASE_URL =
  //     'http://192.168.1.2:4400/api'; //local API endpoint aka IPv4 address
  static const String BASE_URL =
      'https://api.studenthub.dev/api'; // deloy API endpoint

  static const String SOCKET_URL = 'https://api.studenthub.dev';
}

enum SOCKET_EVENTS {
  RECEIVE_MESSAGE,
  NOTI,
  ERROR
}