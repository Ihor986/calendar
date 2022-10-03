import 'package:calendar/services/text/two_digit_format.dart';

class IncrementYearMonth {
  String call(y, m) {
    final TwoDigitFormat format = TwoDigitFormat();
    final int? month = int.tryParse(m);
    final int? year = int.tryParse(y);

    if (month == null || year == null) return '$y-$m';
    if (month > 11) return '${year + 1}-01';

    return '$y-${format((month + 1).toString())}';
  }
}
