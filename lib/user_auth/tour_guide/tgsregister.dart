import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanderwise/ui/ui_tg/tg_home.dart';
import 'package:wanderwise/user_auth/tourist/tlogin.dart';

class TgRegister extends StatefulWidget {
  const TgRegister({Key? key}) : super(key: key);

  @override
  State<TgRegister> createState() => _TgRegisterState();
}

class _TgRegisterState extends State<TgRegister> {
  String email = "", password = "", fname = "", lname = "", cpassword = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController cpwController = TextEditingController();
    TextEditingController pnController = TextEditingController();
      TextEditingController aController = TextEditingController();
        bool _isObscure = true;

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (_formkey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: pwController.text,
        );
         FirebaseFirestore db = FirebaseFirestore.instance;

                    final user = <String, String>{
                      "first_name": fnameController.text,
                      "last_name": lnameController.text,
                      'address': aController.text,
                      'phone_number': pnController.text,

                    };
                    db
                        .collection("users")
                        .doc(credential.user!.uid)
                        .set(user)
                        .onError((e, _) => print("Error writing document: $e"));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registered Successfully')),
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (c) => TgHome()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        } else {
          print('Registration failed: $e');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.2,
                child: Image.asset('assets/logo.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Register Here',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(
              //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
              //   style: TextStyle(
              //     color: Colors.blue,
              //     fontSize: 14,
              //   ),
              // ),
              SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter first name';
                              }
                              return null;
                            },
                            controller: fnameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              labelText: 'First Name',
                              hintText: 'First Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter last name';
                              }
                              return null;
                            },
                            controller: lnameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              labelText: 'Last Name',
                              hintText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                       validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter phone number';
                              }
                              return null;
                            },
                            controller: pnController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        labelText: 'Phone Number',
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                       validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter address';
                              }
                              return null;
                            },
                            controller: aController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        labelText: 'Address',
                        hintText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter password';
                        }
                        return null;
                      },
                      controller: pwController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          _isObscure = !_isObscure; 
        });
      },
      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off), 
    ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        }
                        return null;
                      },
                      controller: cpwController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                   onPressed: () {
        setState(() {
          _isObscure = !_isObscure; 
        });
      },
      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off), 
    ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: registration,
                         style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.blue,
                              side: BorderSide(color: Colors.black),
                              padding: EdgeInsets.symmetric(vertical: 20),
                            ),
                        child: Text('Register'.toUpperCase()),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => TLogIn()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Login Here',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
