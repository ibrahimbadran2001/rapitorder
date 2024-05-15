import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proj1/modules/home/home_cubit.dart';
import 'package:proj1/modules/meal/meal_cubit.dart';
import 'package:proj1/modules/meal/meal_states.dart';
import 'package:proj1/shared/style/color.dart';
import '../../shared/components/components.dart';

class MealScreen extends StatelessWidget {
  final int id;
  const MealScreen({required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealCubit()..getFoodDetails(id),
      child: BlocConsumer<MealCubit,MealStates>(
        listener: (context,state){

        },
        builder: (context, state){
          if (state is GetMealDetailsLoadingState) {
            // Show a loading indicator
            return Scaffold(body: Center(child: CircularProgressIndicator(color: defaultColor,)));
          }else if(state is GetMealDetailsSuccessState){
            final mealModel=state.model;
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              mealModel.picture,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 30,
                      ),
                      Text(
                        mealModel.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.restaurant,color: defaultColor,),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Abo Adnan ',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Icon(Icons.receipt_long_outlined,color: defaultColor,),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            mealModel.price,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(Icons.alarm,color: defaultColor,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '5-10 min',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 30,
                      ),
                      Text(
                        mealModel.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontFamily: 'sk'),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 12,
                      ),
                      defaultButton(
                        onPress: () {},
                        text: 'Add to favorite',
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 40,
                      ),
                      defaultButton(
                        onPress: () {},
                        text: 'Add to Cart',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else if (state is GetMealDetailsErrorState){
            return Scaffold(body: Text('Something went wrong'));
          }
          else{
            return Scaffold(body: Container());
          }
        },
      ),
    );
  }
}
