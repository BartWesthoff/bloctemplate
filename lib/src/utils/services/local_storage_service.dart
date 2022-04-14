import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static String languageKey = "EN";
  static const onboardingCompleteKey = 'ONBOARDINGCOMPLETE';

  LocalStorageService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  String getLanguage() {
    final String? language = sharedPreferences.getString(languageKey);
    if (language == null) {
      throw Exception("Could not get language.");
    }
    return language;
  }

  Future<bool> setLanguage(String language) async {
    return sharedPreferences.setString(languageKey, language);
  }

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  bool isOnboardingComplete() {
    final bool? isOnboardingComplete =
        sharedPreferences.getBool(onboardingCompleteKey);
    if (isOnboardingComplete == null) {
      throw Exception("Could not get isOnboardingComplete.");
    }
    return isOnboardingComplete;
  }
}
