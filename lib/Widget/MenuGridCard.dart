import 'package:flutter/material.dart';


class MenuGridCard extends StatelessWidget {
  const MenuGridCard({
    super.key,
    required this.H,
    required this.W,
    required this.address,
    required this.title,
    required this.des,
    required this.Navi,
    required this.color,
  });

  final double H;
  final double W;
  final String address;
  final String title;
  final String des;
  final Color color;
  final VoidCallback Navi;



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 50),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          top: H*0.01,
          left: W*0.085,
          child: Image.network(address,
            height: 100,
          ),
        ),
        Positioned(
            top: H*0.12,
            left: W*0.03,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 10),
                    height: H*0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                        Container(
                          width: W*0.41,
                          height: H*0.05,
                          child: Center(
                            child: Text(des,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: Navi,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),

                            ),
                            child: Text('View items',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11
                              ),)
                        )
                      ],
                    )
                ),
              ],
            )
        )
      ],
    );
  }
}