import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/layout.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sia_app/views/qr_image.dart';
import 'package:sia_app/views/login_page.dart' as login;


class QRGeneratePage extends StatefulWidget {
  const QRGeneratePage({super.key});

  @override
  State<QRGeneratePage> createState() => _QRGeneratePageState();
}

class _QRGeneratePageState extends State<QRGeneratePage> {
  String url = 'https://www.google.com';
  var merchantData = login.merchantData;
  get entityName => merchantData['entityName'];
  get entityAddress => merchantData['entityAddress'];

  @override
  Widget build(BuildContext context) {
    return Column(
        
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
                Text(entityName, style: TextStyle(color: kPrimaryColor, fontSize: 30),),
                Text(entityAddress, style: TextStyle(color: kPrimaryColor, fontSize: 15),),
                SizedBox(height: 20,),
              ]),
          ),

          // Container(
          //   margin: const EdgeInsets.all(20),
          //   child: TextField(
          //     controller: controller,
              
          //     decoration: const InputDecoration(
          //         border: OutlineInputBorder(), labelText: 'Enter your URL'),
          //   ),
          // ),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kSecondaryColor,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return QRImage(url);
                  }),
                ),
              );
            },
            child: const Text('Generate QR Code')),
              
    
    
          
        ],
      );
  }

}