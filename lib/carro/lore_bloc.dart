import 'dart:async';

import 'package:carros_app/carro/loripsum_api.dart';

class loreBloc {

final _streamController = StreamController<String> ();

Sink<String> get input => _streamController.sink;
Stream<String> get output => _streamController.stream;


static String lorin;

//inserir sua regra de negocio envolvendo o try catch



   lorem () async {


    try {

      String s = lorin ?? await LoripsunApi.getIpsum();

      //cria cache com a variavel lorin
      lorin = s;

      input.add(s);


    } on Exception catch(e) {

      _streamController.sink.addError(e);

    }
  }


dispose () {
  _streamController.close();
}


}

