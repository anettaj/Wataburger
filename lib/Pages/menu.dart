import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wataburger/Pages/Login.dart';
import 'ProductsScreen.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    double H=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wataburger', style: TextStyle(fontSize: 15)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: H * 0.5, // Adjust height as needed
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  children: [
                    _buildMenuIcon(
                      Icons.delivery_dining,
                      'Take out',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductsScreen()),
                        );
                      },
                    ),
                    _buildMenuIcon(
                      Icons.hotel,
                      'Book a Table',
                          () {},
                    ),
                    _buildMenuIcon(
                      Icons.support_agent,
                      'Support',
                          () {},
                    ),
                    _buildMenuIcon(
                      Icons.public,
                      'Donate to NGO',
                          () {},
                    ),
                    _buildMenuIcon(
                      Icons.logout,
                      'Logout',
                          () {
                            _logout();
                          },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIcon(IconData iconData, String label, VoidCallback goto) {
    return InkWell(
      onTap: goto,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _logout() {
    _saveLogoutStatus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  void _saveLogoutStatus() async {
    _signOutFirebase();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.remove('id');
  }
  Future<void> _signOutFirebase() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
