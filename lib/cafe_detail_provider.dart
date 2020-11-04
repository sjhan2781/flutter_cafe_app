import 'package:async/async.dart';
import 'package:cafe_watcha/CafeTag.dart';
import 'package:flutter/material.dart';
import 'package:cafe_watcha/cafe.dart';

import 'menu.dart';

class CafeDetailProvider with ChangeNotifier {

  CafeDetailProvider();


  Future<Cafe> loadCafeData(Cafe cafe) async {
//    cafe.openingHours = '12:00 ~ 23:00';
//    cafe.price = '아메리카노 4,400원';
//    cafe.address = '서울 종로구 북촌로5길 76 (소격동)';
//    cafe.comment = '삼청동 초입에 있는 카페. 드립커피만을 판매하며, 벽돌 건물의 따듯한 분위기로 둘러싸인 카페이다.'
//        ' 블루보틀의 매력은 드립커피를 주문하면 맞이하는 꽤 긴 시간의 기다림이다. '
//        '얼핏 지루할 수도 있는 기다림은 느림과 여유가 되어, 오는 손님들의 마음을 가라앉힌다.'
//        ' 오늘, 성수동에 왔다면 흘러나오는 재즈와 커피향을 맡으며 시간을 보내는건 어떨까?';

//    cafe.comment = '';

    cafe.beverageList.add(Menu('Americano', 5000, 4500));
    cafe.beverageList.add(Menu('Latte', 5500, 5000));
    cafe.beverageList.add(Menu('Cafuchino', 5500, 5000));
    cafe.beverageList.add(Menu('Latte', 5500, 5000));
    cafe.beverageList.add(Menu('Cafuchino', 5500, 5000));

    cafe.dessertList.add(Menu('Honey bread', 5000, 0));
    cafe.dessertList.add(Menu('Scon', 5500, 0));
    cafe.dessertList.add(Menu('Pancakes', 5500, 0));


    return Future.delayed(Duration(seconds: 1), () => cafe);
  }
}
