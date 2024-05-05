import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/forget_password/forget_password_states.dart';
import 'package:proj1/shared/network/remote/end_points.dart';

import '../../models/forget_password_model.dart';
import '../../shared/network/remote/dio_helper.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  void senOtp({required String email,}){
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(
      url: RESET,
      data: {
        'email':email,
      },
    )!.then((value){
      ForgetPasswordModel model=ForgetPasswordModel.fromJson(value!.data);
      print(model.message);
      emit(ForgetPasswordSuccessState(model));
    }).catchError((error){
      emit(ForgetPasswordErrorState(error.toString()));
      print(error.toString());
    });
  }
}