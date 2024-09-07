import 'package:intl/intl.dart';

String formatTime(DateTime time) {
  return DateFormat('dd MM yyyy').format(time);
}
