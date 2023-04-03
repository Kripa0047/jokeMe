part of 'get_ten_random_jokes_bloc.dart';

abstract class GetTenRandomJokesEvent extends Equatable {
  const GetTenRandomJokesEvent();

  @override
  List<Object> get props => [];
}

class GetJokesEvent extends GetTenRandomJokesEvent {}
