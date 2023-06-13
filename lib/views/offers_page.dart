import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
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
                
                
              ]),
          ),
    
          
        ],
      ),
      Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
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