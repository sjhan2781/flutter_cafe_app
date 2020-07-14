import 'package:cafe_watcha/CafeTag.dart';
import 'package:flutter/material.dart';
import 'package:cafe_watcha/cafe.dart';

class HomeProvider with ChangeNotifier {
  List<Cafe> _cafeList = List();
  List<Cafe> _filteredList = List();

  HomeProvider() {
    _cafeList = List();

    _cafeList.add(
        Cafe('https://picsum.photos/200/300', '블루보틀 (압구정점)', 4.8, ['Best 20']));
    _cafeList.add(Cafe(
        'https://picsum.photos/200/300', '테일러커피 2호점', 4.7, ['Best 20', '데이트']));
    _cafeList.add(Cafe('https://picsum.photos/200/300', '카페 노티트', 4.7,
        ['Best 20', '데이트', '놀거리']));
    _cafeList.add(Cafe('https://picsum.photos/200/300', '펠트커피 (도산공원점)', 4.6,
        ['Best 20', '놀거리']));
    _cafeList.add(
        Cafe('https://picsum.photos/200/300', '카페 1', 4.5, ['놀거리', '커피가 맛있는']));
    _cafeList.add(
        Cafe('https://picsum.photos/200/300', '카페 2', 4.5, ['데이트', '커피가 맛있는']));

    _filteredList.addAll(_cafeList);
  }

  getCafeList() => _cafeList;

  setCafeList(List<Cafe> cafeList) => _cafeList = cafeList;

  Future<List<Cafe>> loadCafeList(String filter) async {
    _filteredList.clear();

    if (filter == '전체') {
      _filteredList.addAll(_cafeList);
    } else {
      for (Cafe cafe in _cafeList) {
        for (String tag in cafe.tags) {
          if (tag.contains(filter)) {
            _filteredList.add(cafe);
            break;
          }
        }
      }
    }

    return Future.delayed(Duration(seconds: 1), () => _filteredList);
  }
}
