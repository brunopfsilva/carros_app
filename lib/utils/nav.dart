import 'package:flutter/material.dart';


Future push (BuildContext context, Widget page){

  return Navigator.push(context, MaterialPageRoute(builder: (context) => page ));


}

Future replace (BuildContext context, Widget page){

  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page ));


}