import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Movies {
  String title;
  String year;
  String imdbID;
  String type;
  String poster;

  Movies({this.title, this.year, this.imdbID, this.type, this.poster});

  Movies.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    imdbID = json['imdbID'];
    type = json['Type'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Year'] = this.year;
    data['imdbID'] = this.imdbID;
    data['Type'] = this.type;
    data['Poster'] = this.poster;
    return data;
  }

  getMovies() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    final url = "https://omdbapi.com/?apikey=5161fd7e&s=";
    String judul = spref.getString('judul') ?? "marvel";
    var resp = await http.get(url + judul);
    final Map parsed = json.decode(resp.body);
    final res = parsed['Search'].map((e) => Movies.fromJson(e)).toList();
    await spref.setString('movies', jsonEncode(res));
    return res;
  }

  setJudul(String judul) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    spref.setString('judul', judul);
  }
}
