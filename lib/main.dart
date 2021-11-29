import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizzeria/models/menu.dart';
import 'package:pizzeria/ui/pizza_list.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';

import 'models/cart.dart';

void main() {
  runApp(const Pizzeria());
}

class Pizzeria extends StatelessWidget {
  const Pizzeria({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzéria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ma Pizzéria'),
    );
  }
}

class MyHomePage extends StatelessWidget {  //stateledd sans état = il peut tout modifier mais ne réagis pas au click utilisateur pour modif la page en cours
  String title;
  Cart _cart;

  MyHomePage({required this.title, Key? key}) :
        _cart = Cart(),
        super(key: key);

  final _menus = [
    Menu(1, 'Entrées', 'entree.png', Colors.lightGreen),
    Menu(2, 'Pizzas', 'pizza.png', Colors.redAccent),
    Menu(3, 'Desserts', 'dessert.png', Colors.brown),
    Menu(4, 'Boissons', 'boisson.png', Colors.lightBlue),
  ];
//./asset/img/menus/
  @override
  Widget build(BuildContext context) {
    return Scaffold( //tj utiliser
      appBar: AppBarWidget(title, _cart),
      body: Center(
        child: ListView.builder(
          itemCount: _menus.length,
          //itemBuilder: (context, index) => _buildRow(_menus[index]),   //InkWell(
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              switch(_menus[index].type) {
                case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PizzaList(_cart)),);
                  break;
              }
            },
            child: _buildRow(_menus[index]),
          ),
          itemExtent: 150,
        ),
      ),
    );
  }

  // _ veut dire que c privé
  _buildRow(Menu menu) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: menu.color,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      margin: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/img/menus/${menu.image}',
              fit: BoxFit.fitWidth,   //.none
            ),
          ),
          Container(
            height: 70,
            child: Center(
              child: Text(
                menu.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//==== liste question possible :
//material app ca sert à quoi
//stateless
//statefull
//dart -> exemple a quoi sert les quoi les {} dans un construteur = ca permet de nommé chaque paramètre dans l'autre que je veux, je dois tous les mettre, je peux fixé une valeur par default, le ? veut dire qu'il eut être nullsi il est pas fixé lors de ca création.
 //     -> _  privé
//ListView c quoi ?  permet de scoller
//EdgeInsets
//Expanded