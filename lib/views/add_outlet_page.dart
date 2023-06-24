import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sia_app/views/login_page.dart' as login;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class AddOutletPage extends StatefulWidget {
  const AddOutletPage({super.key});

  @override
  State<AddOutletPage> createState() => _AddOutletPageState();
}

class _AddOutletPageState extends State<AddOutletPage> {
  String outletAddress = '';
  String outletContact  = '';
  String outletStatus = 'Under Review';

  String creatorMerchant = login.merchantID;
  
  CollectionReference outlets = FirebaseFirestore.instance.collection('Outlets');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

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
  

  Future<void> addOutlet(BuildContext context) {
      // Call the user's CollectionReference to add a new offer
      return outlets
          .add({
            'outletAddress': outletAddress, 
            'outletContact': outletContact,
            'createdAt': DateTime.now(),
            'merchantID': creatorMerchant,
            'outletStatus': outletStatus,
          })
          .then((docRef) => setState(() {
            Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(3));
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
              Text('Add an outlet', style: TextStyle(color: kTextColor, fontSize: 30),),
              
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
                        'Outlet Address',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 30,
                      right: 30,
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Enter the registered outlet address'),
                        minLines: 1,
                        maxLines: 5,
                        onChanged: (s) {
                          outletAddress = s;
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
                        'Outlet Contact',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 3,
                      right: 30,
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Enter contact number for the outlet'),
                        onChanged: (s) {
                          outletContact = s;
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
                      addOutlet(context);
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