part of 'check_favorite_bloc.dart';

abstract class CheckFavoriteState extends Equatable {
  const CheckFavoriteState();

  @override
  List<Object> get props => [];
}

class CheckFavoriteInitial extends CheckFavoriteState {}

class CheckFavoriteLoadingState extends CheckFavoriteState {}

class CheckFavoriteLoadedState extends CheckFavoriteState {
  final bool isFavorite;

  const CheckFavoriteLoadedState(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class CheckFavoriteFailureState extends CheckFavoriteState {
  final Failure failure;

  const CheckFavoriteFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
