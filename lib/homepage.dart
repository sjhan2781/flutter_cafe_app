import 'package:cafe_watcha/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_watcha/cafecard.dart';
import 'package:cafe_watcha/cafetag.dart';
import 'package:cafe_watcha/tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CafeTag> tags = [
    CafeTag('전체'),
    CafeTag('Best 20'),
    CafeTag('데이트'),
    CafeTag('놀거리'),
    CafeTag('커피가 맛있는'),
    CafeTag('무언가'),
  ];

  int selectedIndex = 0;
  HomeProvider cafeProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    cafeProvider = Provider.of<HomeProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    final cafeProvider = Provider.of<HomeProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 14,
        ),
        Container(
          height: 40,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 13.0),
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (BuildContext context, int index) {
              return MyTabWidget(tags[index].tag, () {
                setState(() {
                  selectedIndex = index;
                });
              }, selectedIndex == index);
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 20,
            ),
          ),
        ),
        SizedBox(
          height: 13,
        ),
        Expanded(child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.connectionState == ConnectionState.none || snapshot.data.length == 0) {
              return Center(child: Text('No Data'));
            }
            return GridView.builder(
                padding: EdgeInsets.only(left: 4.5, bottom: 13, right: 4.5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.5,
                  mainAxisSpacing: 4,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CafeCard(snapshot.data[index]);
                });
          },
          future: cafeProvider.loadCafeList(tags[selectedIndex].tag),
        )),
      ],
    );

//    return CafeCard('Home', 'asd', 4.5);
  }
}

