import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khadamaty/main_screen/service.dart';
import 'package:khadamaty/main_screen/trending_services/service_provider_screen.dart';
import 'package:khadamaty/utilities/theme_const.dart';

class TrendingItem extends StatefulWidget {
  final Service service;
  bool lang;
  IconData icon = Icons.star_border;
  double titleSize = 24;
  double itemTypeSize = 17;
  double addressSize = 12;
  double dateSize = 14;
  Color color = Constants.offWhite;
  final double width;
  final double height;
  final double imageHeight;

  TrendingItem(
      {Key key,
      @required this.service,
      @required this.lang,
      this.icon,
      this.titleSize,
      this.itemTypeSize,
      this.addressSize,
      this.dateSize,
      this.color,
      @required this.width,
      @required this.height,
      @required this.imageHeight})
      : super(key: key);

  @override
  _TrendingItemState createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ServiceProvidersScreen(widget.lang, widget.service))),
      child: Padding(
        padding: EdgeInsets.only(
          top: 5.0,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / widget.height,
          width: MediaQuery.of(context).size.width * widget.width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 4,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      height: MediaQuery.of(context).size.height /
                          (widget.imageHeight),
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: (widget.service.image == null)
                            ? Image.asset(
                                "assets/images/service.png",
                              )
                            : Image(
                                loadingBuilder: (context, image,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) {
                                    return image;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                image: NetworkImage(
                                  widget.service.image,
                                ),
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      right: 6.0,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            widget.icon,
                            color: widget.color,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 7.0),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${widget.service.name}",
                      style: TextStyle(
                        fontSize: widget.titleSize,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 7.0),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${widget.service.slug}",
                      style: TextStyle(
                        fontSize: widget.itemTypeSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 7.0),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "${widget.service.description}",
                      style: TextStyle(
                        fontSize: widget.addressSize,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                (widget.service.createAt == null)
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 6),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "${widget.service.createAt}",
                              style: TextStyle(
                                fontSize: widget.dateSize,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
