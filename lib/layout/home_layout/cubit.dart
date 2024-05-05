import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/home_layout/states.dart';
import 'package:proj1/modules/favorite/favoritescreen.dart';
import 'package:proj1/modules/home/home_screen.dart';
import 'package:proj1/shared/network/local/cache_helper.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/orders/orders_screen.dart';
import '../../modules/tracking/trackordersscreen.dart';
class AppCubit extends Cubit<AppStates>{

      AppCubit() : super(AppStateinitialState());
     static AppCubit get(context) => BlocProvider.of(context);
     static ScaffoldState get2(context) => Scaffold.of(context);
      int currentindex = 0;
      bool drawer = false;
      void changedrawer() {
               drawer=true;
               emit(AppStatedrawerState());
      }
      List<Widget> Screen = [HomeScreen(), OrdersScreen(), CartScreen(), Track(), Favorite(),];
      void setcurrenetindex(int index){
        currentindex = index;
        emit(AppStateschangeState());
      }

      bool isDark=false;
      void changeAppMode({bool? fromShared}){
        if(fromShared!=null){
          isDark=fromShared;
          emit(ChangeAppModeState());
        }else{
        isDark=!isDark;
        CacheHelper.saveData(key: 'isDark', value: isDark).then((value) =>emit(ChangeAppModeState()) );
      }
      }
}