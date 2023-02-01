import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/changeFavorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/screens/categories.dart';
import 'package:shop_app/screens/favorites.dart';
import 'package:shop_app/screens/products.dart';
import 'package:shop_app/screens/settings.dart';
import 'package:shop_app/shared/bloc/app_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/dio_helper.dart';




class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const Products(),
    const Categories(),
    const FavoritesScreen(),
    Settings(),
  ];

  ShopLoginModel? shopLoginModel;
  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavStates());
    if(index == 2){
      emit(AppFavoritesStates());
    }
    if(index == 3){
      emit(AppSuccessUserDataStates(shopLoginModel!));
    }
  }

  HomeModel? homeModel;



  void getHomeData() {
    emit(AppLoadingHomeDataStates());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }
      //debugPrint(favorites.toString());
      //debugPrint(token);
      emit(AppSuccessHomeDataStates());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(AppErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: get_categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(AppSuccessCategoryStates());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(AppErrorCategoryStates(onError.toString()));
    });
  }


  void getUsrData() {
    emit(AppLoadingUserDataStates());
    DioHelper.getData(url: profile, token: token).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      debugPrint(shopLoginModel!.data!.name.toString());
      emit(AppSuccessUserDataStates(shopLoginModel!));
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(AppErrorUserDataStates());
    });
  }

  void updateUsrData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(AppLoadingUpdateUserDataStates());
    DioHelper.putData(
      path: update_profile,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      debugPrint(shopLoginModel!.data!.name.toString());
      emit(AppSuccessUpdateUserDataStates(shopLoginModel!));
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(AppErrorUpdateUserDataStates(onError));
    });
  }


  Map<int, bool> favorites = {};
  GetFavoritesModel? getFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(AppFavoritesStates());
    DioHelper.postData(
      path: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data!);
      if (getFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFav();
        emit(AppChangeFavoritesStates());
      }
      emit(AppSuccessFavoritesStates(getFavoritesModel!));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId]!;
      emit(AppErrorFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFav() {
    emit(AppLoadingGetFavoritesStates());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // debugPrint(value.data.toString());
      emit(AppSuccessGetFavoritesStates());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(AppErrorGetFavoritesStates());
    });
  }




}
