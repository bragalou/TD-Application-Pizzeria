import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:intl/intl.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    var format = NumberFormat("###.00€");

    return Scaffold(
      appBar: AppBar(
        title: Text('Mon panier'),
      ),
      body: Affichage(),
    );
  }

  Widget _bluidItem(CartItem cartItem, widgetCart) {
    var format = NumberFormat("###.00€");
    String totalAffiche = format.format(cartItem.pizza.total);

    double sousTotal = cartItem.pizza.total * cartItem.quantity;
    String AffichageSousTotal = format.format(sousTotal);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/img/pizza/${cartItem.pizza.image}',
            height: 100,
            width: 100,
            //width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,

                children: [
                  Text(
                    cartItem.pizza.title,
                    style: PizzeriaStyle.headerTextStyle,
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(totalAffiche)),

                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              widget._cart.removeProduct(cartItem.pizza);
                            });
                          },
                        ),
                      ),

                      //Expanded(child: Text(nombre.toString())),
                      Expanded(
                        child: Text(
                          cartItem.quantity.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.add_outlined),
                          onPressed: () {
                            setState(() {
                              widget._cart.addProduct(cartItem.pizza);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Sous-total : ' + AffichageSousTotal,
                    style: PizzeriaStyle.priceSoustotalPanier,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Affichage() {
    var format = NumberFormat("###.00€");
    if (widget._cart.TotalTTC() == 0) {
      return Container(
        width: double.infinity,
        child: Text(
          "Le pannier est vide",
          textAlign: TextAlign.center,
          style: PizzeriaStyle.headerTextStyle,
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget._cart.totalItems(),
                itemBuilder: (context, index) {
                  return _bluidItem(
                      widget._cart.getCartItem(index), widget._cart);
                }),
          ),
          Container(
            child: Table(
              border: TableBorder.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 1),
              children: [
                TableRow(children: [
                  Column(children: [Text('TOTAL HT')]),
                  Column(
                    children: [Text('${format.format(widget._cart.HT())}')],
                  )
                ]),
                TableRow(children: [
                  Column(children: [Text('TVA')]),
                  Column(
                    children: [Text('${format.format(widget._cart.TVA())}')],
                  )
                ]),
                TableRow(children: [
                  Column(children: [Text('TOTAL TTC')]),
                  Column(
                    children: [
                      Text('${format.format(widget._cart.TotalTTC())}')
                    ],
                  )
                ]),
              ],
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('Valider le panier'),
              onPressed: () {
                print('achat');
              },
            ),
          )
        ],
      );
    }
  }
}