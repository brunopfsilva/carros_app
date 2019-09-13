import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:carros_app/login/Usuario.dart';
import 'package:carros_app/settings.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class UploadService {
  static Future<String> upload(File file) async {
    try {
      String url = "https://carros-springboot.herokuapp.com/api/v2/upload";

      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = convert.base64Encode(imageBytes);

      String fileName = path.basename(file.path);

      Usuario usuario = await Usuario.get();

      Map<String,String> hearders = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${usuario.token}"
      };


      var params = {
        "fileName": fileName,
        "mimeType": "image/jpeg",
        "base64": base64Image
      };

      String json = convert.jsonEncode(params);

      print("http.upload: " + url);
      print("params: " + json);

      final response = await http
          .post(
        url,
        body: json,
        headers: hearders,
      )
          .timeout(
        Duration(seconds: 120),
        onTimeout: _onTimeOut,
      );

      print("http.upload << " + response.body);

      Map<String, dynamic> map = convert.json.decode(response.body);

      String urlFoto = map["url"];

      return urlFoto;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static FutureOr<http.Response> _onTimeOut() {
    print("timeout!");
    throw SocketException("Não foi possível se comunicar com o servidor.");
  }
}
