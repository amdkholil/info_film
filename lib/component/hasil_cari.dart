import 'package:flutter/material.dart';
import 'package:omdb/model/Movies.dart';
import './card_film.dart';

class HasilCari extends StatelessWidget {
  const HasilCari({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Movies movies = Movies();
    return FutureBuilder(
      future: movies.getMovies(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(snapshot.data);
          Map movie = Map();
          return Container(
            child: GridView.count(
                padding: EdgeInsets.all(4),
                crossAxisCount: 2,
                childAspectRatio: 3 / 5.2,
                children: List.generate(5, (i) {
                  return CardFilm(
                    img: movie[i]['Poster'],
                    title: movie[i]['Title'],
                    year: movie[i]['Year'],
                    type: movie[i]['Type'],
                    click: () {},
                  );
                })),
          );
        }
      },
    );
  }
}
