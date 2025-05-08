import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;
  String uid = "";
  final String hourKey = "HOURKEY";
  final String hourActivationKey = "HOURACTIVATIONKEY";

  String? get hour => _prefs!.getString(uid + hourKey);
  set hour (String? value) => _prefs!.setString(uid + hourKey, value??"08:00");

  bool? get hourActivation => _prefs!.getBool(uid + hourActivationKey);
  set hourActivation (bool? value) => _prefs!.setBool(uid + hourActivationKey, value??true);

  /// Inicializa SharedPreferences (llamar antes de usar)
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    uid = FirebaseAuth.instance.currentUser?.uid??"";
  }

  /// Elimina una clave
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// Limpia todas las claves
  Future<void> clear() async {
    await _prefs?.clear();
  }
}