import 'package:flutter/material.dart';
import 'package:pedidos_app/views/login/Login_page.dart';
import 'package:pedidos_app/views/principal/Principal_page.dart';

import 'Preferences/preferences.dart';

void main() async {
  //Precisa colocar WidgetsFlutterBinding.ensureInitialized() para funcionar o Preferences
  WidgetsFlutterBinding.ensureInitialized();
  //cria a instancia
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    PrincipalPage.tag: (context) => PrincipalPage(),
    // VendasComb.tag: (context) => VendasComb(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Fim calendário como português
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      // theme: ThemeData(
      //   primarySwatch: Layout.blue(),
      // ),
      home: LoginPage(),

      routes: routes,
    );
  }
}
