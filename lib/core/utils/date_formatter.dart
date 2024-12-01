import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTimestamp(String timeStamp) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(timeStamp));
  }
}
