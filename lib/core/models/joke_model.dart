import 'package:joke_me/core/entities/joke_entity.dart';

class JokeModel extends JokeEntity {
  const JokeModel({
    required super.type,
    required super.setup,
    required super.punchline,
    required super.id,
  });

  factory JokeModel.fromJSON(Map<String, dynamic> json) {
    return JokeModel(
      type: json["type"],
      setup: json["setup"],
      punchline: json["punchline"],
      id: json["id"],
    );
  }

  factory JokeModel.fromEntity(JokeEntity entity) {
    return JokeModel(
      type: entity.type,
      setup: entity.setup,
      punchline: entity.punchline,
      id: entity.id,
    );
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      "type": type,
      "setup": setup,
      "punchline": punchline,
      "id": id,
    };
  }
}
