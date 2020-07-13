import 'package:flutter/material.dart';
import 'package:cafe_watcha/mycolors.dart';
import 'package:cafe_watcha/homepage.dart';
import 'package:cafe_watcha/explorepage.dart';
import 'package:cafe_watcha/searchpage.dart';
import 'package:cafe_watcha/newspage.dart';
import 'package:cafe_watcha/profliepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
        primaryIconTheme: IconThemeData(color: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: 16,
              letterSpacing: 0.15,
              height: 41,
              color: Colors.black),
        ),
      ),
      home: MyHomePage(title: '신사/압구정'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;
  final List<Widget> pages = [HomePage(), ExplorePage(), SearchPage(), NewsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Row(
          children: <Widget>[
            Text(widget.title),
            CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {},
              ),
              backgroundColor: Colors.grey,
              radius: 20,
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: pages[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: _tabIndex,
        selectedItemColor: MyColor.bottomNavigationSelected,
        unselectedItemColor: MyColor.bottomNavigationUnSelected,
        items: [
          BottomNavigationBarItem(title: Text('홈'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('탐험'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('검색'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('소식'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('프로필'), icon: Icon(Icons.home)),
        ],
      ),
    );
  }
}
