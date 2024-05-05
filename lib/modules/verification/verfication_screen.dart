import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:proj1/modules/change_password/change_password_screen.dart';
import 'package:proj1/modules/verification/verification_cubit.dart';
import 'package:proj1/modules/verification/verification_states.dart';
import '../../shared/components/components.dart';
import '../../shared/style/color.dart';
import '../../shared/style/themes.dart';

class VerificationScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final String email;
  VerificationScreen({required this.email});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: BlocConsumer<VerificationCubit, VerificationStates>(
        listener: (context, state) {
          if (state is VerificationSuccessState) {
            if (state.model.status) {
              Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              navigateAndFinish(
                  context,
                  ChangePasswordScreen(
                    email: email,
                    otp: otpController.text,
                  ));
            } else {
              Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: defaultColor,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
          if (state is VerificationErrorState) {
            print('errorrrrrrrrrrrrrrrrrrrrrr');
            Fluttertoast.showToast(
              msg: 'the otp code is not correct',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: defaultColor,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          return Theme(
            data: ThemeData(
              brightness: Brightness.light,
            ),
            child: Scaffold(
              backgroundColor: Color.fromRGBO(248, 251, 255, 1),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Reset Password',
                        style: lightTheme.textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'A reset code has been sent to your email',
                        style: lightTheme.textTheme.bodyMedium!
                            .copyWith(fontFamily: 'sk'),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Reset Code',
                        style: lightTheme.textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      PinCodeTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter the otp code';
                          }
                          return null;
                        },
                        mainAxisAlignment: MainAxisAlignment.center,
                        keyboardType: TextInputType.number,
                        controller: otpController,
                        appContext: context,
                        length: 4,
                        pinTheme: PinTheme(
                          fieldOuterPadding:
                              EdgeInsets.symmetric(horizontal: 5),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15.0),
                          fieldHeight: 50.0,
                          fieldWidth: 50.0,
                          errorBorderColor: Colors.red,
                          activeFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          activeColor: Color.fromRGBO(249, 136, 31, 1),
                          selectedColor: Colors.black,
                          inactiveColor: Colors.grey,
                        ),
                        onChanged: (value) {
                          // Handle code changes
                        },
                        onCompleted: (value) {
                          // Handle code submission
                        },
                      ),
                      SizedBox(
                        height: 75,
                      ),
                      ConditionalBuilder(
                        condition: state is! VerificationLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                VerificationCubit.get(context).verifyOtp(
                                  otp: otpController.text,
                                  email: email,
                                );
                              }
                            },
                            text: 'reset password',
                          );
                        },
                        fallback: (BuildContext context) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: defaultColor,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
