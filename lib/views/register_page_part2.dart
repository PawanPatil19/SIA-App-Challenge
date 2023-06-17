import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sia_app/views/register_page_part1.dart' as register;

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class RegisterMerchantPage2 extends StatefulWidget {
  const RegisterMerchantPage2({super.key});

  @override
  State<RegisterMerchantPage2> createState() => _RegisterMerchantPage2State();
}

class _RegisterMerchantPage2State extends State<RegisterMerchantPage2> {

  String? merchantEmail = register.merchantEmail;
  String? location;
  String? merchantName;
  String? merchantID;
  String? entityName;
  String? entityAddress;
  String? entityType;
  String? entityNumber;
  

  CollectionReference merchants = FirebaseFirestore.instance.collection('Merchants');

  Future<void> addOffer() {
      // Call the user's CollectionReference to add a new offer
      return merchants
          .add({
            
          })
          .then((value) => print("Offer Added for user: "))
          .catchError((error) => print("Failed to add offeer: $error"));
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        // add a icon to right
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_sharp),
            onPressed: () {
              // do something
              Navigator.pushNamed(context, 'login_page');
              
            },
          )
        ],
        
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: MediaQuery.of(context).size.width,
        child: Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Register with us', style: TextStyle(color: kTextColor, fontSize: 30),),

                
                
                const SizedBox(height: 20,),
                
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter your password'),
                          onChanged: (s) {
                            merchantEmail = s;
                          },
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20,),
                
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                          'Confirm Password',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Re-enter your password'),
                          onChanged: (s) {
                            merchantEmail = s;
                          },
                        ),
                      )
                    ],
                  ),
                ),


                const SizedBox(height: 20,),
    
                Container(
                    
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        
                      },
                      child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 20),),
                      style: ElevatedButton.styleFrom(
                        primary: kButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        
                      ),
                    ),
                  ),
    
    
              ],
            ),
          ),
        ),
      ),
    );
  }

}