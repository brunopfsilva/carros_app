import 'dart:io';

import 'package:carros_app/carro/carro-dao.dart';
import 'package:carros_app/settings.dart';
import 'package:carros_app/utils/upload_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class carroTipo {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

Map mapResponse;
var response;

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario usuario = await Usuario.get();

    Map<String, String> hearder = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    try {
      var url =
          'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

      print("GET > $url");

      var response = await http.get(url, headers: hearder);

      //quando o json vem entre [] converter sempre para lista
      List list = json.decode(response.body);

      //objecto lista que sera utilizado para retorno apos ser adicionado
      final carros = List<Carro>();
      //uso do for para recuperar lista de carros vinda do ws
      for (Map map in list) {
        Carro c = Carro.fromJson(map);
        carros.add(c);
      }

      return carros;
    } catch (error) {
      print(error);
      //para a execucao do codigo ao jogar o error
      throw error;
    }
  }

  static Future<apiResponse<bool>> Save(Carro c, File file) async {
    if (file != null) {
      final response = UploadService.upload(file);
      print(response);

      if (response == true) {}
    }

    Usuario usuario = await Usuario.get();

    Map<String, String> hearder = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (c.id != null) {
        url = "/${c.id}";
      }
      print("POST > $url");

      //funcao encode usada para convert para json
      String convertToJsonForSend = convert.json.encode(c.toMap());

      print(convertToJsonForSend);

      c.id.toString();

      String jsonc = c.toJson();

      // se  o id == null chama o post se nao chama o put
      response = await (c.id == null
          ? http.post(url, body: jsonc, headers: hearder)
          : http.put(url, body: jsonc, headers: hearder));
      print("status code: " + response.statusCode);

      //quando o json vem entre [] converter sempre para lista

      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        //funcao decode usada para pegar o map do objecto
        mapResponse = json.decode(response.body);

        //depojs convertido o resultado no objecto
        Carro carro = Carro.fromJson(mapResponse);

        print("Novo Carro: ${carro.id}");

        return apiResponse.ok(result:  true);
      } else if (response.body == null || response.body.isEmpy) {
        return apiResponse.error(msg: "nao foi possivel salvar");
      }
    } catch (error) {
      print(error);
      //para a execucao do codigo ao jogar o error
      throw error;
    }

    mapResponse = json.decode(response.body);
    return apiResponse.error(msg: mapResponse["error"]);
  }

  static delete(Carro c) async {
    Usuario usuario = await Usuario.get();

    Map<String, String> hearder = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}"
    };

    try {
      var url =
          'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/carro/${c.id}';

      print("delete > $url");

      //funcao encode usada para convert para json

      // se  o id == null chama o post se nao chama o put
      response = await http.delete(url, headers: hearder);

      print("status code: " + response.statusCode);

      //quando o json vem entre [] converter sempre para lista

      print(response.body);

      if (response.statusCode == 200) {
        //funcao decode usada para pegar o map do objecto
        mapResponse = json.decode(response.body);

        return apiResponse.ok(result: true);
      } else if (response.body == null || response.body.isEmpy) {
        return apiResponse.error(msg: "nao foi possivel deletar");
      }
    } catch (error) {
      print(error);
      //para a execucao do codigo ao jogar o error
      throw error;
    }

    mapResponse = json.decode(response.body);
    return apiResponse.error(msg: mapResponse["error"]);
  }
}
