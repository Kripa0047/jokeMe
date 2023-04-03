part of 'get_ten_random_jokes_bloc.dart';

abstract class GetTenRandomJokesState extends Equatable {
  const GetTenRandomJokesState();

  @override
  List<Object> get props => [];
}

class GetTenRandomJokesInitial extends GetTenRandomJokesState {}

class GetTenRandomJokesLoadingState extends GetTenRandomJokesState {}

class GetTenRandomJokesFailedState extends GetTenRandomJokesState {
  final Failure failure;

  const GetTenRandomJokesFailedState(this.failure);

  @override
  List<Object> get props => [failure];
}

class GetTenRandomJokesLoadedState extends GetTenRandomJokesState {
  final List<JokeEntity> jokes;

  const GetTenRandomJokesLoadedState(this.jokes);

  @override
  List<Object> get props => [jokes];
}
