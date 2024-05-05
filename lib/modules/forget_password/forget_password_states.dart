import 'package:proj1/models/forget_password_model.dart';
abstract class ForgetPasswordStates {}
class ForgetPasswordInitialState extends ForgetPasswordStates {}
class ForgetPasswordSuccessState extends ForgetPasswordStates{
  final ForgetPasswordModel model;
  ForgetPasswordSuccessState(this.model);
}
class ForgetPasswordLoadingState extends ForgetPasswordStates{}
class ForgetPasswordErrorState extends ForgetPasswordStates{
  final String error;
  ForgetPasswordErrorState(this.error,);
}