import 'package:carros_app/settings.dart';

import 'package:carros_app/login/Usuario.dart';
import 'package:carros_app/pages/home_page.dart';


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



  @override
  void initState() {
    super.initState();


    Future<Usuario> future = Usuario.get();
    //este future aguarda o objecto Usuario como resultado
    future.then((Usuario user){

      //mantem o usuario logado
      if(user != null){
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

            AppButton("Login", onPressed: _onClickLogin,showProgress: _showProgress,



            ),




            SizedBox(height: 18.0),
            GestureDetector(

              child: Center(

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(

                      "Criar conta",
                      style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),
                    ),
                  ),

              ),
              onTap: (){
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


    setState(() {
      _showProgress =true;

    });

    apiResponse response = await LoginApiUser.login(login, senha);


    if(response.ok) {

      Usuario usuario = response.result;


      replace(context, homePage(usuario));
    }else {
      alert(context,response.msg.toString(),"error");

    }

    setState(() {
      _showProgress =false;
    });

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
