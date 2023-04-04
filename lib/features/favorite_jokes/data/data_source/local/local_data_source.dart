import 'dart:convert';

import 'package:joke_me/core/models/joke_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String favoriteKey = "FAVORITE";
const String favoriteIdKey = "FAVORITE_IDs";

abstract class LocalDataSource {
  Future<void> addToFavorite(JokeModel joke);
  Future<bool> checkFavorite(int id);
  Future<List> getFavorites();
  Future<void> deleteFavorite(JokeModel joke);
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
    List<String> ids = sharedPreferences.getStringList(favoriteIdKey) ?? [];

    if (!ids.contains(joke.id.toString())) {
      jokes.add(jsonEncode(joke.toJSON()));
      ids.add(joke.id.toString());
      await Future.wait([
        sharedPreferences.setStringList(favoriteKey, jokes),
        sharedPreferences.setStringList(favoriteIdKey, ids),
      ]);
    }
  }

  @override
  Future<bool> checkFavorite(int id) async {
    List<String> ids = sharedPreferences.getStringList(favoriteIdKey) ?? [];
    if (ids.contains(id.toString())) {
      return true;
    }
    return false;
  }

  @override
  Future<List> getFavorites() async {
    List<String> jokes = sharedPreferences.getStringList(
          favoriteKey,
        ) ??
        [];

    List decodedJokes = jokes.map((joke) => jsonDecode(joke)).toList();
    return decodedJokes;
  }

  @override
  Future<void> deleteFavorite(JokeModel joke) async {
    List<String> ids = sharedPreferences.getStringList(favoriteIdKey) ?? [];

    if (ids.contains(joke.id.toString())) {
      ids.remove(joke.id.toString());
      List<String> jokes = sharedPreferences.getStringList(
            favoriteKey,
          ) ??
          [];
      jokes.remove(jsonEncode(joke.toJSON()));

      await Future.wait([
        sharedPreferences.setStringList(favoriteKey, jokes),
        sharedPreferences.setStringList(favoriteIdKey, ids),
      ]);
    }
  }
}
