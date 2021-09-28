import 'package:flutter/material.dart';
import 'package:pedidos_app/app/ui/Layout.dart';

class EditPedidosPage extends StatelessWidget {
  const EditPedidosPage({key}) : super(key: key);
  static String titleNavBar = '';

  @override
  Widget build(BuildContext context) {
    final content =
        SingleChildScrollView(child: LayoutBuilder(builder: (_, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Colors.orange[200],
      );
    }));

    return Layout.getContent(context, content, titleNavBar);
  }
}
