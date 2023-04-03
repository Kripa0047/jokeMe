import 'package:get_it/get_it.dart';
import 'package:joke_me/core/http/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final HTTP http = HTTP();
  sl.registerLazySingleton(() => http);
}
