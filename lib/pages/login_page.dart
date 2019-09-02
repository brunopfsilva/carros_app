import 'package:flutter/material.dart';


class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(

        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: "Login",
              hintText: "Digite o login"
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Senha",
                hintText: "Digite a senha"
            ),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          Container(
            height: 45.0,
            child: RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Text("Login",style: TextStyle(fontSize: 18,color: Colors.white),),
              onPressed: (){

              },
            ),
          )
        ],

      ),
    );
  }
}
