import 'package:equatable/equatable.dart';

class JokeEntity extends Equatable {
  const JokeEntity({
    required this.type,
    required this.setup,
    required this.punchline,
    required this.id,
  });

  final String type;
  final String setup;
  final String punchline;
  final int id;

  @override
  List<Object?> get props => [
        type,
        setup,
        punchline,
        id,
      ];
}
