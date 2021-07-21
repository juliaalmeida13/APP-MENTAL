import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  // saving data to SharedPreference
  static Future<void> saveUserInfoToSharedPrefs(user) async {
    String? userEmail = user.email;
    String? userDisplayName = user.displayName;

    saveUserEmailInSharedPreference(userEmail==null?"Anonymous":userEmail);
    saveUserLoggedInSharedPreference(true);
    saveUserNameInSharedPreference(userDisplayName==null?"Anonymous":userDisplayName);
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

  static Future<bool> saveUserEmailInSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey)?? false;
  }

  static Future<String> getUserNameInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey)?? "Empty";
  }

  static Future<String> getUserEmailInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailKey)?? "Empty";
  }
}
