import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/bloc/register_cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

   late ShopLoginModel loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      path: login,
      data: {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone,
      },
      query:{'':''},

    ).then(
      (value) {
        //debugPrint(value.data.toString());
        loginModel = ShopLoginModel.fromJson(value.data);
        // debugPrint(loginModel.status.toString());
        // debugPrint(loginModel.message.toString());
        // debugPrint(loginModel.data.token.toString());
        emit(ShopRegisterSuccessState(loginModel));
      },
    ).catchError((onError) {
      emit(ShopRegisterErrorState(onError.toString()));
      debugPrint(onError.toString());
    });
  }

  bool isShown = true;
  IconData iconData = Icons.visibility;

  void changePasswordVisibility() {
    isShown = !isShown;
    iconData = isShown ? Icons.visibility : Icons.visibility_off_sharp;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}

