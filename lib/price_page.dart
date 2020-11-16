import 'package:cafe_watcha/ui/mycolors.dart';
import 'package:flutter/material.dart';

import 'model/menu.dart';

class PricePage extends StatelessWidget {
  List<Menu> _beverageList;
  List<Menu> _dessertList;

  PricePage(this._beverageList, this._dessertList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 584,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2.5),
            child: Container(
              height: 5,
              width: 36,
              color: Color(0xff2d140d),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 19.0),
            child: Column(
              children: <Widget>[

                _menu('', 'BEVERAGE'),
                SizedBox(
                  height: 13.5,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text('Hot',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text('Ice',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                _menuList(_beverageList),
                SizedBox(height: 27),
                _menu('', 'DESSERT'),
                SizedBox(
                  height: 13.5,
                ),
                _menuList(_dessertList),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _menu(String uri, String name){
    return Row(
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xff979797))),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          name,
          style:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _menuList(List<Menu> menuList){
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: menuList.length,
      itemBuilder: (context, index) {
        return _menuPrice(menuList[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  Widget _menuPrice(Menu menu){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17.5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(menu.name,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 1,
            child: Text(menu.price2Str,
                style: TextStyle(
                    fontSize: 16,)),
          ),
          Expanded(
            flex: 1,
            child: Text(menu.price1Str,
                style: TextStyle(
                    fontSize: 16,)),
          ),
        ],
      ),
    );
  }
}
