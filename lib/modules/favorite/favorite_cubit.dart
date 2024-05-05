import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/favorite/favorite_states.dart';
import 'package:proj1/shared/style/color.dart';

class FavoriteCubit extends Cubit<FavoriteStates>{
  FavoriteCubit ()  : super(FavoriteInitialState());
  static FavoriteCubit get(context) => BlocProvider.of(context);
  bool isRes=false;
  Color selectedBorderColor=Colors.green;
  Color unselectedBorderColor=Color.fromRGBO(249, 136, 31, 1);
  Color selectedContainerColor=Color.fromRGBO(150, 255, 100,0.3);
  Color unselectedContainerColor=Colors.transparent;
  void changeToRestaurants(){
    if(!isRes){
      isRes=!isRes;
      selectedContainerColor=Colors.transparent;
      unselectedContainerColor=Color.fromRGBO(150, 255, 100,0.3);
      selectedBorderColor=Color.fromRGBO(249, 136, 31, 1);
      unselectedBorderColor=Colors.green;
      print('2222222222');
      print(isRes);
      emit(FavoriteRestaurantsState());
    }
  }
  void changeToFood(){
    if(isRes){
      isRes=!isRes;
      selectedContainerColor=Color.fromRGBO(150, 255, 100,0.3);
      unselectedContainerColor=Colors.transparent;
      selectedBorderColor=Colors.green;
      unselectedBorderColor=Color.fromRGBO(249, 136, 31, 1);
      print('11111111');
      print(isRes);
      emit(FavoriteFoodState());
    }
  }
}