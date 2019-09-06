import 'package:carros_app/settings.dart';

class homePage extends StatefulWidget {
  Usuario user;
  homePage(this.user);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> with SingleTickerProviderStateMixin<homePage>{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    
    
    _tabController = TabController(length: 3, vsync: this);


    Prefs.setInt("tabIdex",_tabController.index);
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          centerTitle: true,
          bottom: TabBar(
              controller: _tabController,
              tabs: [

           Tab(text: "Classicos",),
            Tab(text: "Esportivos",),
            Tab(text: "Luxo",),
          ]),
        ),
        body: TabBarView(
            controller: _tabController,
            children: [
          carroList(carroTipo.classicos),
          carroList(carroTipo.esportivos),
          carroList(carroTipo.luxo)
        ]),
        drawer: Container(
            width: MediaQuery.of(context).size.width / 1.26, child: myDrawer()),
      ),
    );
  }
}


