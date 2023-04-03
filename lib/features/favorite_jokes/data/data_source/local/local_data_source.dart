import 'dart:convert';

import 'package:joke_me/core/models/joke_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String favoriteKey = "FAVORITE";

abstract class LocalDataSource {
  Future<void> addToFavorite(JokeModel joke);
}

class LocalDataSourceImpl implements LocalDataSource {
  const LocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<void> addToFavorite(JokeModel joke) async {
    List<String> jokes = sharedPreferences.getStringList(
          favoriteKey,
        ) ??
        [];

    jokes.add(jsonEncode(joke.toJSON()));
    await sharedPreferences.setStringList(favoriteKey, jokes);
  }
}
