import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/meal_model.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/end_points.dart';
import 'meal_states.dart';
class MealCubit extends Cubit<MealStates> {
  MealCubit() : super(MealInitialState());
  static MealCubit get(context) => BlocProvider.of(context);
  void getFoodDetails(int id){
    emit(GetMealDetailsLoadingState());
    DioHelper.getData(
      url: FOODDETAILS+id.toString(),
    ).then((value){
      MealModel model = MealModel.fromJson(value!.data);
      emit(GetMealDetailsSuccessState(model));
    }).catchError((error){
      print(error.toString());
      emit(GetMealDetailsErrorState(error.toString()));
    });
  }
}
