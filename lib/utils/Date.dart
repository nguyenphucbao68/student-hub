// Date Handler Class
import 'package:intl/intl.dart';

class DateHandler {
  // Get Current Date
  static String getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  // Get Current Time
  static String getCurrentTime() {
    return DateFormat('HH:mm:ss').format(DateTime.now());
  }

  // Get Current Date Time
  static String getCurrentDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  // Get Date Time
  static String getDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  // Get Date
  static String getDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  // Get Time
  static String getTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  // Get Date Time Difference
  static String getDateTimeDifference(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
