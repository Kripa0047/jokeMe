part of 'check_favorite_bloc.dart';

abstract class CheckFavoriteEvent extends Equatable {
  const CheckFavoriteEvent();

  @override
  List<Object> get props => [];
}

class CheckEvent extends CheckFavoriteEvent {
  final int id;

  const CheckEvent(this.id);

  @override
  List<Object> get props => [id];
}
