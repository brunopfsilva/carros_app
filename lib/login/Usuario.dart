import 'dart:convert' as convert;

import '../settings.dart';

class Usuario {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  String roles;

  Usuario(
      {this.id,
        this.login,
        this.nome,
        this.email,
        this.urlFoto,
        this.token,
        this.roles});

  //metodo usado para ler dados que vem do webservice
  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];


  }

  //metodo usado para pega objecto e salvar no banco de dados
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    return data;
  }

  void save(){

    Map map = toJson();

    String json = convert.json.encode(map);

    Prefs.setString("user.prefs", json);

  }

  static void clear(){
    Prefs.setString("user.prefs", "");
  }

  static Future<Usuario> get() async {

    String json = await Prefs.getString("user.prefs");

    if(json.isEmpty){
      return null;
    }

    Map map = convert.json.decode(json);

    Usuario usuario = Usuario.fromJson(map);

    return usuario;



  }


  //lembrar da da orverride no tostring para nao impprimir instance of object ou instance of usuario
  @override
  String toString() {
    return 'Usuario{id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token}';
  }


}