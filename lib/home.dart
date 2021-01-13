import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:omdb/detail_film.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:omdb/component/card_film.dart';
import 'package:omdb/component/nav_btn.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Movies movie = Movies();
  List movie;
  int page = 1;
  TextEditingController cari = TextEditingController();
  bool response;
  bool isloading = true;
  int totalPages = 1;
  String sJudul;

  getJudul() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    String j =
        spref.getString('judul') != null ? spref.getString('judul') : 'cinta';
    return j;
  }

  getMovies(String judul, int p) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    spref.setString('judul', judul);
    cari.text = judul;
    setState(() {
      isloading = true;
    });
    const url = "https://omdbapi.com/?apikey=5161fd7e&s=";
    var resp = await http.get(url + judul + '&page=' + p.toString());
    if (resp.statusCode == 200) {
      var res = jsonDecode(resp.body);
      setState(() {
        isloading = false;
        if (res['Response'] == 'True') {
          response = true;
          totalPages = (int.parse(res['totalResults']) / 10).ceil();
          movie = res['Search'];
        } else {
          response = false;
        }
      });
    }
  }

  void initState() {
    super.initState();
    getJudul().then((v) => getMovies(v, page));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.ac_unit_sharp),
          onPressed: () {},
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      // height: size.height * 0.1,
                      height: 42,
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
                                controller: cari,
                                onSubmitted: (val) {
                                  setState(() {
                                    movie = null;
                                    page = 1;
                                    getMovies(val, page);
                                  });
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
                            Image.asset(
                              "assets/img/loupe.png",
                              width: 20,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              isloading
                  ? Container(
                      margin: EdgeInsets.only(top: 40),
                      child: CircularProgressIndicator())
                  : !response
                      ? Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Text(
                            "Pencarian tidak ditemukan..",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[800]),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            child: GridView.count(
                                padding: EdgeInsets.only(
                                    top: 4, left: 4, right: 4, bottom: 23),
                                crossAxisCount: 2,
                                childAspectRatio:
                                    size.width / (size.height * 1.06),
                                children: List.generate(movie.length, (i) {
                                  return CardFilm(
                                    img: movie[i]['Poster'],
                                    title: movie[i]['Title'],
                                    year: movie[i]['Year'],
                                    type: movie[i]['Type'],
                                    click: () {
                                      Get.to(
                                          DetailFilm(id: movie[i]['imdbID']));
                                    },
                                  );
                                })),
                          ),
                        ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  page == 1
                      ? Text('')
                      : NavBtn(
                          icon: Icons.arrow_back_ios,
                          fun: () {
                            movie = null;
                            page = page - 1;
                            getMovies(cari.text, page);
                          }),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Page $page / $totalPages",
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 3.0,
                            color: Colors.green,
                          ),
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 8.0,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                  page == totalPages
                      ? Text('')
                      : NavBtn(
                          icon: Icons.arrow_forward_ios,
                          fun: () {
                            setState(() {
                              movie = null;
                              page = page + 1;
                              getMovies(cari.text, page);
                            });
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
