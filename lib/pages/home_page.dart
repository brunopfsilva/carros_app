import 'package:carros_app/settings.dart';

class homePage extends StatelessWidget {

  Usuario user;

  homePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          centerTitle: true,
        ),
      body: _body(user),
      drawer: Container(width: MediaQuery.of(context).size.width/1.26,child: myDrawer()),

      ),

    );
  }
}

_body(user) {

  List<Carro> carros = CarrosApi.getCarros();

  return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (context,index){

        Carro c = carros[index];

        return Row(children: <Widget>[
          Image.network(c.urlFoto,scale: 3.6),
          //faz o widget texto caber na tela
          Flexible(child: Text(c.nome,style: TextStyle(fontSize: 21),
          overflow: TextOverflow.ellipsis,)),

        ],);

        /*return ListTile(
          title: Text(c.nome,style: TextStyle(fontSize: 21),),
          leading: Image.network(c.urlFoto,scale: 1.0,),
        
        );*/
        



  });
}
