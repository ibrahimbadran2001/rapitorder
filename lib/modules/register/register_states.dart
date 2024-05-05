import '../../models/register_model.dart';
abstract class RegisterStates {}
class RegisterInitialState extends RegisterStates {}
class RegisterSecurePasswordState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates{
  final RegisterModel model;
  RegisterSuccessState(this.model);
}
class RegisterLoadingState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error,);
}