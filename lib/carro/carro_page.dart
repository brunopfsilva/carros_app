import 'package:flutter/material.dart';
import 'package:carros_app/carro/Carro.dart';

class CarroPage extends StatelessWidget {


  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(carro.nome),
              centerTitle: true,
            ),
            body: _body(),
        );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16.0),

        child: Image.network(carro.urlFoto));
  }

}


