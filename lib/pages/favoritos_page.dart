import 'package:carros_app/carro/Carro.dart';
import 'package:carros_app/carro/favoritos_bloc.dart';
import 'package:carros_app/utils/test_error.dart';
import 'package:flutter/material.dart';
import 'package:carros_app/carro/carros_bloc.dart';
import 'package:carros_app/widgets/carrosList.dart';
import 'package:carros_app/main.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> with AutomaticKeepAliveClientMixin<FavoritosPage>{



  @override
  void initState() {
    super.initState();

    // listen: false faz o bloc para de ouvir o widget
    favoritosBloc fbloc = Provider.of<favoritosBloc>(context,listen: false);
    //bloc_global.loadData();
    fbloc.loadData();


  }

  @override
  void dispose() {
    super.dispose();
    //bloc_global.dispose();
  }

  @override
  bool get wantKeepAlive => true;



  @override
  Widget build(BuildContext context) {

    favoritosBloc fbloc = Provider.of<favoritosBloc>(context);


    return StreamBuilder(
      stream: fbloc.stream,
      builder: (context, snapshot) {

        if(snapshot.hasError){
          return TextError("Nao foi possivel buscar os carros");
        }

        if(!snapshot.hasData){
          Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurple),),);
        }

        List<Carro>carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: carroList(carros),

        );
      }
    );


  }

  Future<void> _onRefresh() {

    //return bloc_global.loadData();
    return Provider.of<favoritosBloc>(context).loadData();

  }
}
