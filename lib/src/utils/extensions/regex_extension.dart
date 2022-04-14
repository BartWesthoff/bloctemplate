//https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a?page=1&tab=votes#tab-top

enum PasswordStrength { casesensitive, specialcharacter, number }

extension StringExtension on String {
  bool password(List<PasswordStrength> input) {
    bool valid = false;
    if (input.contains(PasswordStrength.casesensitive)) {
      valid = RegExp(r'([A-Z])\w+').hasMatch(this);
    }
    if (input.contains(PasswordStrength.specialcharacter)) {
      valid = RegExp(r"[.!?\\-]").hasMatch(this);
    }
    if (input.contains(PasswordStrength.number)) {
      valid = RegExp(r"\d").hasMatch(this);
    }

    return valid;
  }
}
