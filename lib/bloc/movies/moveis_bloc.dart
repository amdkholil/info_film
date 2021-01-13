import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb/bloc/movies/movies_event.dart';
import 'package:omdb/bloc/movies/movies_state.dart';
import 'package:omdb/model/Movies.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Movies movies;
  MoviesBloc(this.movies) : super(Initial());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is GetAll) {
      yield* _getMovies();
    }
  }

  Stream<MoviesState> _getMovies() async* {
    try {
      yield Loading();
      // List <Movies> _movies = await movies.getMovies(judul)
    } catch (e) {
      print(e);
      MoviesMessages(e);
    }
  }
}
