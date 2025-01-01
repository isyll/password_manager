extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}

extension StringUtilsExtension on String {
  String lcfirst() {
    if (trim().isEmpty) return this;
    final index = indexOf(RegExp(r'\S'));
    return replaceCharAt(index, this[index].toLowerCase());
  }

  String replaceCharAt(int index, String newChar) {
    return substring(0, index) + newChar + substring(index + 1);
  }

  String ucfirst() {
    if (trim().isEmpty) return this;
    final index = indexOf(RegExp(r'\S'));
    return replaceCharAt(index, this[index].toUpperCase());
  }
}
