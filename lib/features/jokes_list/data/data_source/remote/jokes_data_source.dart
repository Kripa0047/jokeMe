import 'package:joke_me/config/apis.dart';
import 'package:joke_me/core/http/client.dart';

abstract class JokesDataSource {
  Future<List> getRandomTenJokes();
}

class JokesDataSourceImpl implements JokesDataSource {
  final HTTP httpClient;
  JokesDataSourceImpl(this.httpClient);

  @override
  Future<List> getRandomTenJokes() async {
    return await httpClient.client
        .get(
      APIs.randomTem,
    )
        .then((value) {
      return value.data;
    }).catchError((err) {
      throw (err);
    });
  }
}
