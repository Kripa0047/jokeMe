part of 'delete_favorite_bloc.dart';

abstract class DeleteFavoriteState extends Equatable {
  const DeleteFavoriteState();

  @override
  List<Object> get props => [];
}

class DeleteFavoriteInitial extends DeleteFavoriteState {}

class DeleteFavoriteLoadingState extends DeleteFavoriteState {}

class DeleteFavoriteLoadedState extends DeleteFavoriteState {}

class DeleteFavoriteFailureState extends DeleteFavoriteState {
  final Failure failure;

  const DeleteFavoriteFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
