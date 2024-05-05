import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj1/modules/change_password/change_password_cubit.dart';
import 'package:proj1/modules/change_password/change_password_states.dart';
import 'package:proj1/shared/components/components.dart';
import 'package:proj1/modules/home/home_screen.dart';
import 'package:proj1/layout/login/login_screen.dart';
import '../../shared/style/color.dart';
import '../../shared/style/themes.dart';
class ChangePasswordScreen extends StatelessWidget {
  var newPasswordController=TextEditingController();
  var formKey = GlobalKey<FormState>();
  final String email;
  final String otp;
   ChangePasswordScreen({required this.email, required this.otp});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit,ChangePasswordStates>(
        listener: (context, state) {
          if(state is ChangePasswordSuccessState){
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
              navigateAndFinish(context,LoginScreen());
            }
          }
          if(state is ChangePasswordErrorState){
            print('errorrrrrrrrrrrrrrrrrrrrrr');
            Fluttertoast.showToast(
              msg: 'use a strong password at least 8 characters',
              toastLength: Toast.LENGTH_LONG,
              gravity:ToastGravity.BOTTOM ,
              timeInSecForIosWeb: 1,
              backgroundColor: defaultColor,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context,state) {
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
                    children: [
                      SizedBox(height: 50,),
                      Text('Enter your New password',style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk'),),
                      SizedBox(height: 25,),
                      buildTextFormField(
                        controller: newPasswordController,
                        keyboardType: TextInputType.text,
                        label: 'New Password',
                        prefix: Icons.lock,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50,),
                      ConditionalBuilder(
                        condition: state is! ChangePasswordLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                            onPress: (){
                              if (formKey.currentState!.validate()) {
                                ChangePasswordCubit.get(context).changePassword(
                                  email: email,
                                  password: newPasswordController.text,
                                  otp: otp,
                                );
                              }
                            },
                            text: 'change password',
                          );
                        },
                        fallback: (BuildContext context) {
                          return Center(child: CircularProgressIndicator(color: defaultColor,));
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
