import 'package:carros_app/widgets/AppText.dart';
import 'package:carros_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:carros_app/utils/nav.dart';

import 'home_page.dart';


class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final tlogin = TextEditingController(text: "Bruno");

  final tsenha = TextEditingController(text: "123");

  final _formkey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros Login",),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            AppText("Login", "Digite o login",
              controller: tlogin,
              validator: _validatorlogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,),
            SizedBox(height: 10.0),
            AppText("Senha", "Digite sua senha",
              password: true,
              controller: tsenha,
              validator: _validatorSenha,
              keyboardType: TextInputType.number,focusNode: _focusSenha,),
            SizedBox(height: 20.0),
            AppButton("Login", onPressed: _onClickLogin),
            SizedBox(height: 18.0),
            Center(
                child: Text(
                  "Criar conta",
                  style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                )),
          ],
        ),
      ),
    );
  }


  _onClickLogin() {
    bool formOk = _formkey.currentState.validate();

    //se o formulario nao for valido nao deixa segui em frente
    if (!formOk) {
      return;
    }

    String login = tlogin.text;
    String senha = tsenha.text;

    push(context,homePage());

  }

  String _validatorlogin(String text) {
    if (text.isEmpty) {
      return "Por favor preencha o campo login";
    } else
      return null;
  }

  String _validatorSenha(String text) {
    if (text.isEmpty) {
      return "Por favor preencha o campo senha";
    }
    if (text.length > 3) {
      return "A senha nao pode ser menor que 3 caracters";
    } else {
      return null;
    }
  }
}
