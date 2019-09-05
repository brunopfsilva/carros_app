import 'package:carros_app/settings.dart';

class homePage extends StatefulWidget {
  Usuario user;
  homePage(this.user);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> with SingleTickerProviderStateMixin<homePage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Carros"),
            centerTitle: true,
            bottom: TabBar(tabs: [
             Tab(text: "Classicos",),
              Tab(text: "Esportivos",),
              Tab(text: "Luxo",),
            ]),
          ),
          body: TabBarView(children: [
            carroList(carroTipo.classicos),
            carroList(carroTipo.esportivos),
            carroList(carroTipo.luxo)
          ]),
          drawer: Container(
              width: MediaQuery.of(context).size.width / 1.26, child: myDrawer()),
        ),
      ),
    );
  }
}


