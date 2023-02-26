import 'package:shared_preferences/shared_preferences.dart';

final _languageKey = "Language";
final _apiUrlKey = "ApiUrl";
final _photosUrlKey = "PhotosUrl";
final _isRegisteredKey = "IsRegistered";
final _fullnameKey = "Fullname";
final _uuid = "Uuid";


setUuid(String uuid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(_uuid, uuid);
}

setLanguageValue(String language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(_languageKey, language);
}

setApiUrl(String apiUrl) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(_apiUrlKey, apiUrl);
}

setPhotosUrl(String photosUrl) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(_photosUrlKey, photosUrl);
}

setFullname(String fullname) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(_fullnameKey, fullname);
}

setIsRegistered(bool registered) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setBool(_isRegisteredKey, registered);
}

Future<String> getLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(_languageKey) ?? "";
}

Future<String> getApiUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(_apiUrlKey) ?? "";
}

Future<String> getPhotosUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(_photosUrlKey) ?? "";
}

Future<bool> getIsRegistered() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_isRegisteredKey) ?? false;
}

Future<String> getFullname() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(_fullnameKey) ?? "";
}

Future<String> getUuid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(_uuid) ?? "";
}

