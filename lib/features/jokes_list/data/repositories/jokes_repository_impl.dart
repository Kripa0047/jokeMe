import 'package:dartz/dartz.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/failures/jokes_failure.dart';
import 'package:joke_me/features/jokes_list/data/data_source/remote/jokes_data_source.dart';
import 'package:joke_me/core/models/joke_model.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/features/jokes_list/domain/repositories/jokes_repository.dart';

class JokesRepositoryImpl implements JokesRepository {
  final JokesDataSource source;

  const JokesRepositoryImpl(this.source);

  @override
  Future<Either<Failure, List<JokeEntity>>> getRandomTenJokes() async {
    try {
      List jokes = await source.getRandomTenJokes();
      return Right(
        jokes.map((joke) => JokeModel.fromJSON(joke)).toList(),
      );
    } catch (e) {
      return Left(
        UnknownJokeFailure(),
      );
    }
  }
}
