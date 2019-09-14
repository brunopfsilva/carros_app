import 'dart:async';

import 'package:carros_app/pages/carro_page.dart';
import 'package:carros_app/carro/carros_bloc.dart';
import 'package:carros_app/settings.dart';
import 'package:carros_app/utils/test_error.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

class carroList extends StatelessWidget {
  List<Carro> carros;

  carroList(this.carros);

  @override
  Widget build(BuildContext context) {
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
                    Center(
                      child: InkWell(
                        child: CachedNetworkImage(
                          imageUrl: c.urlFoto ??
                          "https://carros-springboot.herokuapp.com/api/v1/carros/tipo/esportivos/Ferrari_FF.png",
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),

                      ),
                    ),
                    /*Center(child: Image.network(c.urlFoto ??
                        "https://carros-springboot.herokuapp.com/api/v1/carros/tipo/esportivos/Ferrari_FF.png",
                        scale: 1.8)), */
                    //faz o widget texto caber na tela
                    SizedBox(height: 9.0),
                    Text(
                      c.nome,
                      style: TextStyle(fontSize: 21),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.3),
                    Text("Descricao.."),

                    ButtonTheme.bar(
                      // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Detalhes'),
                            onPressed: () => _clickCarro(context, c),
                          ),
                          FlatButton(
                            child: const Text('Compartilhar'),
                            onPressed: () => _onclickShare(context,c),
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
          },),
    );
  }

  _clickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }


  _longclickCarro(BuildContext context, Carro c) {

    showDialog(context: context,builder: (context){
      return SimpleDialog(
        title: Text(c.nome),
        children: <Widget>[
          ListTile(
            title: Text("Detalhes"),
            leading: Icon(Icons.directions_car),
            onTap: (){
              _clickCarro(context, c);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Share"),
            leading: Icon(Icons.share),
            onTap: (){
              _onclickShare(context,  c);
              Navigator.pop(context);
            },
            
          ),

        ],
      );
    });



  }

  void _onclickShare(BuildContext context, Carro c) {
    print(c.nome);

    Share.share(c.urlFoto);
  }


}
