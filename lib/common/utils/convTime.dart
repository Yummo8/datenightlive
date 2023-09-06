// ignore_for_file: file_names, depend_on_referenced_packages
import 'package:intl/intl.dart';

String convTimetoMinSec(double time) {
  int seconds = time ~/ 1000;
  String min = NumberFormat('00').format(seconds ~/ 60);
  String sec = NumberFormat('00').format(seconds % 60);
  String times = "$min:$sec";
  return times;
}
