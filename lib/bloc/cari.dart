import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

enum CariEvent { cariFilm }

class Cari extends Bloc<CariEvent, String> {
  Cari() : super("");
  Map d = Map();
  String a;
  Stream<String> mapEventToState(CariEvent event) async* {
    a = (event == CariEvent.cariFilm ? "x" : "y");
    yield a;
  }
}

class GetFilm {
  submit(String judul) async {
    final url = "https://omdbapi.com/?apikey=5161fd7e&s=";
    var resp = await http.get(url + judul);
    final Map parsed = json.decode(resp.body);
    return parsed['Search'];
  }
}
