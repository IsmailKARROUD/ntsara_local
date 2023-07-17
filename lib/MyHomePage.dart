import 'package:flutter/material.dart';
import 'package:ntsara_local/Screens/ManageGroupChatScreen.dart';
import 'package:ntsara_local/Screens/ManagePrivateChatScreen.dart';
import 'package:ntsara_local/assets/Mycolors.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool hasInternet = true;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    ManagePrivateChatScreen(),
    ManageGroupChatScreen(),
  ];
  @override
  void initState() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'nTsara',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: myWhite,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!hasInternet)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  "No internet Connection!",
                  style: TextStyle(color: Theme.of(context).highlightColor),
                ),
              ),
            Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Private',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: myKingGreen,
        unselectedItemColor: myKingGreen[300],
        onTap: _onItemTapped,
      ),
    );
  }
}
