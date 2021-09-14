import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pedidos_app/config/config.dart';

class LoginController {
  //Verifica se nome e senha estão corretos
  static login(String usuario, String senha) async {
    var urlApi = new Config();

    try {
      Map<String, String> headers = new HashMap();
      headers['Accept'] = 'application/json';
      headers['Content-type'] = 'application/json';
      final response = await http.post(Uri.parse(urlApi.urlBase + 'login'),
          headers: headers,
          body: jsonEncode(
            {"usuario": usuario, "senha": senha},
          ),
          encoding: Encoding.getByName('utf-8'));

      if (response.statusCode == 200) {
        var data = await jsonDecode(response.body);

        return data;
      } else if (response.statusCode == 404) {
        return 'Acesso Negado';
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
