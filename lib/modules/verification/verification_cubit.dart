import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/verification/verification_states.dart';

import '../../models/verification_model.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/end_points.dart';
class VerificationCubit extends Cubit<VerificationStates> {
  VerificationCubit() : super(VerificationInitialState());
  static VerificationCubit get(context) => BlocProvider.of(context);

  void verifyOtp({required String otp,required String email}){
    emit(VerificationLoadingState());
    DioHelper.postData(
      url: VERIFY,
      data: {
        'otp':otp,
        'email':email,
      },
    )!.then((value){
      VerificationModel model=VerificationModel.fromJson(value!.data);
      print(model.message);
      emit(VerificationSuccessState(model));
    }).catchError((error){
      emit(VerificationErrorState(error.toString()));
      print(error.toString());
    });
  }
}