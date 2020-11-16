import 'package:cafe_watcha/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_watcha/ui/mycolors.dart';
import 'package:cafe_watcha/home_page.dart';
import 'package:cafe_watcha/explore_page.dart';
import 'package:cafe_watcha/search_page.dart';
import 'package:cafe_watcha/news_page.dart';
import 'package:cafe_watcha/proflie_page.dart';


class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  List<String> region = ['성수', '합정/망원', '이태원/한남', '가로수길'];

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _tabIndex = 0;
  int selectedRegIdx = 0;

  final List<Widget> pages = [HomePage(), ExplorePage(), SearchPage(), NewsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context);

//    mainProvider.loadCafeList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(mainProvider.region),
                ),
                onTap: () => {_showRegionList(context)}),
            SizedBox(width: 6,),
            ClipOval(
              child: Material(
                color: MyColor.appbarTitleButtonColor, // button color
                child: InkWell(
                  splashColor: Colors.red, // inkwell color
                  child: SizedBox(width: 17, height: 17, child: Center(child: Icon(Icons.chevron_right, size: 17, color: Color(0xff222222),))),
                  onTap: () => {_showRegionList(context)},
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


//      bottomNavigationBar: BottomNavigationBar(
//        onTap: (index) {
//          setState(() {
//            _tabIndex = index;
//          });
//        },
//        type: BottomNavigationBarType.fixed,
//        showUnselectedLabels: true,
//        currentIndex: _tabIndex,
//        selectedItemColor: MyColor.bottomNavigationSelected,
//        unselectedItemColor: MyColor.bottomNavigationUnSelected,
//        items: [
//          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home_outlined)),
//          BottomNavigationBarItem(label: '탐험', icon: Icon(Icons.inbox_outlined)),
//          BottomNavigationBarItem(label: '검색', icon: Icon(Icons.search_outlined)),
//          BottomNavigationBarItem(label: '소식', icon: Icon(Icons.chat_outlined)),
//          BottomNavigationBarItem(label: '프로필', icon: Icon(Icons.account_circle_outlined)),
//        ],
//      ),
    );
  }

  _showRegionList(context){
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal : 8.0),
        child: Container(
          height: 300,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(widget.region.length, (index) => _regionButton(context, index)),),
        ),
      ),
    );
  }

  _regionButton(BuildContext context, int index){
    final provider = Provider.of<MainProvider>(context);

    return Material(
      child: InkWell(
        child: Text(widget.region[index]),
        onTap: (){
          provider.changeRegion(index);
          Navigator.pop(context);
        },
      ),
    );
  }
}