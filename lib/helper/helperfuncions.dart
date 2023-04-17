import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceUserJwtTokenKey = "USERJWTTOKENKEY";
  static String sharedPreferenceUserRememberMe = "REMEMBERME";

  // saving data to SharedPreference
  static Future<void> saveUserInfoToSharedPrefs(user) async {
    String? userEmail = user.email;
    String? userDisplayName = user.name;
    //String? userJwtToken = user.jwtToken;

    saveUserEmailInSharedPreference(userEmail!);
    saveUserLoggedInSharedPreference(true);
    saveUserNameInSharedPreference(userDisplayName!);
    //saveUserJwtTokenInSharedPreference(userJwtToken!);
  }

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameInSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserJwtTokenInSharedPreference(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserJwtTokenKey, token);
  }

  static Future<bool> saveUserEmailInSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey) ?? "Empty";
  }

  static Future<String> getUserEmailInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailKey) ?? "Empty";
  }

  static Future<String> getUserJwtTokenInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserJwtTokenKey) ?? "Empty";
  }

  static Future<Map> getUserNameAndEmailInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map user = {
      'name': prefs.getString(sharedPreferenceUserNameKey),
      'email': prefs.getString(sharedPreferenceUserEmailKey)
    };
    return user;
  }

  static Future<bool> clearUserInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(sharedPreferenceUserLoggedInKey);
  }

  static Future<void> saveUserInfoToSharedPrefsRememberMe(
      String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .setStringList(sharedPreferenceUserRememberMe, [email, password]);
  }

  static Future<List<String>> getUserRememberMeInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(sharedPreferenceUserRememberMe) ?? [];
  }

  static Future<void> removeRememberMeInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(sharedPreferenceUserRememberMe);
  }
}
