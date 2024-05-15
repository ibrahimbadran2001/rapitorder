import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/categories_model.dart';
import 'package:proj1/modules/drawer/app_drawer.dart';
import 'package:proj1/modules/home/home_cubit.dart';
import 'package:proj1/modules/home/home_states.dart';
import 'package:proj1/modules/meal/meal_cubit.dart';
import 'package:proj1/modules/meal/meal_screen.dart';
import 'package:proj1/modules/search/search_screen.dart';
import 'package:proj1/shared/components/components.dart';
import 'package:proj1/models/meal_model.dart';
import 'package:proj1/shared/style/color.dart';
import '../../models/food_model.dart';
import '../restaurant/restaurant_screen.dart';
import '../restaurant/restaurants_cubit.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {

      },
      builder: (BuildContext context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              'App Name',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              SizedBox(width: 10,)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConditionalBuilder(
                    condition: cubit.banners.length>0,
                    builder: (BuildContext context) {
                     return CarouselSlider(
                        items: cubit.banners
                            .map((e) =>
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(e.banner),)
                              ),
                            ))
                            .toList(),
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          autoPlay: true,
                          reverse: false,
                          autoPlayInterval: Duration(seconds: 4),
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          scrollDirection: Axis.horizontal,
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ),
                      );
                    },
                    fallback: (BuildContext context) {
                      return Center(child: CircularProgressIndicator(color: defaultColor,));
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Categories & Meals',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                  ),
                  ConditionalBuilder(
                    condition: state is! GetCategoriesLoadingState,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: 50,
                        child: ListView.separated(
                          //physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          controller: cubit.scrollController,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () {
                                  cubit.setCurrentIndex(index);
                                  cubit.scrollToSelectedIndex(index, context);
                                  cubit.getFoodByCategory(cubit.categories[index].id);
                                },
                                child: buildCategoryItem(
                                    context, cubit.selectedIndex, index,
                                    cubit.categories),
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                width: 10,
                              ),
                          itemCount: cubit.categories.length,
                        ),
                      );
                    },
                    fallback: (BuildContext context) {
                      return Center(child: CircularProgressIndicator(color: defaultColor,));
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! GetFoodByCategoryLoadingState,
                    builder: (BuildContext context) {
                      return  Container(
                        //color: Colors.red,
                        height: 170.0,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              buildFoodItem(context, cubit.foodByCategory[index]),
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                width: 10,
                              ),
                          itemCount: cubit.foodByCategory.length,
                        ),
                      );
                    },
                    fallback: (BuildContext context) {
                      return Center(child: CircularProgressIndicator(color: defaultColor,));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Popular Restaurants',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ConditionalBuilder(
                      condition: state is! GetRestaurantsLoadingState,
                      builder: (context) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildListRestaurantItem(
                                context: context,
                                icon: Icons.double_arrow_sharp,
                                onPress: () {
                                  RestaurantCubit.get(context).getRestaurantsDetial(HomeCubit.get(context).restaurants[index].id);
                                  //  RestaurantCubit.get(context).getRestaurantsFood(HomeCubit.get(context).restaurants[index].id);

                                  navigateTo(context, RestaurantScreen());
                                },
                                restaurants: HomeCubit.get(context).restaurants,
                                favVisible: true,
                                index: index,
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: HomeCubit.get(context).restaurants.length,
                        );
                      },
                      fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: defaultColor,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: AppDrawer(),
        );
      },

    );
  }


  Widget buildCategoryItem(context, selectedIndex, index, List<CategoryItemModel>categories) =>
      AnimatedContainer(
        height: 50,
        width: 150,
        duration: Duration(milliseconds: 500),
        // Animation duration
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          border: Border.all(
              color: selectedIndex == index ? Colors.green : Color.fromRGBO(
                  249, 136, 31, 1)),
          borderRadius: BorderRadius.circular(10),
          color: selectedIndex == index
              ? Color.fromRGBO(150, 255, 100, 0.3)
              : Theme
              .of(context)
              .cardColor,
        ),
        child: Row(
          children: [
            SizedBox(width: 5,),
            Container(
              width: 50,
              height:50 ,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:NetworkImage(HomeCubit.get(context).categories[index].icon),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Text(
                HomeCubit.get(context).categories[index].name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ),
          ],
        ),
      );

  Widget buildFoodItem(context,FoodModel model,) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, MealScreen(id: model.id,));
        },
        onDoubleTap: () async {
          return await showFavoriteDialog(context: context);
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
                    image: NetworkImage(
                      model.picture,
                    ),
                  ),
                ),
              ),
              Text(
                model.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        model.price.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
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



