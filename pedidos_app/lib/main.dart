import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pedidos_app/app/routes/app_pages.dart';
import 'package:pedidos_app/app/routes/app_routes.dart';
import 'package:pedidos_app/app/ui/android/principal/Principal_page.dart';

import 'Preferences/preferences.dart';

void main() async {
  //Precisa colocar WidgetsFlutterBinding.ensureInitialized() para funcionar o Preferences
  WidgetsFlutterBinding.ensureInitialized();
  //cria a instancia
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final routes = <String, WidgetBuilder>{
  //   PrincipalPage.tag: (context) => PrincipalPage(),
  //   // VendasComb.tag: (context) => VendasComb(),
  // };

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      title: 'Admin',
      initialRoute: Routes.LOGIN,
      // home: LoginPage(),
      // routes: routes,
    );
  }
}
