// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/homeLayout/home_layout.dart';
import 'package:shop_app/screens/login.dart';
import 'package:shop_app/shared/bloc/app_cubit/cubit.dart';
import 'package:shop_app/shared/bloc/app_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/network/local/dio_helper.dart';
import 'package:shop_app/shared/network/local/blocObserver.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'on_boarding/on_boarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData('onBoarding');
  token = CacheHelper.getData('token');

  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = const OnBoarding();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget: widget));
    },
    blocObserver: MyBlocObserver(),
  );

  DioHelper.init();
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getHomeData()
            ..getCategories()
            ..getFav()
            ..getUsrData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
