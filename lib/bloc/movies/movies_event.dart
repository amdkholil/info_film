import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {}

class GetAll implements MoviesEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
