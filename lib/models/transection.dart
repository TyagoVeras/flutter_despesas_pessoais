import 'package:flutter/foundation.dart';
//importação para colocar os atributos como required

class Transection {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transection(
      {@required this.id,
      @required this.title,
      @required this.value,
      @required this.date});
}
