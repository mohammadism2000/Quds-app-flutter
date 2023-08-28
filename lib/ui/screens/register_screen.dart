import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quds1_flutter/ui/screens/login_screen.dart';

import 'Buttomnavagation.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (!value.toString().contains('@') &&
                        value.toString().isEmpty) {
                      return 'Enter Valid Email';
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.orange,
                    ),
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value.toString().length < 6 ||
                        value.toString().isEmpty) {
                      return 'Enter Valid Password';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.orange,
                    ),
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.toString().length < 6 ||
                        value.toString().isEmpty) {
                      return 'Enter Valid Password';
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Re-Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.orange,
                    ),
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : MaterialButton(
                          child: Text(
                            'SignUP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          minWidth: 300,
                          height: 50,
                          color: Colors.orange,
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Buttomnavagation(),
                                    ));
                              });
                            }

                          },
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Have already an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
