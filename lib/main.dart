import 'package:cafe_watcha/provider/cafe_detail_provider.dart';
import 'package:cafe_watcha/main_page.dart';
import 'package:cafe_watcha/provider/main_provider.dart';
import 'package:flutter/material.dart';
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
        ChangeNotifierProvider<CafeDetailProvider>(create: (BuildContext context) => CafeDetailProvider(),),
        ChangeNotifierProvider<MainProvider>(create: (BuildContext context) => MainProvider(),)
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
        home: MainPage(),
      ),
    );
  }
}


