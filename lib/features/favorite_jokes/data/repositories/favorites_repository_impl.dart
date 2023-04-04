import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:joke_me/core/failures/favorite_failure.dart';
import 'package:joke_me/core/models/joke_model.dart';
import 'package:joke_me/features/favorite_jokes/data/data_source/local/local_data_source.dart';
import 'package:joke_me/features/favorite_jokes/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  const FavoriteRepositoryImpl(this.localDataSource);

  final LocalDataSource localDataSource;

  @override
  Future<Either<Failure, void>> addFavorite(JokeEntity joke) async {
    try {
      await localDataSource.addToFavorite(
        JokeModel.fromEntity(joke),
      );
      return const Right(null);
    } catch (e) {
      return Left(UnknownFavoriteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkFavorite(int id) async {
    try {
      bool isPresent = await localDataSource.checkFavorite(id);
      return Right(isPresent);
    } catch (e) {
      return Left(UnknownFavoriteFailure());
    }
  }

  @override
  Future<Either<Failure, List<JokeEntity>>> getAllFavorites() async {
    try {
      List jokes = await localDataSource.getFavorites();
      return Right(
        jokes.map((joke) => JokeModel.fromJSON(joke)).toList(),
      );
    } catch (e) {
      return Left(UnknownFavoriteFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavorite(JokeEntity joke) async {
    try {
      await localDataSource.deleteFavorite(
        JokeModel.fromEntity(joke),
      );
      return const Right(null);
    } catch (e) {
      return Left(UnknownFavoriteFailure());
    }
  }
}
