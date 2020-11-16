import 'package:cafe_watcha/ui/mycolors.dart';
import 'package:flutter/material.dart';

class MaskedImage extends StatelessWidget {
  String _imgUri;

  MaskedImage(this._imgUri);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ShaderMask(
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
                  image: NetworkImage(_imgUri), fit: BoxFit.fill)),
        ),
      )
    ]);
  }
}
