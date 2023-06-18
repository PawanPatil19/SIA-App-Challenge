import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ViewOfferArguments {
  final String offerID;
  ViewOfferArguments(this.offerID);
}

class ViewOfferPage extends StatefulWidget {
  const ViewOfferPage({super.key});

  @override
  State<ViewOfferPage> createState() => _ViewOfferPageState();
}

class _ViewOfferPageState extends State<ViewOfferPage> {
  String? offerID;


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ViewOfferArguments?;
    if (args != null) offerID = args.offerID;
    print('Offer ID: ' + offerID!);

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


      body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Offers').doc(offerID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        String startDate = DateFormat('dd MMM yyyy').format(userDocument?['startDate'].toDate());
        String endDate = DateFormat('dd MMM yyyy').format(userDocument?['endDate'].toDate());
        String validity = startDate + ' - ' + endDate;
        return  Container(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Offer Title', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                Text(userDocument?['title'], style: TextStyle(fontSize: 20)),
        
                const SizedBox(height: 20),
        
                Text('Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                Text(userDocument?['description'], style: TextStyle(fontSize: 20)),
        
                const SizedBox(height: 20),
        
                Text('Offer Validity', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                Text(validity, style: TextStyle(fontSize: 20)),
        
                const SizedBox(height: 20),
        
        
                Text('Locations', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                Text(userDocument?['locations'].join(', '), style: TextStyle(fontSize: 20)),
        
                const SizedBox(height: 20),
        
                Text('Terms & Conditions', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                Text(userDocument?['terms'], style: TextStyle(fontSize: 20)),
        
        
              ],
            ),
        );
      }
      )
    );
  }

}