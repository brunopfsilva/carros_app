import 'dart:async';

import 'package:carros_app/pages/carro_page.dart';
import 'package:carros_app/carro/carros_bloc.dart';
import 'package:carros_app/settings.dart';
import 'package:carros_app/utils/test_error.dart';

class carrosPage extends StatefulWidget {
  String tipo;

  carrosPage(this.tipo);

  @override
  _carrosPageState createState() => _carrosPageState();
}

class _carrosPageState extends State<carrosPage>
    with AutomaticKeepAliveClientMixin<carrosPage> {
  List<Carro> carros;

  //lembrar de tipa o stream com os dados que precisa fazer o tratamento

  String get tipo => widget.tipo;

  //chama o bloc
  final _bloc = carrosBloc();

  @override
  // mantem a aba salva.
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    /*  1 maneira de pegar os dados com call back

  Future<List<Carro>> carros_future = CarrosApi.getCarros(widget.tipo);

    //call back future carros aguardando list que chega da api
    carros_future.then((List<Carro>carros){

      setState(() {
        //este carro declarado acima é igual ao carro vindo do future
        this.carros = carros;
      });

    });
*/

    _bloc.loadData(tipo);
  }

  @override
  void dispose() {
    //fecha a stream para liberar recursos
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<List<Carro>>(
        //saida de dados da stream
        stream: _bloc.stream,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            TextError("Nao foi possivel buscar dados");
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),
              ),
            );
          }

          List<Carro> carros = snapshot.data;

          return RefreshIndicator(
              onRefresh: _onRefresh, child: carroList(carros));
        });

    /* if(carros == null){
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),),);
    }
      return ListaCarros(carros);
*/
  }

  Future<void> _onRefresh() {
    return Future.delayed(Duration(seconds: 3), () {
      _bloc.loadData(tipo);
    });
  }
}
