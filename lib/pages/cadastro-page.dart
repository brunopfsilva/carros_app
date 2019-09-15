import 'dart:io';

import 'package:carros_app/firebase/firebase_service.dart';
import 'package:carros_app/pages/home_page.dart';
import 'package:carros_app/pages/login_page.dart';
import 'package:carros_app/utils/nav.dart';
import 'package:carros_app/settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final _tNome = TextEditingController();
  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();

  File _file;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;
  
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cadastro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {

    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 18,),
          
          IconButton(icon: Icon(Icons.photo_camera),onPressed: _onClickFoto,color: Colors.deepPurpleAccent,iconSize: 99,),
          Divider(height: 18,),
          
          textFormField_carro_page("nome","Digite o seu nome"),
          textFormField_carro_page("Email","Digite o seu email"),
          textFormField_carro_page("Senha","Digite a sua senha",obscureText: true),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Colors.blue,
              child: _progress
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
              onPressed: () {
                _onClickCadastrar(context);
              },
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Colors.white,
              child: Text(
                "Cancelar",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                ),
              ),
              onPressed: () {
                _onClickCancelar(context);
              },
            ),
          ),

        ],
      ),
    );
  }

  TextFormField textFormField_carro_page(String nome,String hint,{bool obscureText = false }) {


    return TextFormField(
          controller: _tNome,
          validator: _validateNome,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
          ),
          decoration: InputDecoration(
            labelText: nome,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          obscureText: false,
        );
  }

  String _validateNome(String text) {
    if (text.isEmpty) {
      return "Informe o nome";
    }

    return null;
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o email";
    }

    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    if (text.length <= 2) {
      return "Senha precisa ter mais de 2 números";
    }

    return null;
  }

  _onClickCancelar(context) {
    replace(context,loginPage());
  }

  _onClickCadastrar(context) async {
    print("Cadastrar!");

    //se form nao valido nao retorna nada
    try {
      if(! _formKey.currentState.validate()){
        return;
      }

      String nome = _tNome.text;
      String email = _tEmail.text;
      String senha = _tSenha.text;

      print("Nome $nome, Email $email, Senha $senha");

      setState(() {
        _progress = true;
      });

      print("google");


      final service = FireBaseService();
      final apiResponse response = await service.CadastoFirebaseGoogle(nome, email, senha,file: _file);

      if(response.ok ){
        replace(context, homePage());
        setState(() {
          _progress = false;
        });
      }else if(response.ok == null){
        alert(context, response.msg, "");
        setState(() {
          _progress = false;
        });
        Navigator.pop(context);
      }
      setState(() {
        _progress = false;
      });
    } on Exception catch (e) {
      alert(context, response.msg, e.toString());
      Navigator.pop(context);

    }throw(Exception){
      Navigator.pop(context);
    };

  }

  void _onClickFoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    print(file);
    if (file != null) {

      setState(() {
        this._file = file; //
      });
    }
  }

  }

