import 'package:carros_app/settings.dart';


class CarrosApi {
  static List<Carro> getCarros(){

    final carros = List<Carro>();

    carros.add(Carro(nome: "Ferrari FF",urlFoto: "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png"));
    carros.add(Carro(nome: "AUDI GT Spyder",urlFoto: "http://www.livroandroid.com.br/livro/carros/esportivos/Audi_Spyder.png"));
    carros.add(Carro(nome: "Porsche Panamera",urlFoto: "http://www.livroandroid.com.br/livro/carros/esportivos/Porsche_Panamera.png"));

    return carros;
  }
}

