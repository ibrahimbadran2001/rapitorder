import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/models/change_password_model.dart';
import 'package:proj1/shared/network/remote/end_points.dart';

import '../../shared/network/remote/dio_helper.dart';
import 'change_password_states.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());
  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  void changePassword({required String email,required String password,required String otp}){
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
      url: CHANGE,
      data: {
        'email':email,
        'new_password':password,
        'otp':otp,
      },
    )!.then((value){
      ChangePasswordModel model=ChangePasswordModel.fromJson(value!.data);
      print(model.message);
      emit(ChangePasswordSuccessState(model));
    }).catchError((error){
      emit(ChangePasswordErrorState(error.toString()));
      print(error.toString());
    });
  }
}