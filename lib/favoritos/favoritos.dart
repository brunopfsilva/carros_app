class Favoritos {

  int id;
  String nome;


  Favoritos.fromMap(Map<String,dynamic>map){
    id = map["id"];
    nome = map["nome"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }

  Favoritos();

  @override
  String toString() {
    return 'Favoritos{id: $id, nome: $nome}';
  }


}