part of 'delete_favorite_bloc.dart';

abstract class DeleteFavoriteEvent extends Equatable {
  const DeleteFavoriteEvent();

  @override
  List<Object> get props => [];
}

class DeleteEvent extends DeleteFavoriteEvent {
  final JokeEntity joke;

  const DeleteEvent(this.joke);

  @override
  List<Object> get props => [joke];
}
