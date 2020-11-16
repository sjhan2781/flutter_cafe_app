import 'package:flutter/material.dart';

class MyTabWidget extends StatefulWidget {
  final String tag;
  Function onTap;
  bool selected = false;

  MyTabWidget(this.tag, this.onTap, this.selected);

  @override
  _MyTabWidgetState createState() => _MyTabWidgetState();
}

class _MyTabWidgetState extends State<MyTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.selected ? Colors.black : Colors.transparent,
      borderRadius: BorderRadius.circular(19),
      child: Container(
        height: 30,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.selected ? 30 : 0),
            child: Center(
                child: Text(
              widget.tag,
              style: TextStyle(
                  color: widget.selected ? Colors.white : Colors.black,
                  fontSize: 16),
            )),
          ),
        ),
      ),
    );
  }
}
