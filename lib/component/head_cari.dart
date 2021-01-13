import 'package:flutter/material.dart';
import 'package:omdb/model/Movies.dart';

class CariComponent extends StatelessWidget {
  const CariComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Movies movie = Movies();
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: size.height * 0.2,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: Colors.black45)
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      // controller: cari,
                      onSubmitted: (val) {
                        movie.setJudul(val);
                      },
                      decoration: InputDecoration(
                          hintText: "Cari Judul Film",
                          hintStyle: TextStyle(
                            color: Colors.green[300],
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                  // Image.asset(
                  //   "assets/icons/loupe.svg",
                  //   width: 20,
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
