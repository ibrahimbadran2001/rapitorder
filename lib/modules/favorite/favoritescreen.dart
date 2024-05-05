import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/home_layout/home_layout.dart';
import 'package:proj1/list.dart';
import 'package:proj1/modules/drawer/app_drawer.dart';
import 'package:proj1/modules/favorite/favorite_cubit.dart';
import 'package:proj1/modules/favorite/favorite_states.dart';
import 'package:proj1/modules/restaurant/restaurants_cubit.dart';
import 'package:proj1/shared/components/components.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../shared/style/color.dart';
import '../home/home_screen.dart';
import '../meal/meal_screen.dart';
import '../restaurant/restaurant_screen.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          FavoriteCubit cubit = BlocProvider.of(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Favorites',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            drawer: AppDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildToggleContainer(
                        context: context,
                        color: cubit.selectedContainerColor,
                        text: 'Food',
                        theme: Theme.of(context).textTheme.bodyMedium,
                        borderColor: cubit.selectedBorderColor,
                        onPress: () {
                          cubit.changeToFood();
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 20,
                      ),
                      buildToggleContainer(
                        context: context,
                        color: cubit.unselectedContainerColor,
                        text: 'Restaurants',
                        theme: Theme.of(context).textTheme.bodyMedium,
                        borderColor: cubit.unselectedBorderColor,
                        onPress: () {
                          cubit.changeToRestaurants();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 25,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => cubit.isRes
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildDismissible(index, context),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                key: ValueKey(index),
                                background: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: linergradientColors,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 16.0),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onDismissed: (_) {
                                  RestaurantCubit.get(context)
                                      .removeFromFavorites(index);
                                },
                                confirmDismiss: (_) async {
                                  return await showDialog<bool>(
                                    context: context,
                                    builder: (context) =>
                                        buildDeleteDialog(context),
                                  );
                                },
                                child: buildListItemItem(
                                  context: context,
                                  onPress: () {
                                    navigateTo(context, Item());
                                  },
                                  image:
                                      '${RestaurantCubit.get(context).favoriteFood[index].imageUrl}',
                                  text1:
                                      '${RestaurantCubit.get(context).favoriteFood[index].favoriteDish}',
                                  text2:
                                      '${RestaurantCubit.get(context).favoriteFood[index].price}',
                                  icon2: Icons.double_arrow_outlined,
                                ),
                              ),
                            ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: FavoriteCubit.get(context).isRes
                          ? 10
                          : RestaurantCubit.get(context).favoriteFood.length,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: defaultButton(
                      onPress: () {
                        if(RestaurantCubit.get(context).favoriteFood.isNotEmpty){
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: 'Clear Favorite Food !',
                            style: AlertStyle(
                              titleStyle: Theme.of(context).textTheme.bodyMedium??TextStyle(),
                              backgroundColor: Theme.of(context).cardColor,
                              alertBorder: Border.all(color: defaultColor,width: 2,),
                            ),
                            buttons: [
                              DialogButton(
                                  child: Text('cancel',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                                  gradient:linergradientColors,
                                  onPressed: (){
                                    Navigator.of(context).pop(true);
                                  }
                              ),
                              DialogButton(
                                  child: Text('clear',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                                  gradient:linergradientColors,
                                  onPressed: (){
                                    RestaurantCubit.get(context).clearFavorites();
                                    navigateAndFinish(context, HomeLayout());
                                  }
                              ),
                            ],
                          ).show();
                        }
                      },
                      text: 'clear all Favorites',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  AlertDialog buildDeleteDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirm Deletion',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: Text(
          'Are you sure you want to remove this item?',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
              'cancel',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: defaultColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'delete',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: defaultColor,
            ),
          ),
        ),
      ],
    );
  }

  Dismissible buildDismissible(int index, BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: ValueKey(index),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: linergradientColors,
        ),
        child: Row(
          children: [
            SizedBox(width: 16.0),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (_) {
        // // Handle delete action here
        // setState(() {
        // // Remove the item from the list
        // });
      },
      confirmDismiss: (_) async {
        //to confirm deletion by alert
      },
      child: buildListItemItem(
        context: context,
        onPress: () {
          navigateTo(context, RestaurantScreen());
        },
        image: 'assets/images/rest.jpg',
        text1: 'Restaurant Name',
        text2: 'Restaurant Address',
        icon2: Icons.double_arrow_outlined,
      ),
    );
  }
}
