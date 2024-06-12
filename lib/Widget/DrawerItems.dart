import 'package:flutter/material.dart';

class DrawerItems extends StatelessWidget {
  final String name;
  final VoidCallback goto;
  final IconData icon;
  const DrawerItems({
    super.key, required this.name, required this.goto, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>goto,
      child:Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              ),
              // color: Colors.black.withOpacity(0.6)
            ),
            child: Row(
              children: [
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(name,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),


        ],
      ),
      )
    );
  }
}