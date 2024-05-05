import '../../models/verification_model.dart';
abstract class VerificationStates {}
class VerificationInitialState extends VerificationStates {}
class VerificationSuccessState extends VerificationStates{
  final VerificationModel model;
  VerificationSuccessState(this.model);
}
class VerificationLoadingState extends VerificationStates{}
class VerificationErrorState extends VerificationStates{
  final String error;
  VerificationErrorState(this.error,);
}