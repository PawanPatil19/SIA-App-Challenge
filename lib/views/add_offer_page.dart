import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/view_offer_page.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sia_app/views/login_page.dart' as login;


class AddOfferPage extends StatefulWidget {
  const AddOfferPage({super.key});

  @override
  State<AddOfferPage> createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  String title = '';
  String description = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<String> locations = [];
  String terms = '';

  String? offerID;


  bool isCheckedSingapore = false;
  bool isCheckedIndia = false;

  String creatorMerchant = login.merchantID;
  


  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startDate = args.value.startDate;
      endDate = args.value.endDate;  
    });
  }

  CollectionReference offers = FirebaseFirestore.instance.collection('Offers');
  

  Future<void> addOffer() {
      // Call the user's CollectionReference to add a new offer
      return offers
          .add({
            'title': title, 
            'description': description, 
            'startDate': startDate, 
            'endDate': endDate, 
            'locations': locations, 
            'terms': terms, 
            'createdAt': DateTime.now(),
            'merchantID': creatorMerchant,
            'isAvailable': true
          })
          .then((docRef) => setState(() {
            offerID = docRef.id;
            print('Offer ID: ' + offerID!);
            Navigator.pushNamed(context, 'view_offer', arguments: ViewOfferArguments(offerID!));
          }))
          .catchError((error) => print("Failed to add offeer: $error"));
    }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Add a promotional offer', style: TextStyle(color: kTextColor, fontSize: 30),),
              
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
                        'Title',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 3,
                      right: 30,
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Enter offer title'),
                        onChanged: (s) {
                          title = s;
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
                      height: 90,
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
                        'Description',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 30,
                      right: 30,
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Enter a short description'),
                        minLines: 1,
                        maxLines: 5,
                        onChanged: (s) {
                          description = s;
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
                      height: 330,
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
                        'Validity period',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 3,
                      right: 30,
                      child: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
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
                      height: 120,
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
                        'Locations',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 3,
                      right: 30,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ), //SizedBox
                              Text(
                                'Singapore',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ), //TextStyle
                              ), //Text
                              const Spacer(),
                              /** Checkbox Widget **/
                              Checkbox(
                                value: isCheckedSingapore,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedSingapore = value!;
                                  });
                                  if (isCheckedSingapore == true) {
                                    setState(() {
                                      locations.add('Singapore');
                                    }); //setState
                                  } else {
                                    setState(() {
                                      locations.remove('Singapore');
                                    }); //setState
                                  }  //Checkbox
                                }, //Checkbox
                              ), //Checkbox
                            ], //<Widget>[]
                          ),

                          Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 10,
                              ), //SizedBox
                              const Text(
                                'India',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ), //TextStyle
                              ), //Text
                              const Spacer(),
                              /** Checkbox Widget **/
                              Checkbox(
                                value: isCheckedIndia,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedIndia = value!;
                                  }); //Checkbox
                                  if (isCheckedIndia == true) {
                                    setState(() {
                                      locations.add('India');
                                    }); //setState
                                  } else {
                                    setState(() {
                                      locations.remove('India');
                                    }); //setState
                                  } 
                                }, //Checkbox
                              ), //Checkbox
                            ], //<Widget>[]
                          ),

                          
                        ]
                      )
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
                      height: 90,
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
                        'Terms & Conditions',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 30,
                      right: 30,
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Enter all terms & conditions'),
                        minLines: 1,
                        maxLines: 5,
                        onChanged: (s) {
                          terms = s;
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
                      addOffer();
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
    );
  }

}