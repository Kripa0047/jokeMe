part of 'add_favorite_bloc.dart';

abstract class AddFavoriteState extends Equatable {
  const AddFavoriteState();

  @override
  List<Object> get props => [];
}

class AddFavoriteInitial extends AddFavoriteState {}

class AddFavoriteLoadingState extends AddFavoriteState {}

class AddFavoriteLoadedState extends AddFavoriteState {}

class AddFavoriteFailureState extends AddFavoriteState {
  final Failure failure;

  const AddFavoriteFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
