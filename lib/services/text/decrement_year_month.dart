import 'package:calendar/services/text/two_digit_format.dart';

class DecrementYearMonth {
  final TwoDigitFormat format = TwoDigitFormat();
  String call(y, m) {
    final int? month = int.tryParse(m);
    final int? year = int.tryParse(y);

    if (month == null || year == null) return '$y-$m';
    if (month == 1) return '${year - 1}-12';

    return '$y-${format((month - 1).toString())}';
  }
}
