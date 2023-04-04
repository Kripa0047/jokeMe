part of 'get_favorites_bloc.dart';

abstract class GetFavoritesEvent extends Equatable {
  const GetFavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteJokesEvent extends GetFavoritesEvent {}
