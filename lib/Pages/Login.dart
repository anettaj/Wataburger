import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Menu.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isProcessing = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Logo.png', height: height * 0.16),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailController,
                  focusNode: _focusEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      labelText: 'Email',
                  ),
                  onTap: () {
                    print("Email field tapped");
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _focusPassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  onTap: () {
                    print("Password field tapped");
                  },
                ),
                SizedBox(height: 24.0),
                _isProcessing
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () async {
                    _focusEmail.unfocus();
                    _focusPassword.unfocus();

                    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                      setState(() {
                        _isProcessing = true;
                      });

                      try {
                        User? user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ).then((value) => value.user);

                        if (user != null) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', true);
                          prefs.setString('userName', user.displayName ?? '');
                          prefs.setString('userId', user.uid);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Menu()),
                          );
                        }
                      } catch (e) {
                        print("Login failed: $e");
                      } finally {
                        setState(() {
                          _isProcessing = false;
                        });
                      }
                    } else {
                      // Show error message if fields are empty
                      print("Email and password cannot be empty");
                    }
                  },
                  child: Text('Sign In', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 0)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ),
                ),
                Text('Dont forget the password is: Admin1'),
                Text('Dont forget the email is: anuanet85@gmail.com'),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
