import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/add_offer_page.dart';
import 'package:sia_app/views/add_outlet_page.dart';
import 'package:sia_app/views/customer_engagement.dart';
import 'package:sia_app/views/home_page.dart';
import 'package:sia_app/views/login_page.dart' as login;
import 'package:sia_app/views/marketing_page.dart';
import 'package:sia_app/views/offers_page.dart';
import 'package:sia_app/views/qr_generate_page.dart';
import 'package:sia_app/views/settings_page.dart';

class LayoutArguments {
  final int index;
  LayoutArguments(this.index,);
}


class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  
  int _selectedIndex = 0;
  int _pageIndex = 0;
  int mainPanelIndex = 0;
  String currentUser = '';
  bool bottomNavigationUsed = false;

  void _onItemTapped(int index) {
    setState(() {
      if (_selectedIndex != index) {
        bottomNavigationUsed = true;
      } else {
        bottomNavigationUsed = false;
      }
      _selectedIndex = index;
      print(_selectedIndex);
      mainPanelIndex = _selectedIndex;
    });
  }

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    OfferPage(),
    CustomerEngagementPage(),
    SettingsPage(),
    QRGeneratePage(),
    OfferPage(),
    AddOfferPage(),
    AddOutletPage(),
    MarketingPage()

  ];

  @override
  Widget build(BuildContext context){
    final args = ModalRoute.of(context)!.settings.arguments as LayoutArguments?;
    //print('Arguments: ' + args!.index.toString());
    if (args != null) _pageIndex = args.index;
    
    if (bottomNavigationUsed) {
      mainPanelIndex = _selectedIndex;
      
    } else {
      mainPanelIndex = _pageIndex;
      if (_pageIndex >= 0 && _pageIndex <=4) {
        _selectedIndex = _pageIndex;
      } else {
        _selectedIndex = 0;
      }
    }

    print('Page Index: ' + _pageIndex.toString());
    print('Selected Index: ' + _selectedIndex.toString());
    //mainPanelIndex = _pageIndex;
    print('Main Panel Index: ' + mainPanelIndex.toString());


    
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        // add a icon to right
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, 'login_page');
              
            },
          )
        ],
        
      ),
      body: Center(
        child: _pages.elementAt(mainPanelIndex),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: CustomNavigationBar(
          backgroundColor: kPrimaryColor,
          selectedColor: kSecondaryColor,
          isFloating: true,
          
          borderRadius: Radius.circular(20),
          unSelectedColor: Colors.grey,
          items: [
            CustomNavigationBarItem(
              icon: Icon(Icons.home),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.qr_code_2_outlined),
            ),
            
            
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
      )
    );
  }
}

