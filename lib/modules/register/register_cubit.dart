import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/login/login_states.dart';
import 'package:proj1/models/login_model.dart';
import 'package:proj1/modules/register/register_states.dart';
import 'package:proj1/shared/network/remote/dio_helper.dart';
import 'package:proj1/shared/network/remote/end_points.dart';

import '../../models/register_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPass=false;
  void changePassIcon(){
    isPass=!isPass;
    emit(RegisterSecurePasswordState());
  }
  void userRegister({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String userType,
    required String username,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'full_name':fullName,
        'email':email,
        'phone':phone,
        'password':password,
        'confirm_password':confirmPassword,
        'user_type':userType,
        'username':username,
      },
    )!.then((value){
      RegisterModel model=RegisterModel.fromJson(value!.data);
      print(model.data.email);
      print(model.data.fullName);
      emit(RegisterSuccessState(model));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }
}