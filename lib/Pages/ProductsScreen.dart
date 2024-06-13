import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';

import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../Model/ItemModel.dart';
import '../Model/fetch_products.dart';
import '../Widget/DrawerItems.dart';
import '../Widget/network_image_widget.dart';
import 'cart_view.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double H= MediaQuery.of(context).size.height;
    double W= MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DrawerHeader(
              //   child: Container(
              //   color: Colors.pink,
              //   width: W*0.7,
              //   height: 20,
              // ),),
              Container(
                width: W*0.78,
                height: H*0.15,
                child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV_KBTi65vEqrwc46mfKCtYN7N8y8YfDfTuOFZwvP4DSRHuAb36hb6dQWxyLad-fuoctg&usqp=CAU',
                  fit: BoxFit.fill,
                ),
              ),
              Divider(),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),
                      color: Colors.black.withOpacity(0.3)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Home',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
              DrawerItems(name: 'Profile', goto: (){}, icon: Icons.person,),
              DrawerItems(name: 'Orders', goto: (){}, icon: Icons.playlist_add_check,),
              DrawerItems(name: 'Settings', goto: (){}, icon: Icons.settings,),
              DrawerItems(
                name: 'Logout',
                goto: (){
                  PersistentShoppingCart().clearCart();
                  Navigator.pop(context);
                },
                icon: Icons.logout,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: TextButton.icon(
              //     onPressed: () {
              //       PersistentShoppingCart().clearCart();
              //       Navigator.pop(context);
              //     },
              //     icon: const Icon(Icons.logout),
              //     label: const Text('Logout'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Wataburger', style: TextStyle(fontSize: 15)),
        centerTitle: true,
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartView()),
                );
              },
              icon: Badge(
                label: Text(itemCount.toString()),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }

          List<ItemModel> itemsList = snapshot.data!;

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(18),
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage('https://wataburger.in/wp-content/uploads/2022/09/WAB-Sign-Banner-2.jpg'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Burgers',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
