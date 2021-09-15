import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pedidos_app/Layout.dart';
import 'package:pedidos_app/Preferences/preferences.dart';
import 'package:pedidos_app/controllers/PedidosController.dart';

import 'package:pedidos_app/models/pedidos.dart';

class PrincipalPage extends StatefulWidget {
  static String tag = 'principal-page';

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  //variável para o título da navbar
  static String titleNavBar = '';
  var pedidos;
  final converteNumBr = new NumberFormat("#,##0.00", "pt-br");

  @override
  void initState() {
    PedidosController.getPedidos().then((pedidosFromServer) {
      setState(() {
        pedidos = pedidosFromServer;
        print(pedidos);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(builder: (_, constraints) {
          return FutureBuilder(
            future: PedidosController.getPedidos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //Verifica se retornou erro
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro!'),
                );
                //verifica se ainda não teve retorno
              } else if (snapshot.data == null) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight / 2.5),
                      CircularProgressIndicator(),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Text(
                        'Aguarde... Buscando pedidos!',
                        style:
                            TextStyle(fontSize: constraints.maxHeight * 0.020),
                      )
                    ],
                  ),
                );
                //verifica se teve retorno
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    //área de pesquisa
                    Container(
                      height: constraints.maxHeight * 0.27,
                      width: constraints.maxWidth,
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
                            height: constraints.maxHeight * 0.12,
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
                                    fontSize: constraints.maxHeight * 0.03,
                                    color: Color(0xFFf45d27),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'R\$ ' +
                                      converteNumBr.format(double.parse(
                                          snapshot.data['total'].toString())),
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
                    //fim área de pesquisa
                    SizedBox(
                      height: constraints.maxHeight * 0.02,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.65,
                      width: constraints.maxWidth,
                      child: ListView.builder(
                        padding: EdgeInsets.all(constraints.maxHeight * 0.015),
                        itemCount: snapshot.data.length == null
                            ? 0
                            : snapshot.data['pedidosClientes'].length,
                        itemBuilder: (BuildContext context, index) {
                          return Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: constraints.maxHeight * 0.15,
                                  width: constraints.maxWidth * 0.92,
                                  padding: EdgeInsets.all(
                                      constraints.maxWidth * 0.02),
                                  margin: EdgeInsets.only(
                                      bottom: constraints.maxHeight * 0.03),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 3,
                                      )
                                    ],
                                    color: Layout.offWhite(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Pedido: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          0.02,
                                                  fontWeight: FontWeight.bold),
                                              // color: Colors.white),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              snapshot.data['pedidosClientes']
                                                      [index]['id_pedido']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.02,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Cliente: ',

                                              style: TextStyle(
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          0.02,
                                                  fontWeight: FontWeight.bold),
                                              // color: Colors.white),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              snapshot.data['pedidosClientes']
                                                      [index]['nome']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.02,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Total: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          0.02,
                                                  fontWeight: FontWeight.bold),
                                              // color: Colors.white),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              'R\$ ' +
                                                  converteNumBr
                                                      .format(double.parse(snapshot
                                                                  .data[
                                                              'pedidosClientes']
                                                          [
                                                          index]['valor_total']))
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.02,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              //estava dando uma advertencia sem esse return
              return this.widget;
            },
          );
        }),
      ),
    );

    // final content = SingleChildScrollView(
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Container(
    //           height: MediaQuery.of(context).size.height * 0.9,
    //           width: MediaQuery.of(context).size.width,
    //           child: LayoutBuilder(
    //             builder: (_, constraints) {
    //               return SingleChildScrollView(
    //                 child: Column(
    //                   children: [
    //                     Container(
    //                       height: constraints.maxHeight * 0.3,
    //                       width: constraints.maxWidth,
    //                       decoration: BoxDecoration(
    //                         boxShadow: [
    //                           BoxShadow(
    //                               color: Colors.black54,
    //                               blurRadius: 5,
    //                               offset: Offset(0, 2))
    //                         ],
    //                         gradient: LinearGradient(
    //                           begin: Alignment.topCenter,
    //                           end: Alignment.bottomCenter,
    //                           colors: [
    //                             Color(0xFFf45d27),
    //                             Color(0xFFf5851f),
    //                           ],
    //                         ),
    //                         borderRadius: BorderRadius.only(
    //                           bottomRight: Radius.circular(100),
    //                           bottomLeft: Radius.circular(100),
    //                         ),
    //                       ),
    //                       child: Column(
    //                         children: [
    //                           Container(
    //                             margin: EdgeInsets.only(
    //                                 left: constraints.maxWidth * 0.1),
    //                             child: Column(
    //                               children: [
    //                                 Align(
    //                                   alignment: Alignment.topLeft,
    //                                   child: Text(
    //                                     'Olá',
    //                                     style: TextStyle(
    //                                         fontSize: 20, color: Colors.white),
    //                                   ),
    //                                 ),
    //                                 Align(
    //                                   alignment: Alignment.topLeft,
    //                                   child: Text(
    //                                     Preferences.getUsuario().toUpperCase(),
    //                                     style: TextStyle(
    //                                         fontWeight: FontWeight.bold,
    //                                         fontSize: 22,
    //                                         color: Colors.white),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: constraints.maxHeight * 0.02,
    //                           ),
    //                           Container(
    //                             height: constraints.maxHeight * 0.15,
    //                             width: constraints.maxWidth * 0.7,
    //                             padding: EdgeInsets.only(
    //                                 top: constraints.maxHeight * 0.02,
    //                                 bottom: constraints.maxHeight * 0.02),
    //                             decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(15),
    //                               color: Colors.white,
    //                             ),
    //                             child: Column(
    //                               children: [
    //                                 Text(
    //                                   'Vendas do mês!',
    //                                   style: TextStyle(
    //                                     fontSize: 20,
    //                                     color: Color(0xFFf45d27),
    //                                   ),
    //                                 ),
    //                                 Spacer(),
    //                                 Text(
    //                                   'R\$ 1.548,56',
    //                                   style: TextStyle(
    //                                     fontSize: 20,
    //                                     color: Colors.black,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: constraints.maxHeight * 0.02,
    //                     ),
    //                     //Lista de Pedidos
    //                     Container(
    //                       height: constraints.maxHeight,
    //                       width: constraints.maxWidth,
    //                       // color: Colors.grey,
    //                       child: ListView.builder(
    //                         // padding: const EdgeInsets.all(16),
    //                         padding:
    //                             EdgeInsets.all(constraints.maxHeight * 0.025),
    //                         itemCount:
    //                             pedidos.length == null ? 0 : pedidos.length,
    //                         itemBuilder: (BuildContext context, index) {
    //                           return GestureDetector(
    //                             child: Container(
    //                               height: constraints.maxHeight * 0.11,
    //                               width: constraints.maxWidth * 0.86,
    //                               padding: EdgeInsets.all(
    //                                   constraints.maxHeight * 0.02),
    //                               margin: EdgeInsets.only(
    //                                   bottom: constraints.maxHeight * 0.01),
    //                               decoration: BoxDecoration(
    //                                   color: Colors.green,
    //                                   borderRadius: BorderRadius.circular(10)),
    //                               child: Center(
    //                                 child: Column(
    //                                   children: [
    //                                     Text(
    //                                       pedidos[index].nome.toString(),
    //                                       style: TextStyle(
    //                                           fontSize:
    //                                               constraints.maxHeight * 0.027,
    //                                           color: Colors.green),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                             onTap: () {},
    //                           );
    //                         },
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Layout.getContent(context, content, titleNavBar);
  }
}
