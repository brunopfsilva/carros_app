import 'package:carros_app/utils/db-helper.dart';
import 'package:carros_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      //login comum
      replace(context, loginPage());
    });

    */
    Future<FirebaseUser> futureLoginFirebase = FirebaseAuth.instance.currentUser();

    //chama banco de dados apenas uma vez
    Future databaseload = DatabaseHelper.getInstance().db;
    //aguarda conccluir o carregamento do banco de dados e depois chama a
    //o programa so avanca quando concluir o processamento da lista
    Future.wait([databaseload,futureLoginFirebase]).then((List values) {
      FirebaseUser user = values[1];
      if(user != null) {
        replace(context, loginPage());
      } else {
        replace(context, loginPage());
      }
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
