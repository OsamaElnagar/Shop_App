import 'package:shop_app/models/login_model.dart';

import '../../../models/changeFavorites_model.dart';

abstract class AppStates {}

class AppInitStates extends AppStates {}

class AppChangeModeStates extends AppStates {}

class AppChangeBottomNavStates extends AppStates {}

class AppLoadingHomeDataStates extends AppStates {}

class AppSuccessHomeDataStates extends AppStates {}

class AppErrorHomeDataStates extends AppStates {}

class AppSuccessCategoryStates extends AppStates {}

class AppErrorCategoryStates extends AppStates {
  final String error;

  AppErrorCategoryStates(this.error);
}

class AppFavoritesStates extends AppStates {}

class AppSuccessFavoritesStates extends AppStates {
  final GetFavoritesModel getFavoritesModel;

  AppSuccessFavoritesStates(this.getFavoritesModel);
}

class AppErrorFavoritesStates extends AppStates {}

class AppChangeFavoritesStates extends AppStates {}

class AppSuccessGetFavoritesStates extends AppStates {}

class AppLoadingGetFavoritesStates extends AppStates {}

class AppErrorGetFavoritesStates extends AppStates {}

class AppSuccessUserDataStates extends AppStates {
  final ShopLoginModel shopLoginModel;

  AppSuccessUserDataStates(this.shopLoginModel);
}

class AppLoadingUserDataStates extends AppStates {}

class AppErrorUserDataStates extends AppStates {}

class AppSuccessUpdateUserDataStates extends AppStates {
  final ShopLoginModel shopLoginModel;

  AppSuccessUpdateUserDataStates(this.shopLoginModel);
}

class AppLoadingUpdateUserDataStates extends AppStates {}

class AppErrorUpdateUserDataStates extends AppStates {
  final String error;

  AppErrorUpdateUserDataStates(this.error);
}
