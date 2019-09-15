
import 'package:carros_app/carro/Carro.dart';
import 'package:carros_app/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';

class FavoritosService {
  getCarros() => _carros.snapshots();

  //pega a colecao de carros
  //get _carros => Firestore.instance.collection("carros");

  CollectionReference get _carros {
    //seta variavel uid pegando a global
    String uid = firebaseUserUid;
    //recupera a colection usuario logado
    DocumentReference refUser = Firestore.instance.collection("users")
    .document(uid);
    //retorna a uniao ja concatenada com carros(a collection de usuarios)
    return refUser.collection("carros");
  }

  //convert o documento em list
  List<Carro> toList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((document) => Carro.fromJson(document.data) )
        .toList();
  }

  Future<bool> favoritar(Carro carro) async {

    //acessa o get carros que é a colection e cria um novo especificando o id
    var document = _carros.document("${carro.id}");
    //apos salvar recupera os dados
    var documentSnapshot = await document.get();

    if (!documentSnapshot.exists) {
      print("${carro.nome}, adicionado nos favoritos");
      //se o carro nao existi chama o metodo para salvar o carro nos favoritos convertendo eles para map
      document.setData(carro.toMap());

      return true;
    } else {
      print("${carro.nome}, removido nos favoritos");
      document.delete();

      return false;
    }
  }

  Future<bool> exists(Carro carro) async {

    // Busca o carro no Firestore
    var document = _carros.document("${carro.id}");

    var documentSnapshot = await document.get();

    // Verifica se o carro está favoritado
    return await documentSnapshot.exists;
  }
}