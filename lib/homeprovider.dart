import 'dart:convert';

import 'package:cafe_watcha/CafeTag.dart';
import 'package:flutter/material.dart';
import 'cafe.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  List<Cafe> _cafeList = List();
  List<Cafe> _filteredList = List();

  HomeProvider(){

//    _cafeList.add(
//        Cafe('https://picsum.photos/200/300', '블루보틀 (압구정점)', 4.8, ['Best 20']));
//    _cafeList.add(Cafe(
//        'https://picsum.photos/200/300', '테일러커피 2호점', 4.7, ['Best 20', '데이트', '커피가 맛있는']));
//    _cafeList.add(Cafe('https://picsum.photos/200/300', '카페 노티트', 4.7,
//        ['Best 20', '데이트', '놀거리']));
//    _cafeList.add(Cafe('https://picsum.photos/200/300', '펠트커피 (도산공원점)', 4.6,
//        ['Best 20', '놀거리']));
//    _cafeList.add(
//        Cafe('https://picsum.photos/200/300', '카페 1', 4.5, ['놀거리', '커피가 맛있는']));
//    _cafeList.add(
//        Cafe('https://picsum.photos/200/300', '카페 2', 4.5, ['데이트', '커피가 맛있는']));

    loadCafeList();

    _filteredList.addAll(_cafeList);
  }

  getCafeList() => _cafeList;

  setCafeList(List<Cafe> cafeList) => _cafeList = cafeList;

  void loadCafeList() async{
    final url = 'https://q20cuaup4j.execute-api.ap-northeast-2.amazonaws.com/test1/mytest';
    var response = await http.post(url,
        body: jsonEncode({'region_id' : 1}),
        headers: {'Content-Type': "application/json"} );

    var encodedBody = utf8.decode(response.bodyBytes);

    List rows = jsonDecode(encodedBody);

    for(var row in rows){
      Cafe cafe = Cafe.fromJson(row);
      _cafeList.add(cafe);
    }

    print('cafeList = ${_cafeList.toString()}');


//    _cafeList.add(value)

  }

  Future<List<Cafe>> filterCafeList(String filter) async {
    _filteredList.clear();

//    if (filter == '전체') {
//      _filteredList.addAll(_cafeList);
//    } else {
//      for (Cafe cafe in _cafeList) {
//        for (String tag in cafe.tags) {
//          if (tag.contains(filter)) {
//            _filteredList.add(cafe);
//            break;
//          }
//        }
//      }
//    }

    return Future.delayed(Duration(seconds: 1), () => _cafeList);
  }
}
