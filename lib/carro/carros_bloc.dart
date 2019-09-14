import 'dart:async';

import 'package:carros_app/carro/carroApi.dart';
import 'package:carros_app/utils/netWorkStatus.dart';

import 'Carro.dart';

import 'package:carros_app/carro/carro-dao.dart';

class carrosBloc {
  final _streamController = StreamController<List<Carro>>();

  //expoe a stream para o widget ficar ouvindo
  Stream<List<Carro>> get stream => _streamController.stream;

  Future<List<Carro>> loadData(String tipo) async {
    //pegar os dados com stream
    try {
      bool networkOn = await insNetworkOn();
      //se nao tiver internet pega todos do banco de dados
      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        _streamController.sink.add(carros);
        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipo);

      final dao = CarroDAO();
      //salva todos os carros no banco de dados
      for (Carro c in carros) {
        dao.save(c);
      }

      //joga os dados na stream
      if (_streamController != null) {
        _streamController.sink.add(carros);
        return carros;
      }
      return null;
    } on Exception catch (e) {
      _streamController.sink.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
