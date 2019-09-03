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
      ),

    );
  }
}

_body(user) {

  return Center(
    child: Text("${user.nome}" + " \n${user.email}",style: TextStyle(fontSize: 22),),
  );

}
