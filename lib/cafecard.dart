import 'package:flutter/material.dart';
import 'package:cafe_watcha/mycolors.dart';
import 'package:cafe_watcha/cafe.dart';

class CafeCard extends StatelessWidget {
  String _imgUri;
  String _name;
  double _rating;
  Cafe _cafe;
  Function _onTap;

  final double CARD_RADIUS = 8.0;

  CafeCard(this._cafe, this._onTap);

//  CafeCard(this._imgUri, this._name, this._rating);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CARD_RADIUS)),
      child: InkWell(
        splashColor: Colors.redAccent,
        onTap: _onTap,
        child: Container(
          width: 166,
          height: 182,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(CARD_RADIUS),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: MyColor.maskGradient)
                        .createShader(rect);
                  },
                  blendMode: BlendMode.darken,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(_cafe.imgUri),
                            fit: BoxFit.fill)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_cafe.name, style: TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 0.41),),
                    SizedBox(height: 7,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.star_border, color: Colors.white, size: 16,),
                        SizedBox(width: 4,),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 4),
//                          child: Text(_cafe.rating.toString(), style: TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 0.41),),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
