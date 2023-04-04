part of 'get_favorites_bloc.dart';

abstract class GetFavoritesState extends Equatable {
  const GetFavoritesState();

  @override
  List<Object> get props => [];
}

class GetFavoritesInitial extends GetFavoritesState {}

class GetFavoritesLoadingState extends GetFavoritesState {}

class GetFavoritesLoadedState extends GetFavoritesState {
  final List<JokeEntity> jokes;

  const GetFavoritesLoadedState(this.jokes);

  @override
  List<Object> get props => [jokes];
}

class GetFavoritesFailureState extends GetFavoritesState {
  final Failure failure;

  const GetFavoritesFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
