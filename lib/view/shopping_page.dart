import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controlers/card_controller.dart';
import '../controlers/shopping_controlers.dart';

class ShoppingPage extends StatelessWidget {
  final shoppingController = Get.put(ShoppingController());

  // final cartController = Get.put(CartController());
  final cardController = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: GetX<ShoppingController>(builder: (controller) {
                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.products[index].productName}',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                        '${controller.products[index].productDescription}'),
                                  ],
                                ),
                                Text('\$${controller.products[index].price}',
                                    style: TextStyle(fontSize: 24)),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                cardController
                                    .addToCard(controller.products[index]);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            GetX<ShoppingController>(builder: (controller) {
              print('Total amount: \$ ${cardController.totalPrice}');
              return Text('Total amount:  \$ ${cardController.totalPrice}');
            }),
            const SizedBox(height: 50),
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.yellow,
          icon: const Icon(Icons.shopping_cart),
          label: GetX<CardController>(builder: (controller) {
            return Text(
              controller.count.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 24),
            );
          }),
        ));
  }
}
