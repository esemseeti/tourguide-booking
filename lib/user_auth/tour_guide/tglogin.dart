import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wanderwise/ui/ui_tg/home.dart';
import 'package:wanderwise/user_auth/tour_guide/tg_fpw.dart';
import 'package:wanderwise/user_auth/tour_guide/tgsregister.dart';

class TgLogIn extends StatefulWidget {
  const TgLogIn({super.key});

  @override
  State<TgLogIn> createState() => _TgLogInState();
}

class _TgLogInState extends State<TgLogIn> {

  String email="", password="";

  TextEditingController emailController = new TextEditingController();
  TextEditingController pwController= new TextEditingController();

  bool _isObscure= true;

  final _formkey = GlobalKey<FormState>();

 userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (contexxt)=>THome()));
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:Colors.blue,
          content:  
        Text('No User Found for that Email')));

      }else if( e.code=='wrong-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text('Wrong Password Provided by User')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:Container(
            padding: EdgeInsets.all(30),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Image.asset('assets/logo.png', height: size.height *0.2,),
              Text('Log-In',
              style: TextStyle(color: Colors.blue,
              fontSize: 30,fontWeight: FontWeight.bold),),
              //  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
              // style: TextStyle(color: Colors.blue,
              // fontSize: 10,),),

              Form(
                key:_formkey,
                child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        labelText: 'Email',
                        hintText: 'Email',
                        border: OutlineInputBorder()
                      ) ,
                    ),
                    SizedBox(height: 10,),
                     TextFormField(
                       validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: pwController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Password',
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: 
                        (){
                               setState(() {
          _isObscure = !_isObscure; 
        });
                        },  icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off), )
                      ) ,
                    ),
                    const SizedBox(height: 10,),
                    Align(alignment: Alignment.centerRight,child: TextButton(onPressed: ()async {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Tg_ForgotPassword()));
                    }, child: Text('Forgot Password',style:TextStyle(color: Colors.blue),))),
                    SizedBox(width:double.infinity,child:  ElevatedButton(onPressed: () {
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          email=emailController.text;
                          password=pwController.text;
                        });
                      }
                      userLogin();
                    },style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.symmetric(vertical: 20),
              ), child: Text('LogIn'.toUpperCase()),
                  )),
                  ],
                ),
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
            ],)
          )
        )
      ),
    );
  }
}