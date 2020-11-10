import 'package:cafe_watcha/cafe_detail_provider.dart';
import 'package:cafe_watcha/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:cafe_watcha/mycolors.dart';
import 'package:cafe_watcha/homepage.dart';
import 'package:cafe_watcha/explorepage.dart';
import 'package:cafe_watcha/searchpage.dart';
import 'package:cafe_watcha/newspage.dart';
import 'package:cafe_watcha/profliepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (BuildContext context)  => HomeProvider()),
        ChangeNotifierProvider<CafeDetailProvider>(create: (BuildContext context) => CafeDetailProvider(), )
      ],
      child: MaterialApp(
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
      ),
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
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(widget.title),
            SizedBox(width: 6,),
            ClipOval(
              child: Material(
                color: MyColor.appbarTitleButtonColor, // button color
                child: InkWell(
                  splashColor: Colors.red, // inkwell color
                  child: SizedBox(width: 17, height: 17, child: Center(child: Icon(Icons.chevron_right, size: 17, color: Color(0xff222222),))),
                  onTap: () {},
                ),
              ),
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
          BottomNavigationBarItem(title: Text('홈'), icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(title: Text('탐험'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('검색'), icon: Icon(Icons.search_outlined)),
          BottomNavigationBarItem(title: Text('소식'), icon: Icon(Icons.chat_outlined)),
          BottomNavigationBarItem(title: Text('프로필'), icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
    );
  }
}
