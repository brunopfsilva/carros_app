import 'package:carros_app/firebase/firebase_service.dart';
import 'package:carros_app/pages/site_page.dart';
import 'package:carros_app/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Future<Usuario> user = Usuario.get(); usuario preferences
    Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<FirebaseUser>(
              future: user,
              builder: (context, snapshot) {
                FirebaseUser user = snapshot.data;

                return user != null
                    ? _hearder(user)
                    : Container(child: CircularProgressIndicator());
              },
            ),
            ListTile(
              title: Text("Site"),
              subtitle: Text("Visite nosso site"),
              leading: Icon(Icons.web),
              onTap: () => _onClickOpenSite(context),
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

  UserAccountsDrawerHeader _hearder(FirebaseUser user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.displayName),
      accountEmail: Text(user.email),
      currentAccountPicture: user.photoUrl != null ? CircleAvatar(
        backgroundImage: NetworkImage(user.photoUrl),
      ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),),),
    );
  }

}


_onClickOpenSite(context) {
  Navigator.pop(context);
  push(context, sitePage());
}

_onClickLogout(context) {
  Navigator.of(context).pop();
  replace(context, loginPage());
  FireBaseService().logout();
  Usuario.clear();
  // bloc_global.dispose();
}
