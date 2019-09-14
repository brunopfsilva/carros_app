import 'dart:async';

import 'package:carros_app/login/login_bloc.dart';
import 'package:carros_app/settings.dart';

import 'package:carros_app/login/Usuario.dart';
import 'package:carros_app/pages/home_page.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final tlogin = TextEditingController();

  final tsenha = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  bool _showProgress = false;

  final _bloc = loginBloc();

  @override
  void initState() {
    super.initState();

    Future<Usuario> future = Usuario.get();
    //este future aguarda o objecto Usuario como resultado
    future.then((Usuario user) {
      //mantem o usuario logado
      if (user != null) {
        replace(context, homePage(user));
      }

      /*  setState(() {
        tlogin.text = user.login;
      });

*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Carros Login",
        ),
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
            AppText(
              "Login",
              "Digite o login",
              controller: tlogin,
              validator: _validatorlogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10.0),
            AppText(
              "Senha",
              "Digite sua senha",
              password: true,
              controller: tsenha,
              validator: _validatorSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            SizedBox(height: 20.0),

            //o uso de stream e recomendado pois redesenha apenas parte da tela.
            StreamBuilder<bool>(
                stream: _bloc.hear,
                builder: (context, snapshot) {
                  //o uso do ?? testa se existe data se tiver usa se nao detecta como false
                  return AppButton(
                    "Login",
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data ?? false,
                  );
                }),
            Container(
              height: 45,
              margin: EdgeInsets.only(top: 20),
              child: GoogleSignInButton(
                onPressed: _onClickGoogleSign,
              ),
            ),

            SizedBox(height: 18.0),
            GestureDetector(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Criar conta",
                    style:
                        TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  print("Criar conta");
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    bool formOk = _formkey.currentState.validate();

    //se o formulario nao for valido nao deixa segui em frente
    if (!formOk) {
      return;
    }

    String login = tlogin.text;
    String senha = tsenha.text;

    /*

        mantendo o set state para nao esquecer, esta forma faz o rebuild da arvore de widget sempre que e chamado

   setState(() {
      _showProgress =true;

    });


*/

    apiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      Usuario usuario = response.result;

      replace(context, homePage(usuario));
    } else {
      alert(context, response.msg.toString(), "error");
    }

    /*setState(() {
      _showProgress =false;
    });
    */
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

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  void _onClickGoogleSign() {
    print("google");
  }
}
