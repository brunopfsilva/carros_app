import 'package:carros_app/settings.dart';

alert(BuildContext context,String msg,String title,{Function callback}){
  showDialog(context: context,
  barrierDismissible: false,
    builder: (context){
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
               Navigator.pop(context);
               if(callback != null){
                 callback();
               }
            },
          )
        ],
      ),
    );
    }
  );
}