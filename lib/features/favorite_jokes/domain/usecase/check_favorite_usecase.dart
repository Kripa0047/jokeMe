import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/usecase/usecase.dart';
import 'package:joke_me/features/favorite_jokes/domain/repositories/favorite_repository.dart';

class CheckFavoriteUsecase implements UseCase<bool, Params> {
  final FavoriteRepository repository;

  CheckFavoriteUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.checkFavorite(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
