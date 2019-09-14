import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros_app/carro/carro-form-page.dart';
import 'package:carros_app/carro/lore_bloc.dart';
import 'package:carros_app/carro/mapa_page.dart';
import 'package:carros_app/favoritos/favorito_service.dart';
import 'package:carros_app/settings.dart';
import 'package:flutter/material.dart';
import 'package:carros_app/carro/Carro.dart';
import 'package:carros_app/utils/nav.dart';
import 'package:url_launcher/url_launcher.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  Color color = Colors.grey;

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loren = loreBloc();

  @override
  void initState() {
    super.initState();
    _loren.lorem();

    // este future espera o retorno do resultado do processamento que é um favorito
    FavoritoService.isFavorite(widget.carro).then((bool favorito){

      setState(() {
        //se favorito for true pinta de vermelho se nao pinta de cinza
        widget.color = favorito ? Colors.red : Colors.grey;
      });

    });
    

  }

  @override
  void dispose() {
    super.dispose();
    _loren.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickmap(widget.carro),
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () => _onClickvideo(context),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickMenu(value),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(children: <Widget>[

          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto ??
                        "https://carros-springboot.herokuapp.com/api/v1/carros/tipo/esportivos/Ferrari_FF.png",
            placeholder: (context, url) =>
            Center(child: new CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
            new Icon(Icons.error),
          ),

          SizedBox(
            height: 9,
          ),
          bloco1(),
          Divider(),
          bloco2(),
        ]));
  }

  Row bloco1() {
    return Row(
          //da espaco entre os widgets
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.carro.nome,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.carro.tipo,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: widget.color ,
                    size: 33,
                  ),
                  onPressed: _onClickFavorito,
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.blueGrey,
                    size: 33,
                  ),
                  onPressed: _onClickFavorito,
                ),
              ],
            ),
          ],
        );
  }

   _onClickmap(Carro carro) {
    push(context, MapPage(carro));
  }

  void _onClickvideo(context) async {
    print(widget.carro.urlVideo);
    if(widget.carro.urlVideo != null && widget.carro.urlVideo.isNotEmpty){
      await launch(widget.carro.urlVideo);
    }else {
      alert(context, "Esse carro nao possui video", "Erro");
    }
  }

  _onClickMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar");
        push(context,CarroFormPage(carro: widget.carro));
        break;
      case "Deletar":
        print("Deletar");
        _deletar();
                break;
              case "Share":
                print("Share");
                break;
            }
          }
        
          void _onClickFavorito() async {
        
            //este service uni a classe carro com a classe favorito
           bool favorito = await FavoritoService.Favoritar(context,widget.carro);
        
        
           setState(() {
             widget.color = favorito ? Colors.red : Colors.grey;
           });
          }
        
          bloco2() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.carro.descricao,style: TextStyle(fontSize: 15),),
                SizedBox(height: 18,),
        
                StreamBuilder<String>(
                  stream: _loren.output,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),),);
                    }
                    return Text(snapshot.data);
                  }
                ),
        
              ],
            );
          }

 void _deletar() async {
          
          apiResponse<bool> response = await CarrosApi.delete(widget.carro);

          if(response.ok){
            alert(context, "Carro deletado com sucesso", "",callback: ()  {
              Navigator.pop(context);
            });
          }


        }


        }
        
       