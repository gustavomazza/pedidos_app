import 'package:flutter/material.dart';
import 'package:pedidos_app/Preferences/preferences.dart';
import 'package:pedidos_app/components/NavBar.dart';
import 'package:pedidos_app/views/login/Login_page.dart';

class Layout {
  static BuildContext scaffoldContext;
  // final String title;

  // const Layout({Key key, this.title});

  static Scaffold getContent(BuildContext context, content, title) {
    // final content = SingleChildScrollView(
    return Scaffold(
      appBar: Navbar(
        title: title,
      ),
      drawer: Drawer(
        child: LayoutBuilder(
          builder: (_, constraints) {
            return ListView(
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height / 4.5,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        // Color(0xFFB1F2B36),
                        // Color(0xFFB1F2B36),
                        Color(0xFFf45d27),
                        Color(0xFFf5851f),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Center(
                        child: Icon(Icons.account_circle,
                            color: offWhite(), size: constraints.maxHeight / 8),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Text(
                        Preferences.getUsuario().toUpperCase(),
                        style: TextStyle(
                            color: offWhite(),
                            fontWeight: FontWeight.bold,
                            // fontSize: 22,
                            fontSize: constraints.maxHeight * 0.032,
                            letterSpacing: 4),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton(
                          child: Text(
                            'Sair',
                            style: TextStyle(
                              color: offWhite(),
                              fontSize: constraints.maxHeight * 0.025,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginPage()));
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1,
                        indent: constraints.maxWidth * 0.15,
                        endIndent: constraints.maxWidth * 0.15,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      Container(
                        padding:
                            EdgeInsets.only(left: constraints.maxWidth * 0.1),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pedidos',
                            style: TextStyle(
                                color: Colors.white,
                                // fontSize: 20,
                                fontSize: constraints.maxHeight * 0.032,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: constraints.maxWidth * 0.2),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                // style: ButtonStyle(TextStyle(color: Colors.green)),

                                child: Text(
                                  'Lista',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxHeight * 0.025,
                                      fontWeight: FontWeight.w400),
                                ),
                                onPressed: () {},
                                // onPressed: () => {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (BuildContext context) =>
                                //               AfericaoPage())),
                                // },
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: TextButton(
                                // style: ButtonStyle(TextStyle(color: Colors.green)),

                                child: Text(
                                  '+ Novo Pedido',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxHeight * 0.025,
                                      fontWeight: FontWeight.w400),
                                ),
                                onPressed: () {},
                                // onPressed: () => {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (BuildContext context) =>
                                //               Agenda_precoPage())),
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          Layout.scaffoldContext = context;

          return content;
        },
      ),
    );
  }

  //PADRÃO DE CORES
  static Color darkOrange({double opacity = 1}) =>
      Color(0xFFf45d27); //Laranja escuro

  static Color orange({double opacity = 1}) =>
      Color(0xFFf5851f); //Laranja claro

  static Color blue({double opacity = 1}) =>
      Color.fromRGBO(100, 147, 165, opacity); //Azul

  static Color DarkBlue({double opacity = 1}) =>
      Color.fromRGBO(21, 30, 61, opacity); //Azul Escuro

  static Color gray({double opacity = 1}) =>
      Color.fromRGBO(87, 89, 91, opacity); //Cinza escuro

  static Color yellow({double opacity = 1}) =>
      Color.fromRGBO(242, 207, 98, opacity); //Amarelo

  static Color darkYellow({double opacity = 1}) =>
      Color.fromRGBO(242, 191, 98, opacity);

  static Color offWhite({double opacity = 1}) =>
      Color.fromRGBO(242, 242, 242, opacity);
}
