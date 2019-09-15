

import 'package:carros_app/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class FireBaseService {


  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<apiResponse> CadastoFirebaseGoogle(String nome,String email, String password) async {




    try {




       AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
       //auth firebase
       final FirebaseUser firebaseUser = result.user;

      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nome;
      userUpdateInfo.photoUrl = "https://s3-sa-east-1.amazonaws.com/livetouch-temp/livros/foto.png";
       firebaseUser.updateProfile(userUpdateInfo);

      //cria usuario no app
      final user = Usuario(
        nome: firebaseUser.displayName,
        email: firebaseUser.email,
        urlFoto: firebaseUser.photoUrl,
      );

      user.save();

      return apiResponse.ok(result: true,msg: "Usuario cadastrado com sucesso");

    } on Exception catch (e) {

      print("Error code${e}");
    }




  }


  Future<apiResponse> loginGooglewithUserPass(String email,String senha) async {




    try {



      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: senha);
      //auth firebase
      final FirebaseUser firebaseUser = result.user;
      print("Firebase nome: ${firebaseUser.displayName}");
      print("Firebase email: ${firebaseUser.email}");
      print("Firebase photo: ${firebaseUser.photoUrl}");

      //cria usuario no app
      final user = Usuario(
        nome: firebaseUser.displayName,
        email: firebaseUser.email,
        urlFoto: firebaseUser.photoUrl,
      );

      user.save();

      return apiResponse.ok(result: result);

    } on Exception catch (e) {
      // TODO
    }




  }


  Future<apiResponse> loginGoogle() async {




    try {

      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      print("Google user ${googleSignInAccount} ");

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      //auth firebase
      final FirebaseUser firebaseUser = result.user;
      print("Firebase nome: ${firebaseUser.displayName}");
      print("Firebase email: ${firebaseUser.email}");
      print("Firebase photo: ${firebaseUser.photoUrl}");

      //cria usuario no app
      final user = Usuario(
          nome: firebaseUser.displayName,
          email: firebaseUser.email,
          urlFoto: firebaseUser.photoUrl,
      );

      user.save();

      return apiResponse.ok(result: result);

    } on Exception catch (e) {
      // TODO
    }




  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

}