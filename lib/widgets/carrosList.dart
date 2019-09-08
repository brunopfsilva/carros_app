import 'dart:async';

import 'package:carros_app/carro/carro_page.dart';
import 'package:carros_app/carro/carros_bloc.dart';
import 'package:carros_app/settings.dart';
import 'package:carros_app/utils/test_error.dart';


class carroList extends StatefulWidget {


  String tipo;
  carroList(this.tipo);

  @override
  _carroListState createState() => _carroListState();



}

class _carroListState extends State<carroList> with AutomaticKeepAliveClientMixin<carroList>{




  List<Carro>carros;
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
        builder: (context,snapshot) {

          if(snapshot.hasError){
            TextError("Nao foi possivel buscar dados");
          }

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),),);
          }


          List<Carro> carros = snapshot.data;


          return ListaCarros(carros);


        }



      );

    

   /* if(carros == null){
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),),);
    }
      return ListaCarros(carros);
*/


  }


Container ListaCarros(List<Carro> carros) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(3.0),
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: Image.network(c.urlFoto ?? "https://carros-springboot.herokuapp.com/api/v1/carros/tipo/esportivos/Ferrari_FF.png", scale: 1.8)),
                    //faz o widget texto caber na tela
                    SizedBox(height:9.0),
                    Text(
                      c.nome,
                      style: TextStyle(fontSize: 21),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height:6.3),
                    Text("Descricao.."),

                    ButtonTheme.bar( // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Detalhes'),
                            onPressed: () => _clickCarro(c),
                            ),
                          FlatButton(
                            child: const Text('Compartilhar'),
                            onPressed: () { /* ... */ },
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

            );

            /*return ListTile(
          title: Text(c.nome,style: TextStyle(fontSize: 21),),
          leading: Image.network(c.urlFoto,scale: 1.0,),

        );*/
          }),
    );
  }

  _clickCarro(Carro c) {

    push(context, CarroPage(c));

  }

}
