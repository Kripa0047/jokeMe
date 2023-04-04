import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/delete_favorite_usecase.dart';

part 'delete_favorite_event.dart';
part 'delete_favorite_state.dart';

class DeleteFavoriteBloc
    extends Bloc<DeleteFavoriteEvent, DeleteFavoriteState> {
  final DeleteFavoriteUsecase delete;
  DeleteFavoriteBloc(
    this.delete,
  ) : super(DeleteFavoriteInitial()) {
    on<DeleteEvent>(_onDelete);
  }

  FutureOr<void> _onDelete(
    DeleteEvent event,
    Emitter<DeleteFavoriteState> emit,
  ) async {
    emit(DeleteFavoriteLoadingState());

    Either<Failure, void> response = await delete(
      Params(joke: event.joke),
    );

    response.fold(
      (l) => emit(DeleteFavoriteFailureState(l)),
      (r) => emit(DeleteFavoriteLoadedState()),
    );
  }
}
