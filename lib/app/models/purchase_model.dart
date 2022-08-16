import 'package:proyecto_final_seminario/app/models/cart_item_model.dart';

class Purchase {
  String? id;
  DateTime? created;
  String? restaurantId;
  String? userId;
  String? mealId;
  Prices? prices;

  Purchase({
    this.id,
    this.created,
    this.restaurantId,
    this.userId,
    this.mealId,
    this.prices,
  });

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'].toDate();
    restaurantId = json['restaurantId'];
    userId = json['userId'];
    mealId = json['mealId'];
     prices = json['prices'] != null
        ? Prices.fromJson(
            json['prices'],
          )
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['restaurantId'] = restaurantId;
    data['userId'] = userId;
    data['mealId'] = mealId;
    if (prices != null) {
      data['prices'] = prices?.toJson();
    }
    return data;
  }
}
