import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/on_boarding/on_boarding.dart';
import '../../screens/login.dart';
import '../network/remote/cache_helper.dart';
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Future navigate2(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void showToast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 12.0);
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color= Colors.green;
      break;
    case ToastStates.warning:
      color= Colors.yellow;
      break;
    case ToastStates.error:
      color= Colors.red;
      break;
  }
  return color;
}

void signOut(context) {
  CacheHelper.removeData('token').then((value) {
    if (value) {
      navigate2(context, ShopLogin());
    }
  });}

void clearPref(context) {
  CacheHelper.clearData().then((value) {
    if (value) {
      navigate2(context, const OnBoarding());
    }
  });}

void printFulltext(String text){
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {debugPrint(element.group(0));});
  
}

 String? token = '';

