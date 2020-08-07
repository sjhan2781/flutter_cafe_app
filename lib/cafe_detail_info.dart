import 'dart:developer';

import 'package:cafe_watcha/cafe_detail_info_provider.dart';
import 'package:cafe_watcha/cafe_info.dart';
import 'package:cafe_watcha/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

enum TYPE {
  INFO,
  PAYMENT,
  UNIQUE
}

class CafeDetailInfoPage extends StatelessWidget {

  final provider = CafeDetailInfoProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: MyColor.fabIconColor),
            centerTitle: true,
            title: Text(
              '상세정보',
              style: TextStyle(color: MyColor.fabIconColor),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 29),
                    width: double.maxFinite,
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '영업시간',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              fontSize: 12, color: MyColor.fabIconColor),
                        ),
                        Column(
                          children: _openingHour(provider.openingHours),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
               _buildGridLayoutCard(TYPE.INFO, provider.info),
                SizedBox(
                  height: 5,
                ),
                _buildGridLayoutCard(TYPE.PAYMENT, provider.payment),
                SizedBox(
                  height: 5,
                ),
                _buildGridLayoutCard(TYPE.UNIQUE, provider.unique),

              ],
            ),
          )
    );
  }

  _openingHour(List<String> openingHours) {
    return List.generate(openingHours.length, (index) {
      return Column(
        children: <Widget>[
          SizedBox(height: 7),
          Text(
            openingHours[index],
            style: TextStyle(fontSize: 12, color: MyColor.textColor),
          ),
        ],
      );
    });
  }

  Widget _gridItem(TYPE type, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: MyColor.fabIconColor)),
          child: SvgPicture.asset('images/${CafeInfo.icons[type.index][index]}.svg', fit: BoxFit.scaleDown, color: MyColor.fabIconColor, width: 1, height: 1),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          CafeInfo.text[type.index][index],
          style: TextStyle(fontSize: 12, color: MyColor.textColor),
        ),
      ],
    );
  }

  _buildGridLayoutCard(TYPE type, List<int> items){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 19),
        shrinkWrap: true,
        mainAxisSpacing: 5,
        crossAxisCount: 3,
        childAspectRatio: 3 / 2,
        children:
        List.generate(items.length, (index) => _gridItem(type, items[index])),
      ),
    );
  }
}
