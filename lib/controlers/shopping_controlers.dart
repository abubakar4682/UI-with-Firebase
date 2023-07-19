import 'package:get/state_manager.dart';

import '../model/product.dart';

class ShoppingController extends GetxController {
  var products = <Product>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchproduct();
  }

  void fetchproduct() async {
    await Future.delayed(Duration(seconds: 1));
    var productResult = [
      Product(
        id: 1,
        productName: 'First Product',
        productImage: 'abu',
        productDescription: 'this product is Amzazing',
        price: 20,
      ),
      Product(
        id: 2,
        productName: 'Sec Product',
        productImage: 'abu',
        productDescription: 'this product is Amzazing',
        price: 30,
      ),
      Product(
        id: 3,
        productName: 'Third Product',
        productImage: 'abu',
        productDescription: 'this product is Amzazing',
        price: 40,
      ),
      Product(
        id: 3,
        productName: 'Third Product',
        productImage: 'abu',
        productDescription: 'this product is Amzazing',
        price: 40,
      ),
    ];
    products.value = productResult;
  }
}
