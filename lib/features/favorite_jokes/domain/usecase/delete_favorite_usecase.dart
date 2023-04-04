import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/usecase/usecase.dart';
import 'package:joke_me/features/favorite_jokes/domain/repositories/favorite_repository.dart';

class DeleteFavoriteUsecase implements UseCase<void, Params> {
  final FavoriteRepository repository;

  DeleteFavoriteUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteFavorite(params.joke);
  }
}

class Params extends Equatable {
  const Params({required this.joke});

  final JokeEntity joke;

  @override
  List<Object?> get props => [joke];
}
