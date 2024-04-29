import 'package:flutter/material.dart';
import 'package:wanderwise/user_auth/tour_guide/tgsregister.dart';

class Tg_ForgotPassword extends StatefulWidget {
  const Tg_ForgotPassword({super.key});

  @override
  State<Tg_ForgotPassword> createState() => _Tg_ForgotPasswordState();
}

class _Tg_ForgotPasswordState extends State<Tg_ForgotPassword> {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/logo.png', height: size.height *0.2,),
                Text('Password Recovery',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ),),
                Text('Enter your Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),),
                Form(child: Column(
                  children:[
                     TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: 'Email',
                              hintText: 'Email',
                              border: OutlineInputBorder()
                            ) ,
                          ),
                          SizedBox(
                            height: 10,
                          )
                  ]
                )),
                 SizedBox(width:double.infinity,
                 child:  ElevatedButton(onPressed: () {
                 },
                 style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blue,
                      side: BorderSide(color: Colors.black),
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ), child: Text('Send Email'.toUpperCase()),
                        )),
                         Center(
                child: TextButton(onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (c)=> TgRegister()));
                }, child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(text: "Don't have an account?",
                  style: TextStyle(color: Colors.black),
                  
                children: [
                  TextSpan(text: 'Register Here',
                  style: TextStyle(color: Colors.blue),),
                  
                ]))),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}