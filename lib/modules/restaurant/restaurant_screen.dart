import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/food_model.dart';
import 'package:proj1/modules/restaurant/restaurant_states.dart';
import 'package:proj1/modules/restaurant/restaurants_cubit.dart';
import '../../models/data_model.dart';
import '../../shared/components/components.dart';
import '../../shared/style/color.dart';
import '../home/home_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return BlocConsumer<RestaurantCubit, RestaurantStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, RestaurantStates state) {
            RestaurantCubit cubit = RestaurantCubit.get(context);
            return ConditionalBuilder(
              condition: RestaurantCubit.get(context).foodData.length > 0,
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
                                image: AssetImage('assets/images/rest.jpg'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Resturant NameResturant NameResturant Resturant NameResturant NameResturant NameResturant NameResturant NameResturant NameResturant NameResturant NameNameResturant Name ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Resturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant DescriptionResturant Description ',
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
                          Container(
                            width: double.infinity,
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              children:
                                  List.generate(cubit.foodData.length, (index) {
                                return buildFoodTestItem(context,cubit.foodData[index],index);
                              }),
                            ),
                          ),
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
      },
    );
  }

  Widget buildFoodTestItem(context, DataModel model,int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          //navigateTo(context, Item());
        },
        onDoubleTap: () async {
          return await showFavoriteDialog(context: context,index: index);
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
                      '${model.imageUrl}',
                    ),
                  ),
                ),
              ),
              Text(
                '${model.favoriteDish}',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
