import 'package:flutter/material.dart';

//chama uma tela em pilha
Future push(BuildContext context, Widget page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

//chama tela e sobre poe a outra
Future replace(BuildContext context, Widget page) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
