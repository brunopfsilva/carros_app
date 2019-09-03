import 'package:flutter/material.dart';



class apiResponse <T> {

  bool ok;
  String msg;
  T result;

  apiResponse.ok (this.result){
    ok = true;
  }

  apiResponse.error (this.msg){
    ok = false;
  }

}