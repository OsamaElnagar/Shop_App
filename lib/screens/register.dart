import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc/register_cubit/cubit.dart';
import 'package:shop_app/shared/bloc/register_cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/homeLayout/home_layout.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              debugPrint(state.loginModel.message.toString());
              CacheHelper.saveLoginData(
                'token',
                state.loginModel.data!.token,
              ).then(
                (value) {
                  token = state.loginModel.data!.token;
                  navigate2(context, const ShopLayout());
                },
              ).catchError((onError) {});
              showToast(
                msg: state.loginModel.message!,
                state: ToastStates.success,
              );
            } else {
              debugPrint(state.loginModel.message.toString());
              showToast(
                msg: state.loginModel.message!,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'register'.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: myColor,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'register now to win our hot offers'.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Name must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('name'),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Phone must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('phone'),
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Email must not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('email'),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Password must not be empty';
                            }
                            return null;
                          },
                          obscureText: ShopRegisterCubit.get(context).isShown,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: const Text('password'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(
                                ShopRegisterCubit.get(context).iconData,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_rounded,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: double.infinity,
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'register'.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            );
                          },
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
