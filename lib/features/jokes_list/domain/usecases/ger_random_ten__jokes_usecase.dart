import 'package:dartz/dartz.dart';
import 'package:joke_me/core/failures/failure.dart';
import 'package:joke_me/core/usecase/usecase.dart';
import 'package:joke_me/core/entities/joke_entity.dart';
import 'package:joke_me/features/jokes_list/domain/repositories/jokes_repository.dart';

class GetRandomTenJokesUsecase implements UseCase<List<JokeEntity>, NoParams> {
  final JokesRepository repository;

  GetRandomTenJokesUsecase(this.repository);

  @override
  Future<Either<Failure, List<JokeEntity>>> call(NoParams params) async {
    return await repository.getRandomTenJokes();
  }
}
