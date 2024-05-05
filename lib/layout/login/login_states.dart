import 'package:proj1/models/login_model.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates {}
class LoginSecurePasswordState extends LoginStates {}
class CustomerLoginSuccessState extends LoginStates{
  final CustomerLoginModel model;
  CustomerLoginSuccessState({required this.model});
}
class CustomerLoginLoadingState extends LoginStates{}
class CustomerLoginErrorState extends LoginStates{
  final String error;
  CustomerLoginErrorState(this.error,);
}