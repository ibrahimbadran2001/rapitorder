import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/login/login_states.dart';
import 'package:proj1/models/login_model.dart';
import 'package:proj1/shared/network/remote/dio_helper.dart';
import 'package:proj1/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isPass=false;
  void changePassIcon(){
    isPass=!isPass;
    emit(LoginSecurePasswordState());
  }
  void userLogin({required String email,required String password}){
    emit(CustomerLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    )!.then((value){
      CustomerLoginModel model=CustomerLoginModel.fromJson(value!.data);
      print(model.status);
      emit(CustomerLoginSuccessState(model:model));
    }).catchError((error){
      emit(CustomerLoginErrorState(error.toString()));
      print(error.toString());
    });
  }
}