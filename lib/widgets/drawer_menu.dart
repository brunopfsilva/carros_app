import 'package:carros_app/settings.dart';


class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Bruno Silva"),
              accountEmail: Text("bruno.pfsilva1985@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(""),
              ),
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
}

_onClickLogout(context) {

  Navigator.of(context).pop();
  replace(context, loginPage());

}
