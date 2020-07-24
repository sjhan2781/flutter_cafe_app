import 'dart:developer';

import 'package:cafe_watcha/cafe.dart';
import 'package:cafe_watcha/cafe_detail_provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:cafe_watcha/maskedimage.dart';
import 'package:cafe_watcha/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

class CafePage extends StatefulWidget {
  final Cafe _cafe;

  CafePage(this._cafe);

  @override
  _CafePageState createState() => _CafePageState();
}

class _CafePageState extends State<CafePage> {
  ScrollController _scrollController;
  Future<Cafe> _cafe;
  CafeDetailProvider provider;

  double get _horizontalTitlePadding {
    const kBasePadding = 20.0;
    const kMultiplier = 0.5;
    const kExpandedHeight = 230;

    if (_scrollController.hasClients) {
      if (_scrollController.offset < (kExpandedHeight / 2)) {
        // In case 50%-100% of the expanded height is viewed
        return kBasePadding;
      } else if (_scrollController.offset >
          (kExpandedHeight - kToolbarHeight)) {
        // In case 0% of the expanded height is viewed
        return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
            kBasePadding;
      }
      // In case 0%-50% of the expanded height is viewed
      return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
          kBasePadding;
    }

    return kBasePadding;
  }

  double get _verticalTitlePadding {
    const kBasePadding = 14.0;
    const bottomPadding = 0.0;
    if (_scrollController.hasClients) {
      if (_scrollController.offset < bottomPadding - kBasePadding) {
        return bottomPadding - _scrollController.offset;
      }

      return kBasePadding;
    }

    return kBasePadding;
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<CafeDetailProvider>(context);
    _cafe = provider.loadCafeData(widget._cafe);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: FutureBuilder<Cafe>(
            future: _cafe,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Cafe cafe = snapshot.data;
              return Stack(
                children: <Widget>[
                  NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (context, isScrolled) {
                      return [
                        SliverAppBar(
                          forceElevated: isScrolled,
                          iconTheme: IconThemeData(color: Colors.white),
                          expandedHeight: 230,
                          pinned: true,
                          centerTitle: false,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(cafe.name,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20)),
                            titlePadding: EdgeInsets.symmetric(
                                vertical: _verticalTitlePadding,
                                horizontal: _horizontalTitlePadding),
                            centerTitle: false,
                            background: Stack(
                              children: <Widget>[
                                MaskedImage('https://picsum.photos/300/200'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.map),
                              onPressed: () {},
                            )
                          ],
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.symmetric(horizontal: 22),
                                child:
                                  Column(
                                    children: <Widget>[
                                      SizedBox(height: 23),
                                      cafeInfo('영업시간', cafe.openingHours),
                                      SizedBox(height: 9),
                                      cafeInfo('가      격', cafe.price),
                                      SizedBox(height: 9),
                                      cafeInfo('주      소', cafe.address),
                                      SizedBox(height: 8),
                                      Row(
                                        children: <Widget>[
                                          UnderLinedButton('메 뉴 판', () {}),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          UnderLinedButton('상세정보', () {}),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 57),
                                        child: ExpandableText(
                                          cafe.comment,
                                          style: TextStyle(
                                            color: MyColor.textColor,
                                            fontSize: 12,
                                            letterSpacing: 0.52,
                                          ),
                                          expandText: '더보기',
                                          collapseText: '접기',
                                          maxLines: 2,
                                          linkColor: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 17),
                                  child: Container(
                                    height: 20,
                                    child: ListView.separated(
                                        padding: EdgeInsets.symmetric(horizontal: 22),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cafe.tags.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            onTap: () {},
                                            splashColor: MyColor.tagButtonColor,
                                            highlightColor:
                                                MyColor.tagButtonColor,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: MyColor
                                                          .tagButtonColor)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Center(
                                                  child: Text(
                                                    cafe.tags[index],
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: MyColor
                                                            .tagButtonColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, builder) =>
                                            SizedBox(
                                              width: 10,
                                            )),
                                  ),
                                )
                              ],
                            ),
                          ]),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              unselectedLabelColor: MyColor.fabIconColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: MyColor.fabIconColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              tabs: <Widget>[
                                Tab(
                                  child: Align(
                                    child: Text('공간'),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    child: Text('음식'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                    body: myTabBarView(),
                  ),
                  _buildFab(),
                ],
              );
            }),
      ),
    );
  }

  Widget myTabBarView() {
    return TabBarView(
      children: <Widget>[
        StaggeredGridView.countBuilder(
          padding: EdgeInsets.only(left: 22, right: 22, top: 14, bottom: 14),
          crossAxisCount: 2,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => new ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/200',
                fit: BoxFit.fill,
              )),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(1, index % 3 + 1),
          mainAxisSpacing: 11.0,
          crossAxisSpacing: 11.0,
        ),
        StaggeredGridView.countBuilder(
          padding: EdgeInsets.only(left: 22, right: 22, top: 14, bottom: 14),
          crossAxisCount: 2,
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) => new Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              child: new Center(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text('$index'),
                ),
              )),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(1, index.isOdd ? 2 : 1),
          mainAxisSpacing: 11.0,
          crossAxisSpacing: 11.0,
        )
      ],
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 208.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin + MediaQuery.of(context).padding.top;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }
    return new Positioned(
      top: top,
      right: 33.0,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: Container(
          width: 47,
          height: 47,
          child: FittedBox(
            child: new FloatingActionButton(
              onPressed: () => {},
              backgroundColor: MyColor.fabBackColor,
              child: new Icon(
                Icons.open_in_new,
                color: MyColor.fabIconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cafeInfo(String title, String content) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: MyColor.fabIconColor, fontSize: 12),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          content,
          style: TextStyle(color: MyColor.textColor, fontSize: 12),
        )
      ],
    );
  }

  Widget ratingRow(double rating, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RatingBar.readOnly(
          initialRating: rating,
          isHalfAllowed: true,
          size: 12,
          filledColor: Colors.amber,
          emptyColor: Colors.white,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
        ),
        Text(
          text + '$rating',
          style: TextStyle(fontSize: 11, color: Colors.white),
        ),
      ],
    );
  }
}

class UnderLinedButton extends StatelessWidget {
  final String _text;
  final Function _onPressed;

  UnderLinedButton(this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 12,
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(
            color: MyColor.fabIconColor,
            fontSize: 12,
            decoration: TextDecoration.underline,
            letterSpacing: 1),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 22.0),
      child: _tabBar,
      color: MyColor.defaultBgColor,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
