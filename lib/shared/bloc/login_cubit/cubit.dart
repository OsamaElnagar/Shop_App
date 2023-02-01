import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/bloc/login_cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/dio_helper.dart';





class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      path: login,
      data: {
        'email': email,
        'password': password,
      },

    ).then(
      (value) {
        loginModel = ShopLoginModel.fromJson(value.data);
        print(loginModel!.data);
        emit(ShopLoginSuccessState(loginModel!));
      },
    ).catchError((onError) {
      emit(ShopLoginErrorState(onError.toString()));
      debugPrint(onError.toString());
    });
  }

  bool isShown = true;
  IconData iconData = Icons.visibility;

  void changePasswordVisibility() {
    isShown = !isShown;
    iconData = isShown ? Icons.visibility : Icons.visibility_off_sharp;

    emit(ShopChangePasswordVisibilityState());
  }
}
