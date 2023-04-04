import 'package:dartz/dartz.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/usecase/usecase.dart';
import 'package:joke_me/features/favorite_jokes/domain/repositories/favorite_repository.dart';

class GetFavoritesUsecase implements UseCase<List<JokeEntity>, NoParams> {
  final FavoriteRepository repository;

  GetFavoritesUsecase(this.repository);

  @override
  Future<Either<Failure, List<JokeEntity>>> call(NoParams params) async {
    return await repository.getAllFavorites();
  }
}
