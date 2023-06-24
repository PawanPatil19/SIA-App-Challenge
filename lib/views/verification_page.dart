import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        // add a icon to right
        
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitPouringHourGlassRefined(
              color: kSecondaryColor,
              size: 70.0,
            ),

            const SizedBox(height: 30),
          

            const Text(
              'Under Review',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: kSecondaryColor
              ),
            ),
            const SizedBox(height: 30),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Your account is under review. Please wait for 1-2 days for the verification process.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,

                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login_page');
              },
              style: ElevatedButton.styleFrom(
                primary: kButtonColor,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      )
    );
  }

}

  