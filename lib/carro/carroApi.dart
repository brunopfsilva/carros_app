import 'package:carros_app/settings.dart';
import 'package:http/http.dart' as http;


class carroTipo {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}


class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async{

    try{
      var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';

      print("GET > $url");

      var response = await http.get(url);

      //quando o json vem entre [] converter sempre para lista
      List list = json.decode(response.body);

      //objecto lista que sera utilizado para retorno apos ser adicionado
      final carros = List<Carro>();
      //uso do for para recuperar lista de carros vinda do ws
      for(Map map in list){
        Carro c = Carro.fromJson(map);
        carros.add(c);
      }

      return carros;

    }catch(error){

      print(error);

    }

  }
}

