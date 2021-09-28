import 'package:get/get.dart';
import 'package:pedidos_app/app/routes/app_routes.dart';
import 'package:pedidos_app/app/ui/android/login/Login_page.dart';
import 'package:pedidos_app/app/ui/android/pedidos/edit_pedidos.dart';
import 'package:pedidos_app/app/ui/android/principal/Principal_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.INITIAL, page: () => null),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.HOME, page: () => PrincipalPage()),
    GetPage(name: Routes.EDITPEDIDOS, page: () => EditPedidosPage()),
  ];
}
