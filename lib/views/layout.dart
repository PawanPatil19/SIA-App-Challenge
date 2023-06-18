import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sia_app/constants.dart';
import 'package:sia_app/views/add_offer_page.dart';
import 'package:sia_app/views/home_page.dart';
import 'package:sia_app/views/login_page.dart';
import 'package:sia_app/views/offers_page.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      mainPanelIndex = _selectedIndex;
    });
  }

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    LoginPage(),
    LoginPage(),
    LoginPage(),
    LoginPage(),
    OfferPage(),
    AddOfferPage()
  ];

  @override
  Widget build(BuildContext context){
    final args = ModalRoute.of(context)!.settings.arguments as LayoutArguments?;
    //print('Arguments: ' + args!.index.toString());
    if (args != null) _pageIndex = args.index;
    //mainPanelIndex = _pageIndex;
    print('Page Index: ' + _pageIndex.toString());
    print('Selected Index: ' + _selectedIndex.toString());
    mainPanelIndex = _pageIndex;

    
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
            icon: const Icon(Icons.person_sharp),
            onPressed: () {
              // do something
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
              icon: Icon(Icons.analytics_outlined),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.logout_outlined),
            ),
            
            
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
      )
    );
  }
}

