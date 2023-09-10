import 'dart:math';
import 'package:DNL/common/widgets/multi_select/helpers/extensions.dart';

double getJaro(String a, String b, {bool caseSensitive = false}) {
  final s = caseSensitive ? a : a.toLowerCase();
  final t = caseSensitive ? b : b.toLowerCase();

  final int sLen = s.length;
  final int tLen = t.length;

  if (sLen == 0 && tLen == 0) return 1;

  final int matchDistance = (max(sLen, tLen) / 2 - 1).toInt();

  final List<bool> sMatches = List<bool>.filled(sLen, false);
  final List<bool> tMatches = List<bool>.filled(tLen, false);

  int matches = 0;
  int transpositions = 0;

  for (int i = 0; i < sLen; i++) {
    final int start = max(0, i - matchDistance);
    final int end = min(i + matchDistance + 1, tLen);

    for (int j = start; j < end; j++) {
      if (tMatches[j]) continue;
      if (s.charAt(i) != t.charAt(j)) continue;
      sMatches[i] = true;
      tMatches[j] = true;
      matches++;
      break;
    }
  }

  if (matches == 0) return 0;

  int k = 0;
  for (int i = 0; i < sLen; i++) {
    if (!sMatches[i]) continue;
    while (!tMatches[k]) {
      k++;
    }
    if (s.charAt(i) != t.charAt(k)) transpositions++;
    k++;
  }

  return ((matches / sLen) +
          (matches / tLen) +
          ((matches - transpositions / 2.0) / matches)) /
      3.0;
}
