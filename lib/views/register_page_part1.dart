import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


String? countryDropdownValue;
String? entityTypeDropdownValue;
String? merchantEmail;
String? location;
String? merchantName;
String? merchantID;
String? entityName;
String? entityAddress;
String? entityType;
String? entityNumber;

class RegisterMerchantPage extends StatefulWidget {
  const RegisterMerchantPage({super.key});

  @override
  State<RegisterMerchantPage> createState() => _RegisterMerchantPageState();
}

class _RegisterMerchantPageState extends State<RegisterMerchantPage> {
  List<String> countryList = <String>['Select current location', 'Singapore', 'India'];
  List<String> entityTypeList = <String>['Select one entity type', 'Restaurant', 'Retail', 'Services', 'Food & Beverage', 'Others'];

  
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  CollectionReference merchants = FirebaseFirestore.instance.collection('Merchants');

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  @override
  void initState() {
    countryDropdownValue = countryList.first;
    entityTypeDropdownValue = entityTypeList.first;
  }

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
                          'Merchant Email',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter your email'),
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
                          'Merchant Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter your full name'),
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
                          'Country',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: DropdownButton<String>(
                          value: countryDropdownValue,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: kTextColor, fontSize: 16, fontFamily: 'Fredoka'),
                          underline: Container(
                            height: 2,
                            color: kButtonColor,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              countryDropdownValue = value!;
                            });
                          },
                          items: countryList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
                          'Merchant ID',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter your country specific ID registered with entity'),
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
                          'Entity Type',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: DropdownButton<String>(
                          value: entityTypeDropdownValue,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: kTextColor, fontSize: 16, fontFamily: 'Fredoka'),
                          underline: Container(
                            height: 2,
                            color: kButtonColor,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              entityTypeDropdownValue = value!;
                            });
                          },
                          items: entityTypeList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
                          'Entity Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter your entity name'),
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
                          'Enity Number',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter your entity number'),
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
                          'Entity Address',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Enter your entity address'),
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
                          'Entity Registration Certificate',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: 3,
                        right: 30,
                         // add a image upload button
                        child:  _photo == null ? IconButton(
                          icon: Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 20,),
                          onPressed: () {
                            _showPicker(context);
                          },
                        ) : IconButton(
                          icon: Icon(Icons.check, color: Colors.grey, size: 20,),
                          onPressed: () {
                            _showPicker(context);
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
                        Navigator.pushNamed(context, 'register_page2');
                      },
                      child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 20),),
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}