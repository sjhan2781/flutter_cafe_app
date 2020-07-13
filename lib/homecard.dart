import 'package:flutter/material.dart';
import 'package:cafe_watcha/mycolors.dart';

class CafeCard extends StatelessWidget {
  String _imgUri;
  String _name;
  double _rating;

  CafeCard(this._imgUri, this._name, this._rating);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 166,
        height: 182,
//        decoration: BoxDecoration(
//            image: DecorationImage(
//              image: NetworkImage('https://picsum.photos/200/300'),
//              fit: BoxFit.fill,
//              colorFilter: ColorFilter.mode(
//                  Colors.black.withOpacity(0.2), BlendMode.dstIn),
//            )),

        child: Stack(
          children: <Widget>[
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: MyColor.maskGradient
                ).createShader(rect);
              },
              blendMode: BlendMode.darken,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://picsum.photos/200/300'),
                    fit: BoxFit.fill
                  )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
