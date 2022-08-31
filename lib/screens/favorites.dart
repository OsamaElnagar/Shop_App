import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/bloc/app_cubit/cubit.dart';
import 'package:shop_app/shared/bloc/app_cubit/states.dart';
import '../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favoritesModel != null,
          fallback: (context) => Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.menu,
                size: 200,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Text('No favorites yet, Browse to admir some',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          )),
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(
                cubit.favoritesModel!.data!.data[index], context),
            separatorBuilder: (context, index) => Container(
              height: 2,
              color: Colors.grey[300],
            ),
            itemCount: cubit.favoritesModel!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData favoritesData, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image:
                        NetworkImage(favoritesData.product!.image.toString()),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (favoritesData.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: const Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favoritesData.product!.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14.0, height: 1.5),
                    ),
                    Row(
                      children: [
                        Text(
                          favoritesData.product!.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: myColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (favoritesData.product!.discount != 0)
                          Text(
                            favoritesData.product!.oldPrice.toString(),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .changeFavorites(favoritesData.product!.id!);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: AppCubit.get(context)
                                        .favorites[favoritesData.product!.id] ==
                                    true
                                ? myColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
