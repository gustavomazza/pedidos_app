import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pedidos_app/Preferences/preferences.dart';
import 'package:pedidos_app/app/config/Config.dart';
import 'package:pedidos_app/app/data/models/pedidos.dart';

class PedidosController {
  static Future<dynamic> getPedidos() async {
    //Pegando url padrão do cliente salvo na memória do aparelho
    var urlApi = new Config();
    var token = Preferences.getToken();

    try {
      final responsePedidos =
          await http.get(Uri.parse(urlApi.urlBase + 'pedidos'), headers: {
        HttpHeaders.authorizationHeader: token,
      });

      var jsonData = jsonDecode(responsePedidos.body);

      if (responsePedidos.statusCode == 200) {
        // List<Pedidos> list = parsePedidos(responsePedidos.body);

        print(jsonData['total'].toString());

        return jsonData;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Pedidos> parsePedidos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pedidos>((json) => Pedidos.fromJson(json)).toList();
  }
}
