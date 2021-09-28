import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedidos_app/Preferences/preferences.dart';
import 'package:pedidos_app/app/data/provider/LoginProvider.dart';
import 'package:pedidos_app/app/data/models/usuario.dart';
import 'package:pedidos_app/app/ui/android/principal/Principal_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cUsuario = TextEditingController();
  final TextEditingController _cSenha = TextEditingController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  void _login(_cUsuario, _cSenha) async {
    //criando a instancia da classe Usuario
    Usuario newUsuario = Usuario();

    //A partir daqui é verificado usuário e senha utilizando a url padrão do cliente que foi salva
    newUsuario.usuario = _cUsuario.toString();
    newUsuario.senha = _cSenha.toString();

    //Chamando LoginController para verificar usuário e senha
    final statusLogin =
        await LoginProvider.login(newUsuario.usuario, newUsuario.senha);

    //Verificando resposta da api
    if (statusLogin == 'Acesso Negado') {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Acesso Negado'), backgroundColor: Colors.red));
    } else {
      await Preferences.setUsuario(statusLogin['nome']);
      print(Preferences.getUsuario);
      await Preferences.setToken('Bearer ' + statusLogin['token']);
      print('token ' + Preferences.getToken().toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PrincipalPage()));
    }
  }

  void validacao() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Existem dados em branco!'),
        backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    final inputUsuario = TextFormField(
      controller: _cUsuario,
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        // prefixIcon: Icon(Icons.verified_user),
        hintText: 'Vendedor',
      ),
    );

    final inputSenha = TextFormField(
      controller: _cSenha,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        // prefixIcon: Icon(Icons.vpn_key),
        hintText: 'Senha',
      ),
    );

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      //O SingleChildScrollView faz com que ao abrir o teclado não ocorra o erro de Bottom overflowed
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          // color: Colors.black,
          // decoration: BoxDecoration(color: Colors.blue[200]),
          child: LayoutBuilder(builder: (_, constraints) {
            return Column(
              children: <Widget>[
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight / 2.5,
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
                      bottomLeft: Radius.circular(150),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Spacer(),
                      Text(
                        'TMD',
                        style: TextStyle(
                          // fontSize: 40,
                          fontSize: constraints.maxHeight * 0.05,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Distribuidora',
                        style: TextStyle(
                          // fontSize: 40,
                          fontSize: constraints.maxHeight * 0.035,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.03,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add_shopping_cart,
                          // size: 120,
                          size: constraints.maxHeight * 0.10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                //Conteúdo fora da parte laranja
                Form(
                  key: _formKey,
                  child: Container(
                    // padding: EdgeInsets.only(top: 60),
                    padding: EdgeInsets.only(top: constraints.maxHeight * 0.15),
                    child: Column(
                      children: <Widget>[
                        Container(
                          // width: MediaQuery.of(context).size.width / 1.4,
                          alignment: Alignment.center,
                          width: constraints.maxWidth * 0.70,
                          height: constraints.maxHeight * 0.06,
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.07,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          //INPUT USUARIO
                          child: inputUsuario,
                        ),
                        //FIM DO SEGUNDO INPUT
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width / 1.4,
                          alignment: Alignment.center,
                          width: constraints.maxWidth * 0.70,
                          height: constraints.maxHeight * 0.06,
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.07,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          //INPUT SENHA
                          child: inputSenha,
                        ),
                        //FIM DO TERCEIRO INPUT
                        SizedBox(
                          height: constraints.maxHeight * 0.15,
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width / 1.4,
                          width: constraints.maxWidth * 0.70,
                          height: constraints.maxHeight * 0.06,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5,
                                  offset: Offset(0, 2))
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xFFf45d27),
                                Color(0xFFf5851f),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(150),
                          ),
                          child: SizedBox.expand(
                            child: FlatButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Entrar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      // fontSize: 20,
                                      fontSize: constraints.maxHeight * 0.025,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              onPressed: () => {
                                if (_cUsuario.text.isEmpty ||
                                    _cSenha.text.isEmpty)
                                  {
                                    validacao(),
                                  }
                                else
                                  {
                                    _login(_cUsuario.text.toUpperCase(),
                                        _cSenha.text),
                                  }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.04,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Copyright (c) 2021 - TMD LTDA",
                            style: TextStyle(
                                fontSize: constraints.maxHeight * 0.015),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ), //fim do body
    );
  }
}
