import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';
import 'package:intl/intl.dart';
import 'package:sia_app/views/login_page.dart' as login;


class CustomerEngagementPage extends StatefulWidget {
  const CustomerEngagementPage({super.key});

  @override
  State<CustomerEngagementPage> createState() => _CustomerEngagementPageState();
}

class _CustomerEngagementPageState extends State<CustomerEngagementPage> {
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

          

          Padding(
            padding: const EdgeInsets.only(top:20),
            child: SizedBox(
              child: StreamBuilder(
                  stream: db.collection("Redemptions").where("merchantID", isEqualTo: login.merchantID).snapshots(),
                  builder: (context, snapshot) {
                    
                    // if (snapshot.data!.docs.isEmpty) {
                    //   return const CircularProgressIndicator(
                    //     color: kButtonColor,
                    //   );
                    // }

                    if(snapshot.data!.docs.length == 0) {
                      return Center(
                        child: Text('No redemptions yet'),
                      );
                    }
            
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)
                      ),
                      child: Column(
                        children: [
                          const Text('Total redemptions:', style: TextStyle(color: Colors.grey, fontSize: 15,),),  
                          Text(snapshot.data!.docs.length.toString(), style: TextStyle(color: kTextColor, fontSize: 30,),),
                      ]),
                    );
            
                  }
            
              ),
            ),
          ),

          



          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Redemptions', style: TextStyle(color: kTextColor, fontSize: 20),),
            ]),
          ),

          

          Expanded(
            child: StreamBuilder(
              stream: db.collection("Redemptions").where("merchantID", isEqualTo: login.merchantID).snapshots(),
              builder: (context, snapshot) {
                
                // if (snapshot.data!.docs.isEmpty) {
                //   return CircularProgressIndicator(
                //     color: kButtonColor,
                //   );
                // }

                if(snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text('No redemptions yet'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
              
                    var offerID = snapshot.data!.docs[index]['offerID'];
                    var outletID = snapshot.data!.docs[index]['outletID'];
                    var customerName = snapshot.data!.docs[index]['customerName'];
                    DateTime date = (snapshot.data!.docs[index]['redemptionDate'] as Timestamp).toDate();
                    var redemptionsDate = DateFormat('dd MMM yyyy').format(date);
                    

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                //leading: Icon(Icons.local_offer_outlined),
                                title: Text("Customer Name: ${customerName}", style: TextStyle(fontSize: 20,),),
                                subtitle: Text("Offer ID ${offerID}"),

                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        
                                        Text("Outlet ID: ${outletID}", style: TextStyle(color: Colors.grey, ),),
                                      ],
                                    
                                    ),
                                    const Spacer(),
                                    Text(redemptionsDate, style: TextStyle(color: Colors.grey, ),),
                                    const SizedBox(width: 8),
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