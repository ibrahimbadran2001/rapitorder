import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj1/modules/forget_password/forget_password_cubit.dart';
import 'package:proj1/modules/forget_password/forget_password_states.dart';
import 'package:proj1/shared/components/components.dart';
import 'package:proj1/modules/verification/verfication_screen.dart';

import '../../shared/style/color.dart';
import '../../shared/style/themes.dart';
class ForgetPasswordScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit,ForgetPasswordStates>(
        listener: (context, state) {
          if(state is ForgetPasswordSuccessState){
            if(state.model.status){
              Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity:ToastGravity.BOTTOM ,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              navigateAndFinish(context,VerificationScreen(email: emailController.text,));
            }
            else{
              Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity:ToastGravity.BOTTOM ,
                timeInSecForIosWeb: 1,
                backgroundColor: defaultColor,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
          if(state is ForgetPasswordErrorState){
            print('errorrrrrrrrrrrrrrrrrrrrrr');
            Fluttertoast.showToast(
              msg: "Enter a valid email address.",
              toastLength: Toast.LENGTH_LONG,
              gravity:ToastGravity.BOTTOM ,
              timeInSecForIosWeb: 1,
              backgroundColor: defaultColor,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context,state){
          return  Theme(
            data: ThemeData(
              brightness: Brightness.light,
            ),
            child: Scaffold(
              backgroundColor: Color.fromRGBO(248, 251, 255, 1),
              appBar: buildAppBarForm(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Forgot password',
                              style: lightTheme.textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Enter your email address to request a password reset.',
                                textAlign: TextAlign.center,
                                style:  lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        buildTextFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ForgetPasswordLoadingState,
                          builder: (BuildContext context) {
                            return defaultButton(
                                onPress: () {
                                   if (formKey.currentState!.validate()) {
                                     ForgetPasswordCubit.get(context).senOtp(email: emailController.text);
                                   }
                                },
                                width: double.infinity,
                                bgColor: Colors.blue,
                                text: 'Send');
                          },
                          fallback: (BuildContext context) {
                            return Center(child: CircularProgressIndicator(color: defaultColor,));
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
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
