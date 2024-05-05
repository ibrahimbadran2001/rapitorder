import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/BannersModel.dart';
import 'package:proj1/models/categories_model.dart';
import 'package:proj1/modules/home/home_states.dart';
import 'package:proj1/shared/network/remote/dio_helper.dart';
import 'package:proj1/shared/network/remote/end_points.dart';
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  //List<String> categories = ['Burger', 'Pizza', 'Sandwich', 'Salad'];
  final ScrollController scrollController = ScrollController();
  int selectedIndex = 0;
  void scrollToSelectedIndex(int index,context) {
    final double itemSize = 150.0; // Width of the category item
    final double separatorSize = 10.0; // Width of the separator
    final double viewportWidth = MediaQuery.of(context).size.width; // Viewport width
    double offset = (itemSize + separatorSize) * index;
    double maxOffset = offset - (viewportWidth - itemSize) / 2; // Adjusted offset
    //if(index!=0 && index!=categories.length-1)
    scrollController.animateTo(
      maxOffset,
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
    emit(ChangeCategoryState());
  }
  List<BannerModel> banners = [];
  void getBanners(){
    emit(GetBannersLoadingState());
    DioHelper.getData(
      url: BANNERS,
    ).then((value){
      List<dynamic> responseData = List.from(value!.data);
      ListBannersModel bannersModel = ListBannersModel.fromJson(responseData);
      banners = bannersModel.banners;
      emit(GetBannersSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetBannersErrorState(error.toString()));
    });
  }
  List<CategoryItemModel> categories = [];
  void getCategories(){
    emit(GetCategoriesLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value){
      List<dynamic> responseData = List.from(value!.data);
      CategoriesModel bannersModel = CategoriesModel.fromJson(responseData);
      categories = bannersModel.categories;
      emit(GetCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoriesErrorState(error.toString()));
    });
  }
}