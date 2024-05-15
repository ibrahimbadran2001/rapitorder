import 'package:bloc/bloc.dart';
import 'package:proj1/models/meal_model.dart';
abstract class MealStates{}
class MealInitialState extends MealStates{}
class GetMealDetailsSuccessState extends MealStates{
  final MealModel model;
  GetMealDetailsSuccessState(this.model);
}
class GetMealDetailsLoadingState extends MealStates{}
class GetMealDetailsErrorState extends MealStates{
  GetMealDetailsErrorState(String error);
}