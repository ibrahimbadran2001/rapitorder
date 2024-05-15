import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/meal/meal_cubit.dart';
import 'package:proj1/modules/meal/meal_screen.dart';
import 'package:proj1/modules/search/search_cubit.dart';
import 'package:proj1/modules/search/search_states.dart';
import 'package:proj1/shared/components/components.dart';
import 'package:proj1/shared/style/color.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final searchCubit = context.watch<SearchCubit>();

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                         searchCubit.getSearch(value);
                      }
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    cursorColor: defaultColor.withOpacity(0.7),
                    decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: defaultColor,
                      )
                  ),
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition: state is! GetSearchLoadingState,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // Access the search results from the searchCubit
                          final restaurants = searchCubit.restaurantsSearch;
                          final foods = searchCubit.foodSearch;
                          // Render the items based on the search results
                          if (index < restaurants.length) {
                            final restaurant = restaurants[index];
                            return Container(
                              child: ListTile(
                                leading: Container(
                                  width: 100,height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage('https://rapitorder.pythonanywhere.com/${restaurant.picture}')
                                    ),
                                  ),
                                ),
                                title: Text(
                                  restaurant.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  restaurant.address,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  onPressed: (){

                                  },
                                  icon: Icon(Icons.arrow_forward_ios,color: defaultColor,),
                                ),
                                // Other food properties
                              ),
                            );
                          } else {
                            final foodIndex = index - restaurants.length;
                            final food = foods[foodIndex];
                            return ListTile(
                              leading: Container(
                                width: 100,height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage('https://rapitorder.pythonanywhere.com/${food.picture}')
                                  ),
                                ),
                              ),
                              title: Text(
                                food.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                food.price.toString(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).textTheme.titleSmall!.color,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: (){
                                  navigateTo(context, MealScreen(id: food.id));
                                },
                                icon: Icon(Icons.arrow_forward_ios,color: defaultColor,),
                              ),
                              // Other food properties
                            );
                          }
                        },
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: myDivider(),
                        ),
                        itemCount: searchCubit.restaurantsSearch.length+searchCubit.foodSearch.length,
                      ),
                    );
                  },
                  fallback: (BuildContext context) {
                    return Center(child: CircularProgressIndicator(color: defaultColor,));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
