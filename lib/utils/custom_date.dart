import 'package:intl/intl.dart';

class CustomDate {

  static String now() => DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now());
  static String minimize() => DateFormat("dd-MM-yyyy").format(DateTime.now());
  static String custom(DateTime date) => DateFormat("dd-MM-yyyy").format(date);

}