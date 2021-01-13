import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import './component/detail_movie_ui.dart';

class DetailFilm extends StatelessWidget {
  const DetailFilm({Key key, @required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    getMovie(String id) async {
      const url = "https://omdbapi.com/?apikey=5161fd7e&i=";
      const option = '&plot=full';
      var resp = await http.post(url + id + option);
      return jsonDecode(resp.body);
    }

    return Scaffold(
      body: FutureBuilder(
          future: getMovie(this.id),
          builder: (context, res) {
            if (res.hasError) {
              print(res.error);
            }
            if (res.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (res.connectionState == ConnectionState.done) {
              print(res.data);
              return SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: DetailFilmUi(dataMovie: res.data));
            } else {
              return Center(
                child: Text("Terjadi kesalahan"),
              );
            }
          }),
    );
  }
}
