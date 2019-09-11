import 'package:carros_app/carro/carro-form-page.dart';
import 'package:carros_app/pages/favoritos_page.dart';
import 'package:carros_app/settings.dart';
import 'package:carros_app/widgets/carrosPage.dart';

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

    _tabController = TabController(length: 4, vsync: this);


    Future<int> future = Prefs.getInt("tabIdex");

    //futuro a espera de valor inteiro o mesmo adicionado abaixo e que foi pedido acima
    future.then((int index){

      setState(() {
        _tabController.index = index;
      });

    });

    _tabController.addListener((){
      Prefs.setInt("tabIdex",_tabController.index);
    });
    



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

           Tab(text: "Classicos",
           icon: Icon(Icons.directions_car),
           ),
            Tab(text: "Esportivos",
              icon: Icon(Icons.directions_car),
            ),
            Tab(text: "Luxo",
              icon: Icon(Icons.directions_car),
            ),
            Tab(text: "Favoritos",
              icon: Icon(Icons.favorite),
            ),
          ]),
        ),
        body: TabBarView(
            controller: _tabController,
            children: [
              carrosPage(carroTipo.classicos),
              carrosPage(carroTipo.esportivos),
              carrosPage(carroTipo.luxo),
              FavoritosPage()
        ]),
        drawer: Container(
            width: MediaQuery.of(context).size.width / 1.26, child: myDrawer()),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: _addCar,

            
            ),
        
      ),
    );
  }

  void _addCar() {
    push(context, CarroFormPage());
  }
}


