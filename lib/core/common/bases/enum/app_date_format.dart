enum AppDateFormat {
  yearMonthDay('yyyy-MM-dd'),
  dayMonthYear('dd/MM/yyyy'),
  hourMinute('HH:mm'),
  monthYear('MM/yyyy'),
  dayMonthYearHourMinute('dd/MM/yyyy HH:mm'),
  dayMonthLineHourMinute('dd/MM - HH:mm'),
  dayMonthSpaceHourMinute('dd/MM HH:mm'),
  dayMonth('dd/MM'),
  dayMonthYearHourMinuteSecond('dd/MM/yyyy HH:mm:ss'),
  dayMonthYearHourMinuteSecondMilliSecond('dd/MM/yyyy HH:mm:ss.SSS');

  const AppDateFormat(this.formatString);

  final String formatString;
}
