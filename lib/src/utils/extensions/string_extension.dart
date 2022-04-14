extension StringHelper on String {
  String replaceCharAt(int index, String newChar) =>
      substring(0, index) + newChar + substring(index + 1);

  bool get isNumeric => int.tryParse(this) != null;

  bool get isEmail => RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      ).hasMatch(this);

  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  bool get isAlphaNumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  bool Function(String expected) get containsSubstring => (String expected) =>
      expected.contains(RegExp(expected, caseSensitive: false));
}
