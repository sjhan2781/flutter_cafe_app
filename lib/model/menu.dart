class Menu{
  String name;
  int price1; //음료일 경우 ice
  int price2; //음료일 경우 hot


  Menu(this.name, this.price1, this.price2);

  String get price1Str{
    if(price1 == 0)
      return '';
    else
      return price1.toString();
  }

  String get price2Str{
    if(price2 == 0)
      return '';
    else
      return price2.toString();
  }
}