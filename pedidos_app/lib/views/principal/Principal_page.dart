import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pedidos_app/Layout.dart';
import 'package:pedidos_app/Preferences/preferences.dart';

class PrincipalPage extends StatefulWidget {
  static String tag = 'principal-page';

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  //variável para o título da navbar
  static String titleNavBar = '';

  DateTime data = new DateTime.now();
  var vendasComb;
  final converteValor = new NumberFormat("#,##0.00", "pt-br");
  // final converteLitros = new NumberFormat("#,###0.000", "pt-br");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.3,
                          width: constraints.maxWidth,
                          // margin: EdgeInsets.only(
                          //     bottom: constraints.maxWidth * 0.05),
                          // padding: EdgeInsets.only(
                          //     top: constraints.maxWidth * 0.02,
                          //     left: constraints.maxWidth * 0.1),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  offset: Offset(0, 2))
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFf45d27),
                                Color(0xFFf5851f),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.1),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Olá',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Preferences.getUsuario().toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.02,
                              ),
                              Container(
                                height: constraints.maxHeight * 0.15,
                                width: constraints.maxWidth * 0.7,
                                padding: EdgeInsets.only(
                                    top: constraints.maxHeight * 0.02,
                                    bottom: constraints.maxHeight * 0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Vendas do mês!',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFf45d27),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'R\$ 1.548,56',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.02,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    return Layout.getContent(context, content, titleNavBar);
  }
}
