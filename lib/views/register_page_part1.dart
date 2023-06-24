
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


String? countryDropdownValue;
String? entityTypeDropdownValue;
String merchantEmail = '';
String? merchantName;
String? merchantID;
String? entityName;
String? entityAddress;
String? entityNumber;
String password = '';
String? confirmPassword;
bool isVerified = false;
String? uploadURL;

class RegisterMerchantPage extends StatefulWidget {
  const RegisterMerchantPage({super.key});

  @override
  State<RegisterMerchantPage> createState() => _RegisterMerchantPageState();
}

class _RegisterMerchantPageState extends State<RegisterMerchantPage> {
  List<String> countryList = <String>['Select current location', 'Singapore', 'India'];
  List<String> entityTypeList = <String>['Select one entity type', 'Restaurant', 'Retail', 'Services', 'Food & Beverage', 'Others'];

  FirebaseAuth auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  CollectionReference merchants = FirebaseFirestore.instance.collection('Merchants');

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  Reference? uploadDocRef;
  

  int currentStep = 0;

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        //uploadFile();
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
        //uploadFile();
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
        // Uploading the selected image with some custom meta data

        uploadDocRef = storage.ref(destination);
        await uploadDocRef?.putFile(_photo!).whenComplete(() async {
          uploadURL = await uploadDocRef!.getDownloadURL();
          print('Uploaded: ' + uploadURL.toString());
        });

        // Refresh the UI
        
      } catch (error) {
        print(error);
      }
  }

  @override
  void initState() {
    countryDropdownValue = countryList.first;
    entityTypeDropdownValue = entityTypeList.first;
  }

  Future<void> addMerchant() async {
      if (password != null && confirmPassword!= null && password == confirmPassword) {
        final newUser = await auth.createUserWithEmailAndPassword(email: merchantEmail, password: password);
        uploadFile();

        return merchants
            .add({
              'merchantEmail': merchantEmail,
              'merchantName': merchantName,
              'merchantLocation': countryDropdownValue,
              'merchantID': merchantID,
              'entityType': entityTypeDropdownValue,
              'entityName': entityName,
              'entityNumber': entityNumber,
              'entityAddress': entityAddress,
              'password': password,
              'isVerified': isVerified,
              'createdAt': FieldValue.serverTimestamp(),
              'uploadDocumentRef': uploadURL
            })
            .then((value) => print("Merchant Registered "))
            .catchError((error) => print("Failed to register merchant: $error"));
      } else {
        print("Passwords do not match");
      }

      return Future.value();
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
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: kButtonColor
          )
          
        ),
        child: Container(
              padding: const EdgeInsets.all(20),
              child: Stepper(
                type: StepperType.horizontal,
                physics: ScrollPhysics(),
                currentStep: currentStep,
                elevation: 0,
                
                onStepCancel: () => currentStep == 0
                    ? Navigator.of(context).pop()
                    : setState(() {
                        currentStep -= 1;
                      }),
                onStepContinue: () {
                  bool isLastStep = (currentStep == getSteps(context).length - 1);
                  if (isLastStep) {
                    addMerchant();
                    Navigator.pushNamed(context, 'verification_page');
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepTapped: (step) => setState(() {
                  currentStep = step;
                }),
                steps: getSteps(context),
              )),
      ),
    );
  }

  List<Step> getSteps(BuildContext context) {
    return <Step>[
      Step(
        title: const Text('Merchant Details'),
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        content: merchantDetails(context),
      ),
      Step(
        title: const Text('Set your password'),
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        content: passwordDetails(context),
      ),
      
    ];
  }




  Widget merchantDetails(BuildContext context) {
    return Container(
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
                          merchantName = s;
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
                            countryDropdownValue = value.toString()!;
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
                          merchantID = s;
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
                            entityTypeDropdownValue = value.toString()!;
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
                          entityName = s;
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
                        'Enity Registration Number',
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
                          entityNumber = s;
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
                          entityAddress = s;
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

  
            ],
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


  Widget passwordDetails(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
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
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Enter your password'),
                        onChanged: (s) {
                          password = s;
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
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Re-enter your password'),
                        onChanged: (s) {
                          confirmPassword = s;
                        },
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  

}