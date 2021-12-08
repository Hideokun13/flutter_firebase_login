import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _value = false;
  String email = '';
  String password = '';
  final formkey = GlobalKey<FormState>();

  void _signOut() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    });
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Icon(
                      Icons.navigate_before,
                      size: 34,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 25)),
                        Container(
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 25)),
                        Container(
                          child: Text(
                            "DyDx Academy",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      emailFormField(),
                      SizedBox(
                        height: 20,
                      ),
                      logoutButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailFormField() {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide.none),
        hintText: "my email here",
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      // validator: (String? value) {
      //   if (!validateEmail(value!)) {
      //     return "Please use valid email address";
      //   }
      //   return null;
      // },
    );
  }

  ElevatedButton logoutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 125.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      onPressed: () {
        // formkey.currentState!.validate();
        _signOut();
      },
      child: Text(
        "Logout",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
