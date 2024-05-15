import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/meal/meal_cubit.dart';
import 'package:proj1/modules/restaurant/restaurant_states.dart';
import 'package:proj1/modules/restaurant/restaurants_cubit.dart';

import '../../models/restaurant_food_model.dart';
import '../../shared/components/components.dart';
import '../../shared/style/color.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantStates>(
      listener: (BuildContext context, state) {
        if (state is GetRestaurantsDetailSuccessState) {
          RestaurantCubit.get(context)
              .getRestaurantsFood(state.restaurantItemDetailModel.id);
        }
      },
      builder: (BuildContext context, RestaurantStates state) {
        RestaurantCubit cubit = RestaurantCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetRestaurantsDetailLoadingState,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(RestaurantCubit.get(context)
                                .restaurantsDetial!
                                .picture),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        RestaurantCubit.get(context).restaurantsDetial!.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        RestaurantCubit.get(context).restaurantsDetial!.desc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontFamily: 'sk'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        onPress: () {},
                        text: 'Add to favourites',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Our Food',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      ConditionalBuilder(
                        condition: state is! GetRestaurantsFoodLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: List.generate(
                                RestaurantCubit.get(context)
                                    .restaurantsFood
                                    .length, (index) {
                              return buildFoodTestItem(
                                  context,
                                  RestaurantCubit.get(context)
                                      .restaurantsFood[index],
                                  index);
                            }),
                          ),
                        ),
                        fallback: (context) => Center(
                            child: CircularProgressIndicator(
                          color: defaultColor,
                        )),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            color: defaultColor,
          )),
        );
      },
    );
  }

  Widget buildFoodTestItem(context, RestaurantFoodModel model, int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
//navigateTo(context, Item());
        },
        onDoubleTap: () async {
          return await showFavoriteDialog(context: context, index: index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          height: 150,
          width: 175,
          decoration: myBoxShadow(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 120,
                decoration: BoxDecoration(
// color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromRGBO(249, 136, 31, 1)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(model.picture),
                  ),
                ),
              ),
// Text(
//   '${model.favoriteDish}',
//   overflow: TextOverflow.ellipsis,
//   textAlign: TextAlign.center,
//   maxLines: 1,
//   style: Theme.of(context).textTheme.bodyMedium,
// ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${model.price}\$',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: defaultColor,
                          ),
                          color: defaultColor,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 15.0,
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
