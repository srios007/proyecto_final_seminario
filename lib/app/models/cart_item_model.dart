import 'package:proyecto_final_seminario/app/models/models.dart';

class CartItem {
  Meal? meal;
  DateTime? created;
  Prices? price;

  CartItem({
    this.meal,
    this.created,
    this.price,
  });
}

class Prices {
  double price = 0;
  double deliveryCost = 0;
  double total = 0;

  Prices({
    required this.price,
    required this.deliveryCost,
    required this.total,
  });
}
