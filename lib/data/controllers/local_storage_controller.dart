import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/core/utils/app_logger.dart';

class LocalStorageController extends GetxController{
  static SharedPreferences? _preferences;

  static const String token = 'TOKEN';
  static const String uid = 'UID';
  static const String refreshToken = 'REFRESH_TOKEN';
  static const String locale = 'LOCALE';

  @override
  void onInit() async{
    _preferences ??= await SharedPreferences.getInstance();
    super.onInit();
  }


  String get appLocale => _getFromDisk(locale) ?? 'en';

  set appLocale(String value) => _saveToDisk(locale, value);

  String get userToken => _getFromDisk(token) ?? '';

  set userToken(String value) => _saveToDisk(token, value);

  String get userRefreshToken => _getFromDisk(refreshToken) ?? '';

  set userRefreshToken(String value) => _saveToDisk(refreshToken, value);

  String get userId => _getFromDisk(uid) ?? '';

  set userId(String value) => _saveToDisk(uid, value);

  bool get isUserLogged => userToken.isNotEmpty;

  void saveUserTokens(
      {required String token,
      required String refreshToken,
      required String uid}) {
    userToken = token;
    userRefreshToken = refreshToken;
    userId = uid;
  }

  // User? get user {
  //   var userJson = _getFromDisk(USER_KEY);
  //   if (userJson == null) {
  //     return null;
  //   }
  //
  //   return User.fromJson(json.decode(userJson));
  // }
  //
  // set user(User? userToSave) {
  //   _saveToDisk(USER_KEY, json.encode(userToSave!.toJson()));
  // }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    AppLogger().debug('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    AppLogger().debug('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }
}
