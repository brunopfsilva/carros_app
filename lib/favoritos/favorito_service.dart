import 'package:carros_app/carro/Carro.dart';
import 'package:carros_app/carro/favoritos_bloc.dart';
import 'package:carros_app/favoritos/favoritos.dart';
import 'package:carros_app/favoritos/FavoritosDao.dart';
import 'package:carros_app/main.dart';
import 'package:provider/provider.dart';

class FavoritoService {
  static Future<bool> Favoritar(context, Carro carro) async {
    Favoritos f = Favoritos();
    f.id = carro.id;
    f.nome = carro.nome;

    final dao = FavoritoDao();

    int carroid = carro.id;

    final exists = await dao.exists(carroid);

    if (exists) {
      //add favorito
      dao.delete(carro.id);
      Provider.of<favoritosBloc>(context).loadData();
      // bloc_global.loadData();
      return false;
    } else {
      //remove favorito
      dao.save(f);
      Provider.of<favoritosBloc>(context).loadData();
      // bloc_global.loadData();
    }

    return true;
  }

  static Future<List<Carro>> getCarros() async {
    //select * from carro c, favorito f where c.id = f.id

    List<Carro> carros = (await FavoritoDao().findAllFv()).cast<Carro>();

    print(carros);
    return carros;
  }

  static Future<bool> isFavorite(Carro c) async {
    final dao = FavoritoDao();

    bool exists = await dao.exists(c.id);

    return exists;
  }
}
