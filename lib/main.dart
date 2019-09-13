import 'package:carros_app/carro/favoritos_bloc.dart';
import 'package:carros_app/settings.dart';
import 'package:carros_app/splash.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

//bloc global
//final bloc_global = favoritosBloc();


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    const PrimaryColor = const Color(0xFF151026);


    return MultiProvider(
      providers: [
        Provider<favoritosBloc>(
          //chama o bloc
          builder: (context) => new favoritosBloc(),
          //tira o bloc da meoria fechando a stream
          dispose: (context,bloc) => bloc.dispose(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepPurple[800],
            accentColor: Colors.deepPurpleAccent,
          //primaryColorDark: Colors.deepPurpleAccent,
          //  primarySwatch: Colors.deepPurple,
         // brightness: Brightness.light

        ),

        home: SplashPage(),
      ),
    );
  }


}

