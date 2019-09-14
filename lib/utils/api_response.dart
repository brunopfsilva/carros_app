import 'package:flutter/material.dart';

class apiResponse<T> {
  bool ok;
  String msg;
  T result;

  apiResponse.ok({this.result,this.msg}) {
    ok = true;
  }

  apiResponse.error({this.result,this.msg}) {
    ok = false;
  }
}
