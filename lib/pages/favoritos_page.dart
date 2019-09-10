import 'package:flutter/material.dart';
import 'package:carros_app/carro/carros_bloc.dart';


class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> with AutomaticKeepAliveClientMixin<FavoritosPage>{


  final _bloc = carrosBloc();

  @override
  void initState() {
    super.initState();

    _bloc.loadData();


  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {

        if(snapshot.hasError){

        }

        return Container();
      }
    );
  }
}
