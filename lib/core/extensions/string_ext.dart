const vietnameseChars = '\u00C0-\u1EF9';
const searchInputPattern = '[0-9a-zA-Z$vietnameseChars ]';

extension NullableStringExt on String? {
  bool get isNullOrEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }

  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension StringExt on String {
  String get toSentenceCase {
    return length > 0
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toSentenceCase)
      .join(' ');
}
