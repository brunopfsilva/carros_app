


import 'dart:async';

import 'package:carros_app/carro/carroApi.dart';

import 'Carro.dart';

class carrosBloc {



  final _streamController = StreamController<List<Carro>>();


  //expoe a stream para o widget ficar ouvindo
  Stream <List<Carro>> get stream => _streamController.stream;

  loadData(String tipo) async {
    //pegar os dados com stream
    try {
      List<Carro>carros = await CarrosApi.getCarros(tipo);
      
      //joga os dados na stream
      _streamController.sink.add(carros);
    } on Exception catch (e) {
      _streamController.sink.addError(e);
    }
  }

  void dispose (){


    _streamController.close();

  }




}