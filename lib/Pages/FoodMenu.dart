import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Widget/MenuGridCard.dart';
import 'ProductsScreen.dart';

class FoodMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Menu'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 50),
                  width: W,
                  height: H * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xffed580c),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  left: W * 0.35,
                  top: H * 0.03,
                  child: Container(
                    child: ClipRect(
                      clipBehavior: Clip.none,
                      child: Container(
                        width: H * 0.33,
                        child: Image.asset(
                          'assets/Burger.png',
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xfff67835),
                              blurRadius: 10,
                              spreadRadius: 10,
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: H * 0.06,
                  left: W * 0.05,
                  child: Container(
                    height: H * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Burgers',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          width: W * 0.38,
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Burger Bliss: Taste the Ultimate Comfort Food!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // _navigateAndScrollToSection(context, ScrollDestination.);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                          ),
                          child: Text(
                            'View items',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 9 / 13,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MenuGridCard(
                    H: H,
                    W: W,
                    address:
                    'https://static.wixstatic.com/media/9da2dc_d852c28595364deab53ea459001aa16b~mv2.png/v1/fill/w_124,h_124,usm_1.20_1.00_0.01/file.png',
                    title: 'Cookies Shake',
                    des: 'Creamy vanilla ice cream with crunchy cookies',
                    Navi: () {
                      _navigateAndScrollToSection(context, ScrollDestination.CookieShakes);

                    },
                    color: Color(0xffe65d87),
                  ),
                  MenuGridCard(
                    H: H,
                    W: W,
                    address:
                    'https://static.wixstatic.com/media/9da2dc_7ab20cd4ebe74c19911eac167fd87e75~mv2.png/v1/fill/w_124,h_124,usm_1.20_1.00_0.01/file.png',
                    title: 'Mojito',
                    des: 'Your go-to drink for a tropical escape.',
                    Navi: () {
                      _navigateAndScrollToSection(context, ScrollDestination.Mojito);
                    },
                    color: Color(0xffacbcd3),
                  ),
                  MenuGridCard(
                    H: H,
                    W: W,
                    address:
                    'https://static.wixstatic.com/media/f5ebed_56251c378dfb461b8f2985371278b436~mv2.png/v1/fill/w_124,h_124,usm_1.20_1.00_0.01/file.png',
                    title: 'French Fries',
                    des: 'Perfectly fried, timeless favorite.',
                    Navi: () {
                      _navigateAndScrollToSection(context, ScrollDestination.FrenchFries);
                    },
                    color: Color(0xff6abfba),
                  ),
                  MenuGridCard(
                    H: H,
                    W: W,
                    address:
                    'https://static.wixstatic.com/media/9da2dc_11207841a3df4f51a37275c907cf7c7b~mv2.png/v1/fill/w_124,h_124,usm_1.20_1.00_0.01/file.png',
                    title: 'Chicken Wings',
                    des: 'Juicy, crispy, and packed with flavor.',
                    Navi: () {
                      _navigateAndScrollToSection(context, ScrollDestination.ChickenWings);
                    },
                    color: Color(0xff5faed5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _navigateAndScrollToSection(BuildContext context, ScrollDestination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsScreen(
          scrollController: ScrollController(),
          cookieShakesKey: cookieShakesKey, // Pass the keys here
          mojitoKey: mojitoKey,
          frenchFriesKey: frenchFriesKey,
          chickenWingsKey: chickenWingsKey,
        ),
      ),
    ).then((_) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollToSection(context, destination);
      });
    });
  }


void _scrollToSection(BuildContext context, ScrollDestination destination) {
  ProductsScreenState? productsScreenState = context.findAncestorStateOfType<ProductsScreenState>();
  switch (destination) {
    case ScrollDestination.CookieShakes:
      productsScreenState?.scrollToCookieShakes();
      break;
    case ScrollDestination.Mojito:
      productsScreenState?.scrollToMojito();
      break;
    case ScrollDestination.FrenchFries:
      productsScreenState?.scrollToFrenchFries();
      break;
    case ScrollDestination.ChickenWings:
      productsScreenState?.scrollToChickenWings();
      break;
  }
}
}

enum ScrollDestination {
  CookieShakes,
  Mojito,
  FrenchFries,
  ChickenWings,
}