import 'package:carros_app/settings.dart';
import 'package:carros_app/utils/Common.dart';
import 'package:http/http.dart' as http;

class LoginApiUser {
  static Future<apiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = Common.ServerUrlv1;

      Map<String, String> hearders = {"Content-Type": "application/json"};

      //sempre que for json objecto trabalhar com maps
      Map params = {'username': login, 'password': senha};

      String s = json.encode(params);

      print(">> $s");

      var response = await http.post(url, body: s, headers: hearders);

      Map mapResponse = json.decode(response.body);

      Usuario usuario = Usuario.fromJson(mapResponse);

      if (response.statusCode == 200) {
        usuario.save();
        return apiResponse.ok(result: usuario);
      } else {
        return apiResponse.error(msg: mapResponse["error"]);
      }
    } catch (error, exception) {
      return apiResponse.error(msg: "Error não foi possivel fazer o login$error");
    }
  }
}
