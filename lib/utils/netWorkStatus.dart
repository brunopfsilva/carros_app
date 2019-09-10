import 'package:connectivity/connectivity.dart';


Future<bool> insNetworkOn () async {
var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.none) {

  //se nao tiver internet retorna false
  return false;

} else {
  return true;
}

}
