import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';
import 'package:sia_app/views/login_page.dart' as login;
import 'package:intl/intl.dart';
import 'package:sia_app/views/view_offer_page.dart';


class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  var merchantData = login.merchantData;
  get entityName => merchantData['entityName'];
  get entityAddress => merchantData['entityAddress'];

  var offersData = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Column(
        
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
                Text(entityName, style: TextStyle(color: kPrimaryColor, fontSize: 30),),
                Text(entityAddress, style: TextStyle(color: kPrimaryColor, fontSize: 15),),
                SizedBox(height: 20,),
              ]),
          ),

           Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Offers', style: TextStyle(color: kTextColor, fontSize: 20),),
            ]),
          ),

          Expanded(
            child: StreamBuilder(
              stream: db.collection("Offers").where("merchantID", isEqualTo: login.merchantID).snapshots(),
              builder: (context, snapshot) {
                
                // if (snapshot.data!.docs.isEmpty) {
                //   return CircularProgressIndicator(
                //     color: kButtonColor,
                //   );
                // }

                if(snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text('No offers available'),
                  );
                }

                
                
                return StreamBuilder(
                  stream: db.collection("Redemptions").where('offerID', isEqualTo: snapshot.data!.docs[0].id).snapshots(),
                  builder: (context, docSnap) {
                    // if (docSnap.data!.docs.isEmpty) {
                    //   return CircularProgressIndicator(
                    //     color: kButtonColor,
                    //   );
                    // }

                    // if (snapshot.data!.docs.length == 0) {
                    //   return Center(
                    //     child: Text('No offers available'),
                    //   );
                    // }


                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        
                        print(snapshot.data!.docs[index].data().toString());
                        var offerTitle = snapshot.data!.docs[index].data()['title'].toString();
                        var offerAvailability = snapshot.data!.docs[index].data()['isAvailable'].toString();
                        var numberRedemptions = docSnap.data!.docs.length.toString();
                        DateTime startDate = (snapshot.data!.docs[index].data()['startDate'] as Timestamp).toDate();
                        DateTime endDate = (snapshot.data!.docs[index].data()['endDate'] as Timestamp).toDate();
                      
                        var validity = DateFormat('dd MMM yyyy').format(startDate) + ' - ' + DateFormat('dd MMM yyyy').format(endDate);
                        var locations = snapshot.data!.docs[index].data()['locations'].join(', ');
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  //leading: Icon(Icons.local_offer_outlined),
                                  title: Row(
                                    children: [
                                      Text(offerTitle, style: TextStyle(fontSize: 20,),),
                                      const Spacer(),
                                      offerAvailability == 'true' 
                                        ? Text('Active', style: TextStyle(color: Colors.green, fontSize: 15),) 
                                        : Text('Inactive', style: TextStyle(color: Colors.red, fontSize: 15),),
                                    ],
                                  ),
                                  subtitle: Text(validity),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Number of Redemptions: ' + numberRedemptions, style: TextStyle(fontSize: 15 ),),
                                      Row(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Icon(Icons.location_pin, color: Colors.grey, size: 15,),
                                              Text(locations, style: TextStyle(color: Colors.grey, ),),
                                            ],
                                          
                                          ),
                                          const Spacer(),
                                          TextButton(
                                            child: const Text('View', style: TextStyle(color: kButtonColor),),
                                            onPressed: () {
                                              Navigator.pushNamed(context, 'view_offer', arguments: ViewOfferArguments(snapshot.data!.docs[index].id));
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  }
                
                );
                


                
                
                
                
                
                
                
                }
              
            
            ),
          )

          
        ],
      ),
      Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right:0,
            child: RawMaterialButton(
              onPressed: (){
                Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(6));
              },
              fillColor: kButtonColor,
              elevation: 2,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.add, color: kPrimaryColor, size: 40,),
              ) 
          ),
      ]
    );
  }

}