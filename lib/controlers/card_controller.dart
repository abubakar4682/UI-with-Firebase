import 'package:get/get.dart';

import '../model/product.dart';

class CardController extends GetxController{
  var cardItems = <Product>[].obs;
  double get totalPrice => cardItems.fold(0, (sum, item) => sum + (item.price ?? 0).toDouble());
 int get count => cardItems.length;
  addToCard(Product product){
    cardItems.add(product);
  }
}