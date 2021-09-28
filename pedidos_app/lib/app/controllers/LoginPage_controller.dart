import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedidos_app/Preferences/preferences.dart';
import 'package:pedidos_app/app/data/provider/LoginProvider.dart';
import 'package:pedidos_app/app/data/models/usuario.dart';

class LoginPageController extends GetxController {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cUsuario = TextEditingController();
  final TextEditingController _cSenha = TextEditingController();

  get scaffoldkey => this._scaffoldKey;
  // set scaffoldkey(value) => this._scaffoldKey = value;

  get formkey => this._formKey;
  // set formkey(value) => this._formKey = value;

  get cUsuario => this._cUsuario;
  set cUsuario(value) => this._cUsuario.value = value;

  get cSenha => this._cSenha;
  set cSenha(value) => this._cSenha.value = value;

  BuildContext get context => null;

  void login(_cUsuario, _cSenha) async {
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
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text('Acesso Negado'), backgroundColor: Colors.red));
    } else {
      await Preferences.setUsuario(statusLogin['nome']);
      print(Preferences.getUsuario);
      await Preferences.setToken('Bearer ' + statusLogin['token']);
      print('token ' + Preferences.getToken().toString());
      Get.toNamed('/home');
    }
  }

  void validacao() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Existem dados em branco!'),
        backgroundColor: Colors.red));
  }
}
