import 'dart:convert' as covert;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Carro {
  int id;
  String nome;
  String tipo;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Carro(
      {this.id,
      this.nome,
      this.tipo,
      this.descricao,
      this.urlFoto,
      this.urlVideo,
      this.latitude,
      this.longitude});

  get latlng => LatLng(
      latitude == null || latitude.isEmpty ? 0.0 : double.parse(latitude),
      longitude == null || longitude.isEmpty ? 0.0 : double.parse(longitude));

  //faz o parse do objecto para o json ou seja usando para leitura de dados
  Carro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    tipo = json['tipo'];
    descricao = json['descricao'];
    urlFoto = json['urlFoto'];
    urlVideo = json['urlVideo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  //gera o map com o objecto para pode salvar o objecto no servidor
  //salva no banco de dados convertendo ele para um map para salvar no banco de dados ou nas preferencias
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['nome'] = this.nome;
    data['tipo'] = this.tipo;
    data['descricao'] = this.descricao;
    data['urlFoto'] = this.urlFoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }

  String toJson() {
    String jsonobj = covert.json.encode(toMap().toString());
    return jsonobj;
  }

  @override
  String toString() {
    return 'Carro{id: $id, nome: $nome, tipo: $tipo, descricao: $descricao, urlFoto: $urlFoto, urlVideo: $urlVideo, latitude: $latitude, longitude: $longitude}';
  }
}
