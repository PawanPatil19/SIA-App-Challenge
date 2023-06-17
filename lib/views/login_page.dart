import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sia_app/views/layout.dart';


 User? user;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

 

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 80),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Image.asset('assets/images/logo.png',)
                    )
                ),
        
                SizedBox(height: 50,),
        
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      const Positioned(
                        top: 3,
                        left: 30,
                        child: Text(
                          'Email Address',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter email'),
                          onChanged: (s) {
                            email = s;
                          },
                        ),
                      )
                    ],
                  ),
                ),
        
                SizedBox(height: 20,),
        
                Container(
                  width: MediaQuery.of(context).size.width * 0.8, 
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      const Positioned(
                        top: 3,
                        left: 30,
                        child: Text(
                          'Password',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter password'),
                          onChanged: (s) {
                            password = s;
                          },
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30,),

                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: this.email,
                          password: this.password
                        );
                        user = userCredential.user;
                        Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(0));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      primary: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      
                    ),
                  ),
                ),



                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register_page');
                  }, 
                  child: Text('Not yet Registered?', style: TextStyle(color: kTextColor, fontSize: 15),)
                ),

                SizedBox(height: 20,),

                IconButton(onPressed: () {}, icon: Icon(Icons.fingerprint, color: kSecondaryColor, size: 50,)),
        
        
              ],
          ),
        ),
      );
  }
}