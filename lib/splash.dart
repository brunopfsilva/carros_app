import 'package:carros_app/utils/db-helper.dart';
import 'package:carros_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:carros_app/utils/nav.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    /* Future.delayed(Duration(seconds: 6),(){
      replace(context, loginPage());
    });

    */

    //chama banco de dados apenas uma vez
    Future databaseload = DatabaseHelper.getInstance().db;
    //aguarda conccluir o carregamento do banco de dados e depois chama a pagina
    Future.wait([databaseload]).then((List values) {
      replace(context, loginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),
      ),
    );
  }
}
