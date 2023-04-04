import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/add_favorite_usecase.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  final AddFavoriteUsecase addFavorite;
  AddFavoriteBloc(
    this.addFavorite,
  ) : super(AddFavoriteInitial()) {
    on<AddFavoriteJokeEvent>(_onAdd);
  }

  FutureOr<void> _onAdd(
    AddFavoriteJokeEvent event,
    Emitter<AddFavoriteState> emit,
  ) async {
    emit(AddFavoriteLoadingState());

    Either<Failure, void> response = await addFavorite(
      Params(joke: event.joke),
    );

    response.fold(
      (l) => emit(AddFavoriteFailureState(l)),
      (r) => emit(AddFavoriteLoadedState()),
    );
  }
}
