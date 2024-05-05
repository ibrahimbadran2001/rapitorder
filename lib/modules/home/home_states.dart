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