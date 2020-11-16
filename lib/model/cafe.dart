import 'menu.dart';

class Cafe{
  final int cafeId;
  final String imgUri;
  final String name;
  final String todayOpening;
  final List<String> openingHours;
  List<String> tags = new List();
   String address = '';
   String price = '';
   String comment = '';
   List<Menu> beverageList = List();
   List<Menu> dessertList = List();

  Cafe({this.cafeId, this.name, this.imgUri, this.todayOpening, this.openingHours});


  @override
  String toString() {
    return 'Cafe{cafeId: $cafeId, imgUri: $imgUri, name: $name, todayOpening: $todayOpening, openingHours: $openingHours, tags: $tags, address: $address, price: $price, comment: $comment, beverageList: $beverageList, dessertList: $dessertList}';
  }

//  factory Cafe.fromJson(Map<String, dynamic> json){
////    json['opening_hour'];
//    var list = json['opening_hour'];
////    print(json['opening_hour']);
//    return Cafe(
//        cafeId : json['cafe_id'],
//        name : json['name'],
//        imgUri : json['image_url'],
//        todayOpening : json['today_opening'],
//        openingHours : json['opening_hour']?.cast<String>(),
//        comment : json['comment'];
//
//
//    );
//  }
  Cafe.fromJson(Map<String, dynamic> json)
      : cafeId = json['cafe_id'],
        name = json['name'],
        imgUri = getNullableString(json['image_url']),
        todayOpening = json['today_opening'],
        openingHours = json['opening_hour']?.cast<String>(){
    comment = getNullableString(json['comment']);
    address = getNullableString(json['address']);
    price = getNullableString(json['price']);
    String tagStr = json['tags'];
    tags = tagStr == null ? List<String>() : tagStr.split(',');
  }

  static String getNullableString(str){
     return str == null ? '' : str;
  }
}