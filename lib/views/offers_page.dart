import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';


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
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
            ),
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
            top: MediaQuery.of(context).size.height * 0.1,
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