import 'package:intl/intl.dart';

String parsehhmmaaddmmmyyyy(DateTime dateTime) {
  return DateFormat('HH:mm:ss dd MMM yyyy').format(dateTime);
}
