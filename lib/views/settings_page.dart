import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';
import 'package:intl/intl.dart';
import 'package:sia_app/views/login_page.dart' as login;


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var merchantData = login.merchantData;
  get entityName => merchantData['entityName'];
  get entityAddress => merchantData['entityAddress'];

  var redemptionsData = [];

  @override
  Widget build(BuildContext context) {
    return Column(
        
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entityName, style: const TextStyle(color: kPrimaryColor, fontSize: 30),),
                Text(entityAddress, style: const TextStyle(color: kPrimaryColor, fontSize: 15),),
                const SizedBox(height: 20,),
              ]),
          ),

          const SizedBox(height: 20,),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(7));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey)
              ),
              child: Column(
                children: [
                  Text('Add an outlet:', style: TextStyle(color: Colors.grey, fontSize: 15,),),  
                  Icon(Icons.add,)
              ]),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your outlets', style: TextStyle(color: kTextColor, fontSize: 20),),
            ]),
          ),

          

          Expanded(
            child: StreamBuilder(
              stream: db.collection("Outlets").where("merchantID", isEqualTo: login.merchantID).snapshots(),
              builder: (context, snapshot) {
                
                // if (snapshot.data!.docs.isEmpty) {
                //   return CircularProgressIndicator(
                //     color: kButtonColor,
                //   );
                // }
                if(snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text('No registered outlets'),
                  );
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
              
                    
                    var outletID = snapshot.data!.docs[index].id;
                    var outletAddress = snapshot.data!.docs[index]['outletAddress'];
                    var outletContact = snapshot.data!.docs[index]['outletContact'];
                    var outletStatus = snapshot.data!.docs[index]['outletStatus'];
                    Color statusColor = Colors.grey;
                    if (outletStatus == "Active") {
                      statusColor = Colors.green;
                    } else if (outletStatus == "Rejected") {
                      statusColor = Colors.red;
                    } else {
                      statusColor = kButtonColor;
                    }
                    

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: 
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListTile(
                                    //leading: Icon(Icons.local_offer_outlined),
                                    title: Text("${outletAddress}", style: TextStyle(fontSize: 20,),),
                                    subtitle: Text("Outlet ID: ${outletID}"),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      children: [
                                        Text("Outlet Contact: ${outletContact}", style: TextStyle(color: Colors.grey, ),),
                                        const Spacer(),
                                        Text("${outletStatus}", style: TextStyle(color: statusColor),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                          ),
                      );
                    }
                  );
                }
            ),
          )


    
          
        ],
      );
  }

}