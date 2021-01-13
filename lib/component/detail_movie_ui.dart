import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailFilmUi extends StatelessWidget {
  const DetailFilmUi({
    Key key,
    @required this.dataMovie,
  }) : super(key: key);

  final Map dataMovie;

  @override
  Widget build(BuildContext context) {
    String image = dataMovie['Poster'];
    String judul = dataMovie['Title'];
    String tahun = dataMovie['Year'];
    String rating = dataMovie['Rated'];
    String duration = dataMovie['Runtime'];
    // String release = dataMovie['Released'];
    String metascore = dataMovie['Metascore'];
    String imdbRating = dataMovie['imdbRating'];
    String imdbVotes = dataMovie['imdbVotes'];
    String type = dataMovie['Type'];
    String country = dataMovie['Country'];
    List listGenre = dataMovie['Genre'].split(', ');
    List actors = dataMovie['Actors'].split(', ');
    List directors = dataMovie['Director'].split(', ');
    List writers = dataMovie['Writer'].split(', ');
    List production = dataMovie['Production'].split(', ');
    List lang = dataMovie['Language'].split(', ');
    List awards = dataMovie['Awards'].split(', ');
    String boxOffice = dataMovie['BoxOffice'];

    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.37,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover),
                  color: Colors.grey[400],
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(60)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 6),
                        blurRadius: 20,
                        color: Colors.black45)
                  ]),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.32),
                height: 70,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(35)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 20,
                          color: Colors.black45)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellowAccent[700],
                          ),
                          Text(imdbRating + "/10")
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(7)),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  imdbVotes,
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Text("Votes")
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(7)),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  metascore,
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Text("Meta Score")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: EdgeInsets.only(top: 31, left: 17),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.4),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              padding: EdgeInsets.all(4),
              child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back_ios, color: Colors.black)),
            ),
          ],
        ),
        // Judul
        //===================
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(top: 25, left: 15, right: 15),
            child: Text(
              judul,
              style: TextStyle(fontSize: 30, color: Colors.black54),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(
              left: 15,
              top: 10,
            ),
            child: Row(
              children: [
                SmallSubtitle(txt: tahun),
                SmallSubtitle(txt: rating),
                SmallSubtitle(txt: duration),
                SmallSubtitle(txt: type),
                // SmallSubtitle(txt: release),
                SmallSubtitle(txt: country),
              ],
            ),
          ),
        ),
        Sparate(),
        CustomListHori(listData: listGenre),
        Sparate(),
        HeaderCus1(txt: "Synopsis"),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            dataMovie['Plot'],
            textAlign: TextAlign.justify,
            style: TextStyle(height: 1.5, fontSize: 15),
          ),
        ),
        Sparate(),
        HeaderCus1(txt: 'Actors'),
        CustomListHori(listData: actors),
        Sparate(),
        HeaderCus1(txt: 'Directors'),
        CustomListHori(listData: directors),
        Sparate(),
        HeaderCus1(txt: 'Writers'),
        CustomListVert(listData: writers),
        Sparate(),
        HeaderCus1(txt: 'Production'),
        CustomListVert(listData: production),
        Sparate(),
        HeaderCus1(txt: 'Language'),
        CustomListHori(listData: lang),
        Sparate(),
        HeaderCus1(txt: 'Awards'),
        CustomListVert(listData: awards),
        Sparate(),
        HeaderCus1(txt: 'BoxOffice'),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(
                Icons.money,
                color: Colors.green[800],
              ),
              Text(
                " " + boxOffice,
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Sparate extends StatelessWidget {
  const Sparate({Key key, this.h}) : super(key: key);
  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h == null ? 15 : h,
    );
  }
}

class CustomListVert extends StatelessWidget {
  const CustomListVert({
    Key key,
    @required this.listData,
  }) : super(key: key);

  final List listData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: listData.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '• ' + listData[i],
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              ));
        });
  }
}

class CustomListHori extends StatelessWidget {
  const CustomListHori({
    Key key,
    @required this.listData,
  }) : super(key: key);

  final List listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listData.length,
        itemBuilder: (context, i) {
          return Wrap(children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(listData[i]),
            ),
          ]);
        },
      ),
    );
  }
}

class SmallSubtitle extends StatelessWidget {
  const SmallSubtitle({
    Key key,
    @required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Text(txt, style: TextStyle(color: Colors.black38)),
    );
  }
}

class HeaderCus1 extends StatelessWidget {
  const HeaderCus1({Key key, @required this.txt}) : super(key: key);
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      padding: EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        this.txt,
        style: TextStyle(
            color: Colors.grey[700], fontSize: 22, fontWeight: FontWeight.w100),
      ),
    );
  }
}
