import 'package:bloc/bloc.dart';
abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class ChangeCategoryState extends HomeStates{}
class GetBannersSuccessState extends HomeStates{}
class GetBannersLoadingState extends HomeStates{}
class GetBannersErrorState extends HomeStates{
  GetBannersErrorState(String error);
}
class GetCategoriesSuccessState extends HomeStates{}
class GetCategoriesLoadingState extends HomeStates{}
class GetCategoriesErrorState extends HomeStates{
  GetCategoriesErrorState(String error);
}
class GetFoodByCategorySuccessState extends HomeStates{}
class GetFoodByCategoryLoadingState extends HomeStates{}
class GetFoodByCategoryErrorState extends HomeStates{
  GetFoodByCategoryErrorState(String error);
}
class GetRestaurantsSuccessState extends HomeStates {}
class GetRestaurantsLoadingState extends HomeStates {}
class GetRestaurantsErrorState extends HomeStates {
  GetRestaurantsErrorState(String error);
}