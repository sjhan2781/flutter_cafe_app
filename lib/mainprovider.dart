import 'dart:collection';
import 'dart:convert';

import 'package:cafe_watcha/cafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MainProvider with ChangeNotifier {
  HashMap<String, List<Cafe>> _cafeMap;
  List<String> _regionList;
  int _selectedRegIdx = 0;
  List<Cafe> _cafeList;
  List<Cafe> _filteredCafeList;

  List<String> _tags;
  int _selectedTagIdx = 0;

  String get region => _regionList[_selectedRegIdx];
  String get tag => _tags[_selectedTagIdx];

  int get tagLength => _tags.length;

  String getTagFromIndex(int index) => _tags[index];

  MainProvider() {
    _cafeMap = new HashMap();
    _selectedRegIdx = 0;
    _regionList = ['성수', '합정/망원', '이태원/한남', '가로수길'];
    _tags = [
      '전체',
      '거리두기',
      '데이트',
      '스터디/노트북',
      '맛있는 커피',
      '맛있는 디저트',
      '브런치',
      '미팅룸',
    ];
    _cafeMap = HashMap.fromIterable(_regionList,
        key: (k) => k.toString(), value: (v) => List<Cafe>());
    _cafeList = new List();
    _filteredCafeList = new List();
  }

  Future<void> loadCafeList() async {
    if (_cafeMap[region].isEmpty) {
      final url =
          'https://q20cuaup4j.execute-api.ap-northeast-2.amazonaws.com/test1/mytest';
      var response = await http.post(url,
          body: jsonEncode({'region_id': _selectedRegIdx + 1}),
          headers: {'Content-Type': "application/json"});

      var encodedBody = utf8.decode(response.bodyBytes);

      List rows = jsonDecode(encodedBody);

      List<Cafe> _cafeList = new List();
      for (var row in rows) {
        Cafe cafe = Cafe.fromJson(row);
        _cafeList.add(cafe);
      }

      _cafeMap[region].addAll(_cafeList);

      print("call API");

    }
    else{
      print("cafe list exist");
    }

    _cafeList = _cafeMap[region];

    print("Finish get cafe list");
  }

  Future<List<Cafe>> getFilteredCafeList() async {
    String filter = tag;
    print(filter);

    await loadCafeList();
    _filteredCafeList.clear();

    if (filter == '전체') {
      _filteredCafeList.addAll(_cafeList);
    } else {
      for (Cafe cafe in _cafeList) {
        for (String tag in cafe.tags) {
          if (tag.contains(filter)) {
            _filteredCafeList.add(cafe);
            break;
          }
        }
      }
    }
    print("Finish filtering");

    return Future.value(_filteredCafeList);
  }

  void changeRegion(int index) {
    _selectedRegIdx = index;
    notifyListeners();
  }

  void setSelectedTagIdx(int index) {
    _selectedTagIdx = index;
    notifyListeners();
  }

  bool isTagSelected(int index) {
    return index == _selectedTagIdx;
  }
}
