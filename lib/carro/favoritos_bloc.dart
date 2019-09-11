


import 'dart:async';

import 'package:carros_app/carro/carroApi.dart';
import 'package:carros_app/utils/netWorkStatus.dart';
import 'package:carros_app/favoritos/favorito_service.dart';
import 'Carro.dart';

import 'package:carros_app/carro/carro-dao.dart';

class favoritosBloc {



  final _streamController = StreamController<List<Carro>>.broadcast();



  //expoe a stream para o widget ficar ouvindo
  Stream <List<Carro>> get stream => _streamController.stream.asBroadcastStream();
  //Stream <List<Carro>> get stream => _streamController.stream;

  Future<List<Carro>>loadData() async {
    //pegar os dados com stream
    try {

      List<Carro>carros = await FavoritoService.getCarros();

      final dao = CarroDAO();
      //salva todos os carros no banco de dados
      for(Carro c in carros){
        dao.save(c);
      }
      
      //joga os dados na stream
      _streamController.sink.add(carros);

      return carros;
    } on Exception catch (e) {
      _streamController.sink.addError(e);
    }
  }

  void dispose (){


    _streamController.close();

  }




}