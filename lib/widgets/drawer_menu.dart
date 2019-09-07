import 'package:carros_app/settings.dart';



class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<Usuario> user = Usuario.get();


    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: user , builder: (context, snapshot){

                Usuario user = snapshot.data;

                return user != null ? _hearder(user) : Container(child: CircularProgressIndicator());

            },
            ),

            ListTile(
              title: Text("Logout"),
              subtitle: Text("Sair do app"),
              leading: Icon(Icons.exit_to_app),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _hearder(Usuario user) {
    return UserAccountsDrawerHeader(
            accountName: Text(user.nome),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.urlFoto),
            ),
          );
  }
}

_onClickLogout(context) {

  Navigator.of(context).pop();
  replace(context, loginPage());
  Usuario.clear();

}
