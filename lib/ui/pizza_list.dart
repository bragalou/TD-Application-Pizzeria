import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/models/pizza_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';

class PizzaList extends StatefulWidget {
  const PizzaList({Key? key}) : super(key: key);

  @override
  _PizzaListState createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  List<Pizza> _pizza = [];

  @override
  void initState() {
    _pizza = PizzaData.buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nos Pizzas'),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _pizza.length,
          itemBuilder: (context, index) {
            return _buildRow(context, _pizza[index]);
          }),
    );
  }
}

_buildRow(BuildContext context, Pizza pizza) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0), top: Radius.circular(2.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PizzaDetails(pizza),
              ),
            );
          },
          child: _buildPizzaDetails(context, pizza),
        ),
        //_buildBuyButton(),
        BuyButtonWidget(),
      ],
    ),
  );
}

_buildPizzaDetails(BuildContext context, Pizza pizza) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        title: Text(pizza.title),
        subtitle: Text(pizza.garniture),
        leading: Icon(Icons.local_pizza),
      ),
      Image.asset(
        'assets/img/pizza/${pizza.image}',
        height: 120,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      ),
      Container(
        padding: const EdgeInsets.all(4.0),
        child: Text(pizza.garniture),
      )
    ],
  );
}
