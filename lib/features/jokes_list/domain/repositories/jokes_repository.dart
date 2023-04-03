import 'package:dartz/dartz.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/entities/joke_entity.dart';

abstract class JokesRepository {
  Future<Either<Failure, List<JokeEntity>>> getRandomTenJokes();
}
