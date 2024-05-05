import '../../models/change_password_model.dart';

abstract class ChangePasswordStates {}
class ChangePasswordInitialState extends ChangePasswordStates {}
class ChangePasswordSuccessState extends ChangePasswordStates{
  final ChangePasswordModel model;
  ChangePasswordSuccessState(this.model);
}
class ChangePasswordLoadingState extends ChangePasswordStates{}
class ChangePasswordErrorState extends ChangePasswordStates{
  final String error;
  ChangePasswordErrorState(this.error,);
}