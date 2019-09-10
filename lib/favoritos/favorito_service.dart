import 'package:carros_app/carro/Carro.dart';
import 'package:carros_app/favoritos/favoritos.dart';
import 'package:carros_app/favoritos/FavoritosDao.dart';




class FavoritoService {

  static Favoritar(Carro carro) async{
    Favoritos f = Favoritos();
    f.id = carro.id;
    f.nome =carro.nome;

    final dao = FavoritoDao();

    int carroid = carro.id;

    final exists = await dao.exists(carroid);

    if(exists){
      //add favorito
      dao.delete(carro.id);
    }else {
      //remove favorito
      dao.save(f);
    }


  }


}