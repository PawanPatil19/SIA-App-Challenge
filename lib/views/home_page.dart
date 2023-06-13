import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                Text('Merchant Name', style: TextStyle(color: kPrimaryColor, fontSize: 30),),
                Text('Merchant Details', style: TextStyle(color: kPrimaryColor, fontSize: 15),),
                SizedBox(height: 20,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.discount_outlined, color: Colors.grey, size: 35,)
                            ),
                          SizedBox(height: 10,),
                          Text('Offers & promotions', style: TextStyle(color: kPrimaryColor, fontSize: 15), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                    SizedBox(width: 50,),
                     Container(
                      width: 70,
                       child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: kPrimaryColor,
                            ),
                            padding: EdgeInsets.all(15),
                            child: Icon(Icons.bar_chart_outlined, color: Colors.grey, size: 35,)
                            ),
                          SizedBox(height: 10,),
                          Text('Customer Engagement', style: TextStyle(color: kPrimaryColor, fontSize: 15), textAlign: TextAlign.center,),
                        ],
                                       ),
                     ),
                  ],
                ),
    
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: kPrimaryColor,
                          ),
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.settings_outlined, color: Colors.grey, size: 35,)
                          ),
                        SizedBox(height: 10,),
                        Text('Settings', style: TextStyle(color: kPrimaryColor, fontSize: 15), ),
                      ],
                    ),
                    SizedBox(width: 50,),
                     Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: kPrimaryColor,
                          ),
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.share_outlined, color: Colors.grey, size: 35,)
                          ),
                        SizedBox(height: 10,),
                        Text('Marketing', style: TextStyle(color: kPrimaryColor, fontSize: 15), ),
                      ],
                    ),
                  ],
                ),
              ]),
          ),
    
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Latest Rewards by you', style: TextStyle(color: kTextColor, fontSize: 20)),
            ]),
          )
        ],
      ),
      Positioned(
            top: 350,
            right:0,
            child: RawMaterialButton(
              onPressed: (){
                
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