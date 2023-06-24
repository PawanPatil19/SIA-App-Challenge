import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';
import 'package:sia_app/views/login_page.dart' as login;
import 'package:sia_app/views/view_offer_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var merchantData = login.merchantData;
  get entityName => merchantData?['entityName'];
  get entityAddress => merchantData?['entityAddress'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            color: kSecondaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entityName, style: const TextStyle(color: kPrimaryColor, fontSize: 30),),
                Text(entityAddress, style: TextStyle(color: kPrimaryColor, fontSize: 15),),
                SizedBox(height: 20,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(1));
                      },
                      child: Container(
                        width: 80,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: kPrimaryColor,
                              ),
                              padding: const EdgeInsets.all(15),
                              child: const Icon(Icons.discount_outlined, color: Colors.grey, size: 35,)
                              ),
                            const SizedBox(height: 10,),
                            const Text('Offers & promotions', style: TextStyle(color: kPrimaryColor, fontSize: 15), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 50,),
                     Container(
                      width: 80,
                       child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(2));
                          },
                         child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: kPrimaryColor,
                              ),
                              padding: const EdgeInsets.all(15),
                              child: const Icon(Icons.bar_chart_outlined, color: Colors.grey, size: 35,)
                              ),
                            const SizedBox(height: 10,),
                            const Text('Customer Engagement', style: TextStyle(color: kPrimaryColor, fontSize: 15), textAlign: TextAlign.center,),
                          ],
                                         ),
                       ),
                     ),
                  ],
                ),
    
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(3));
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kPrimaryColor,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: const Icon(Icons.location_city_outlined, color: Colors.grey, size: 35,)
                            ),
                          const SizedBox(height: 10,),
                          const Text('Outlets', style: TextStyle(color: kPrimaryColor, fontSize: 15), ),
                        ],
                      ),
                    ),
                    SizedBox(width: 50,),
                     GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(8));
                        },
                       child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kPrimaryColor,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: const Icon(Icons.share_outlined, color: Colors.grey, size: 35,)
                            ),
                          const SizedBox(height: 10,),
                          const Text('Marketing', style: TextStyle(color: kPrimaryColor, fontSize: 15), ),
                        ],
                                         ),
                     ),
                  ],
                ),
              ]),
          ),
    
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Latest Rewards by you', style: TextStyle(color: kTextColor, fontSize: 20)),
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
                return GridView.builder(
                    
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 170
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var offerTitle = snapshot.data!.docs[index].data()['title'].toString();
                      return GestureDetector(
                        onTap: (){
                           Navigator.pushNamed(context, 'view_offer', arguments: ViewOfferArguments(snapshot.data!.docs[index].id));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kSecondaryColor,
                            image: DecorationImage(
                              image: AssetImage('assets/images/card.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                      
                          child: Text(offerTitle, style: const TextStyle(color: Colors.white, fontSize: 20),)
                        ),
                      );
                    }
                );
              }
            ),
          )

        ],
      ),
      Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right:0,
            child: RawMaterialButton(
              onPressed: (){
                Navigator.pushNamed(context, 'home_screen', arguments: LayoutArguments(6));
              },
              fillColor: kButtonColor,
              elevation: 2,
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add, color: kPrimaryColor, size: 40,),
              ) 
          ),
      ]
    );
  }

}