import 'package:carros_app/settings.dart';


class carroList extends StatefulWidget {


  String tipo;
  carroList(this.tipo);

  @override
  _carroListState createState() => _carroListState();
}

class _carroListState extends State<carroList> with AutomaticKeepAliveClientMixin<carroList>{

  @override
  // mantem a aba salva
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    Future<List<Carro>> carros_future = CarrosApi.getCarros(widget.tipo);

    return FutureBuilder(
      future: carros_future, builder: (BuildContext context, AsyncSnapshot snapshot) {

      if(snapshot.hasError){

        return Center(child: Text("Não foi possivel buscar os dados",style: TextStyle(fontSize: 22.0),),);
      }

      if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),),);
      }

      List<Carro> carros = snapshot.data;
      return ListaCarros(carros);
    },

    );
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
                            onPressed: () { /* ... */ },
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
  }}
