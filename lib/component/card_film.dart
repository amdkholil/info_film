import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardFilm extends StatelessWidget {
  const CardFilm({
    Key key,
    @required this.img,
    @required this.title,
    @required this.year,
    @required this.type,
    @required this.click,
  }) : super(key: key);

  final String img;
  final String title;
  final String year;
  final String type;
  final Function click;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final String judul =
        title.length <= 40 ? title : title.substring(1, 40) + '...';
    return Container(
      margin: EdgeInsets.all(3),
      width: size.width * 0.4,
      child: Column(
        children: [
          GestureDetector(
              onTap: click,
              child: Container(
                color: Colors.grey,
                width: double.infinity,
                height: size.height * 0.4,
                child: CachedNetworkImage(
                  imageUrl: img,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported,
                    size: 60,
                  ),
                ),
              )),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10), blurRadius: 30, color: Colors.black45)
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(type,
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 11)),
                    Text(year,
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 11)),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  judul,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
