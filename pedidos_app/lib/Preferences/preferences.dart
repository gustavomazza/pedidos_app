import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //Cria o atributo _preferences
  static SharedPreferences _preferences;

  //Instancia a classe Preferences
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //método para salvar o usuário logado
  static Future setUsuario(String usuario) async {
    await _preferences.setString('_usuario', usuario);
  }

  //método para pegar o usuário padrão que está salvo no aparelho
  static String getUsuario() {
    return _preferences.getString('_usuario');
  }

  //método para salvar o Token gerado pela api
  static Future setToken(String token) async {
    await _preferences.setString('_token', token);
  }

  //método para pegar o token salvo no aparelho
  static String getToken() {
    return _preferences.getString('_token');
  }
}
