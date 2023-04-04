import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/features/favorite_jokes/domain/usecase/check_favorite_usecase.dart';

part 'check_favorite_event.dart';
part 'check_favorite_state.dart';

class CheckFavoriteBloc extends Bloc<CheckFavoriteEvent, CheckFavoriteState> {
  final CheckFavoriteUsecase check;
  CheckFavoriteBloc(this.check) : super(CheckFavoriteInitial()) {
    on<CheckEvent>(_onCheck);
  }

  FutureOr<void> _onCheck(
    CheckEvent event,
    Emitter<CheckFavoriteState> emit,
  ) async {
    emit(CheckFavoriteLoadingState());

    Either<Failure, bool> response = await check(Params(id: event.id));

    response.fold(
      (l) => emit(CheckFavoriteFailureState(l)),
      (r) => emit(CheckFavoriteLoadedState(r)),
    );
  }
}
