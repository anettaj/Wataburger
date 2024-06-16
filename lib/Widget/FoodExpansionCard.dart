import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../Model/ItemModel.dart';
import 'network_image_widget.dart';

class FoodExpansionCard extends StatelessWidget {
  const FoodExpansionCard({
    super.key,
    required this.itemsList, required this.title,
  });
  final String title;
  final List<ItemModel> itemsList;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedIconColor: Colors.white,
        initiallyExpanded: true,
        shape: Border(),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        children:[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              NetworkImageWidget(
                                height: 100,
                                width: 100,
                                imageUrl: itemsList[index].productThumbnail,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemsList[index].productName,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                    Text(
                                      itemsList[index].productDescription,
                                      maxLines: 2,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          r"₹" + itemsList[index].unitPrice.toString(),
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: PersistentShoppingCart().showAndUpdateCartItemWidget(
                                            inCartWidget: Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: Colors.red),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Remove',
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ),
                                            ),
                                            notInCartWidget: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.green),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                child: Center(
                                                  child: Text(
                                                    'Add to cart',
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            product: PersistentShoppingCartItem(
                                              productId: index.toString(),
                                              productName: itemsList[index].productName,
                                              productDescription: itemsList[index].productDescription,
                                              unitPrice: itemsList[index].unitPrice,
                                              productThumbnail: itemsList[index].productThumbnail,
                                              quantity: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]
    );
  }
}