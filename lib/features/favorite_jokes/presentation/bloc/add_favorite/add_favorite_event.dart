part of 'add_favorite_bloc.dart';

abstract class AddFavoriteEvent extends Equatable {
  const AddFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteJokeEvent extends AddFavoriteEvent {
  final JokeEntity joke;

  const AddFavoriteJokeEvent(this.joke);

  @override
  List<Object> get props => [joke];
}
