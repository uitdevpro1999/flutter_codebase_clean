import 'package:easy_localization/easy_localization.dart';

const currencyWithCommaAsSeparatorPattern = '#,##0đ';
const numberWithCommaAsSeparatorPattern = '#,##0';

extension NumberExtensions on num? {
  String? moneyFormat({String pattern = currencyWithCommaAsSeparatorPattern}) {
    return customFormat(pattern: pattern);
  }

  String? customFormat({String pattern = numberWithCommaAsSeparatorPattern}) {
    if (this == null) return null;
    return NumberFormat(pattern).format(this);
  }
}
