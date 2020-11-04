import 'package:flutter/cupertino.dart';

class CafeDetailInfoProvider{
  List<String> openingHours = List();
  List<int> info = List();
  List<int> payment = List();
  List<int> unique = List();

  CafeDetailInfoProvider(){
//    openingHours.add('월 휴무');
//    openingHours.add('화~금 10:00~20:00');
//    openingHours.add('토~일 10:00~22:00');

    for (int i = 0; i < 5; i++)
      info.add(i);

    for (int i = 0; i < 3; i++)
      payment.add(i);

    for (int i = 0; i < 3; i++)
      unique.add(i);
  }
}