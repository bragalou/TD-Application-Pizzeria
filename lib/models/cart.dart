import 'package:pizzeria/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart {
  List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);

    if (index == -1) {
      _items.add(CartItem(pizza));
    } else {
      CartItem item = _items[index];
      item.quantity++;
    }
  }

  void removeProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if (index != -1) {
      CartItem item = _items[index];
      item.quantity--;
      if (item.quantity == 0) {
        _items.remove(item);
        print('test');
      }
    }
  }

  int findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.pizza.id == id);
  }

  double TVA() {
    double priceHT = HT() * 0.2;
    return priceHT;
  }

  double HT() {
    double sum = 0;
    for (var i = 0; i < _items.length; i++) {
      sum += (_items[i].pizza.total * _items[i].quantity);
    }
    print(sum);
    return sum;
  }

  double TotalTTC() {
    double prixFinal = HT() + TVA();
    return prixFinal;
  }
}
