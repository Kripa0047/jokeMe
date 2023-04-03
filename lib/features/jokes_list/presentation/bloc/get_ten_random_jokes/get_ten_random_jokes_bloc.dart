import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/usecase/usecase.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/features/jokes_list/domain/usecases/ger_random_ten__jokes_usecase.dart';

part 'get_ten_random_jokes_event.dart';
part 'get_ten_random_jokes_state.dart';

class GetTenRandomJokesBloc
    extends Bloc<GetTenRandomJokesEvent, GetTenRandomJokesState> {
  final GetRandomTenJokesUsecase getJokes;

  GetTenRandomJokesBloc(this.getJokes) : super(GetTenRandomJokesInitial()) {
    on<GetJokesEvent>(_onGetJokes);
  }

  FutureOr _onGetJokes(
    GetJokesEvent event,
    Emitter<GetTenRandomJokesState> emit,
  ) async {
    emit(GetTenRandomJokesLoadingState());

    Either<Failure, List<JokeEntity>> response = await getJokes(
      NoParams(),
    );

    response.fold(
      (l) => emit(GetTenRandomJokesFailedState(l)),
      (r) => emit(GetTenRandomJokesLoadedState(r)),
    );
  }
}
