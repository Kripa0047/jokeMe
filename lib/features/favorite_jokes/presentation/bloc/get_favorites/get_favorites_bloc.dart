import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/usecase/usecase.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/get_favorites_usecase.dart';

part 'get_favorites_event.dart';
part 'get_favorites_state.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesState> {
  final GetFavoritesUsecase getFavorites;

  GetFavoritesBloc(
    this.getFavorites,
  ) : super(GetFavoritesInitial()) {
    on<GetFavoriteJokesEvent>(_onGetJokes);
  }

  FutureOr<void> _onGetJokes(
    GetFavoriteJokesEvent event,
    Emitter<GetFavoritesState> emit,
  ) async {
    emit(GetFavoritesLoadingState());

    Either<Failure, List<JokeEntity>> response = await getFavorites(
      NoParams(),
    );

    response.fold(
      (l) => emit(GetFavoritesFailureState(l)),
      (r) => emit(GetFavoritesLoadedState(r)),
    );
  }
}
