import 'package:equatable/equatable.dart';
import 'package:omdb/model/Movies.dart';

abstract class MoviesState extends Equatable {}

class Initial implements MoviesState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class Loading implements MoviesState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class MoviesLoaded implements MoviesState {
  final List<Movies> movies;

  const MoviesLoaded(this.movies);
  @override
  List<Object> get props => [movies];

  @override
  bool get stringify => true;
}

class MoviesMessages implements MoviesState {
  final String messages;

  const MoviesMessages(this.messages);

  @override
  List<Object> get props => [messages];

  @override
  bool get stringify => false;
}
