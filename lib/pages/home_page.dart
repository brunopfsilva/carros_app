import 'package:flutter/material.dart';


class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          centerTitle: true,
        ),
      body: _body(),
      ),

    );
  }
}

_body() {

  return Center(
    child: Text("Bruno",style: TextStyle(fontSize: 22),),
  );

}
