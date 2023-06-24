import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sia_app/constants.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.controller, {super.key});

  final String controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          centerTitle: true,
        ),
        body: Center(
          child: QrImageView(
            data: controller,
            size: 280,
            // You can include embeddedImageStyle Property if you 
            //wanna embed an image from your Asset folder
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: const Size(
                100,
                100,
              ),
            ),
          ),
        ),
     );
   }
}