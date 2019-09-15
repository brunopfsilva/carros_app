import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros_app/carro/carro-dao.dart';
import 'package:carros_app/carro/lore_bloc.dart';
import 'package:carros_app/carro/loripsum_api.dart';
import 'package:carros_app/pages/mapa_page.dart';
import 'package:carros_app/favoritos/favorito_service.dart';
import 'package:carros_app/firebase/favoritos-service.dart';
import 'package:carros_app/settings.dart';
import 'package:flutter/material.dart';
import 'package:carros_app/carro/Carro.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  bool _isFavorito = false;

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loren = loreBloc();

  @override
  void initState() {
    super.initState();
    final service = FavoritosService();
    _loren.lorem();

    service.exists(widget.carro).then((b){

      //metodo retorna um future tipado com bool, onde o mesmo vai precisar ser utilizado para
      //true or false na variavel _isFavorito atribuindo valor a ela;
      if(b){
        setState(() {
          widget._isFavorito = b;
        });
      }
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
              onPressed: () {
                _onClickmap(widget.carro);
              }),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              _onClickvideo(widget.carro);
            },
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
            imageUrl: widget.carro.urlFoto,
            placeholder: (context, url) =>
                Center(child: new CircularProgressIndicator()),
            errorWidget: (context, url, error) => new Icon(Icons.error),
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
            InkWell(
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: widget._isFavorito != null ? Colors.redAccent : Colors.grey,
                  size: 33,
                ),
                onPressed: () => _onClickFavorito(widget.carro),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.blueGrey,
                size: 33,
              ),
              onPressed: () => _onclickShare(widget.carro),
            ),
          ],
        ),
      ],
    );
  }

  void _onClickmap(Carro carro) {
    print((widget.carro.urlVideo));
    if (widget.carro.latitude != null || widget.carro.longitude != null) {
      push(context, MapPage(carro));
    }
  }

  void _onClickvideo(Carro carro) {
    print((widget.carro.urlVideo));
    if (widget.carro.urlVideo != null || widget.carro.urlVideo.isNotEmpty) {
      launch(carro.urlVideo);
    }
  }

  _onClickMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar");
        break;
      case "Deletar":
        print("Deletar");
        break;
      case "Share":
        print("Share");
        break;
    }
  }

  void _onClickFavorito(Carro carro) async {
    //este service uni a classe carro com a classe favorito
    //logica favoritos db
    //FavoritoService.Favoritar(context, widget.carro);

    //logica favoritos firebase
    final service = FavoritosService();
    final exists = await service.favoritar(carro);

    setState(() {
      widget._isFavorito = exists;
      Navigator.pop(context);
    });

  }

  bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.carro.descricao,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 18,
        ),
        StreamBuilder<String>(
            stream: _loren.output,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),
                  ),
                );
              }
              return Text(snapshot.data);
            }),
      ],
    );
  }

  void _onclickShare(Carro carro) {

    Share.share(carro.urlFoto);

  }
}
