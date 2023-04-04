import 'package:dartz/dartz.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/core/failures/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, bool>> checkFavorite(int id);
  Future<Either<Failure, void>> addFavorite(JokeEntity joke);
  Future<Either<Failure, void>> deleteFavorite(JokeEntity joke);
  Future<Either<Failure, List<JokeEntity>>> getAllFavorites();
}
