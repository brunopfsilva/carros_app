import 'dart:async';

import 'package:carros_app/login/login_api_user.dart';
import 'package:carros_app/utils/api_response.dart';

import 'Usuario.dart';
import 'login_api.dart';

class loginBloc {
  final _streamController = StreamController<bool>();

  Stream<bool> get hear => _streamController.stream;

  Future<apiResponse<Usuario>> login(String login, String senha) async {
    _streamController.sink.add(true);

    apiResponse response = await LoginApiUser.login(login, senha);

    _streamController.sink.add(false);

    return response;
  }

  dispose() {
    _streamController.close();
  }
}
