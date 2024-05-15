import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/search/search_states.dart';

import '../../models/search_model.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(GetSearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  List<RestaurantSearch> restaurantsSearch = [];
  List<FoodSearch> foodSearch = [];

  void getSearch(String word) {
    emit(GetSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'query': word,
      },
    ).then((value) {
      // Parse the response JSON
      Map<String, dynamic> json = value!.data;
      SearchModel searchModel = SearchModel.fromJson(json);
      // Update the foodSearch and restaurantsSearch lists
      foodSearch = searchModel.foods;
      restaurantsSearch = searchModel.restaurants;
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }
}
