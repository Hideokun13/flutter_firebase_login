import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _value = false;
  String email = '';
  String password = '';
  final formkey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  static Future<User?> registerEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    CircularProgressIndicator();
    return user;
  }

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
                            "Register",
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
                            "Signup to experience new ways",
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
                      emailFormField(),
                      SizedBox(
                        height: 20,
                      ),
                      passwordFormField(),
                      SizedBox(
                        height: 40,
                      ),
                      submitBtton(),
                      SizedBox(
                        height: 20,
                      ),
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

  Widget usernameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide.none),
        hintText: "User Name",
        prefixIcon: Icon(Icons.person_outline),
      ),
      validator: (String? value) {
        if (value!.length > 20) {
          return "Username must be less than 20 characters";
        }
      },
    );
  }

  Widget emailFormField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          fillColor: Colors.grey.withOpacity(0.1),
          filled: true,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              borderSide: BorderSide.none),
          hintText: "Email ID",
          prefixIcon: Icon(Icons.alternate_email)),
      keyboardType: TextInputType.emailAddress,
      // validator: (String? value) {
      //   if (!validateEmail(value!)) {
      //     return "Please use valid email address";
      //   }
      //   return null;
      // },
    );
  }

  Widget phoneNumberFormField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide.none),
        hintText: "Mobile No",
        prefixIcon: Icon(Icons.phone_outlined),
      ),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value![0] != "0") {
          return "Please enter valid mobile number";
        } else if (value.length != 10) {
          return "Mobile Number must be 10 digits";
        }
        return null;
      },
    );
  }

  Widget passwordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: BorderSide.none),
        hintText: "Enter Password",
        prefixIcon: Icon(Icons.lock_outline),
      ),
      // validator: (value) {
      //   if (!validatePassword(value!)) {
      //     return "Password must be minimum eight characters, at least one uppercase letter, one lowercase letter and one number";
      //   }
      //   return null;
      // },
      keyboardType: TextInputType.visiblePassword,
    );
  }

  ElevatedButton submitBtton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 125.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      onPressed: () async {
        // formkey.currentState!.validate();
        User? user = await registerEmailPassword(
            email: _emailController.text,
            password: _passwordController.text,
            context: context);
        print(user?.uid);
        if (user != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()));
        }
      },
      child: Text(
        "Register",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget agreementCheckBox() {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 15)),
        Checkbox(
          value: _value,
          onChanged: (newValue) {
            setState(() {
              _value = newValue!;
            });
          },
        ),
        Text(
          "I accept with the",
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "Term & Conditions",
              style: TextStyle(color: Colors.black),
            )),
      ],
    );
  }

  bool validateEmail(String value) {
    RegExp regex = new RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
    return (!regex.hasMatch(value) ? false : true);
  }

  bool validatePassword(String value) {
    RegExp regex = new RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    return (!regex.hasMatch(value) ? false : true);
  }
}
