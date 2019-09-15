import 'dart:async';

import 'package:carros_app/login/firebase_service.dart';
import 'package:carros_app/login/login_api_user.dart';
import 'package:carros_app/utils/api_response.dart';

import 'Usuario.dart';
import 'login_api.dart';

class loginBlocFire {
  final _streamController = StreamController<bool>();

  Stream get hear => _streamController.stream;

  Future<apiResponse> login(String login, String senha) async {

    try {
      _streamController.sink.add(true);

         // apiResponse response = await LoginApiUser.login(login, senha);
       apiResponse response = await FireBaseService().loginGooglewithUserPass(login, senha);

      _streamController.sink.add(false);

      return response;
    } on Exception catch (e) {
      // TODO
    }throw(Exception);
  }

  dispose() {
    _streamController.close();
  }
}
