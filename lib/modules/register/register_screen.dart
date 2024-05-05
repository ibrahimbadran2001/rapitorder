import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj1/layout/login/login_screen.dart';
import 'package:proj1/modules/register/register_cubit.dart';
import 'package:proj1/modules/register/register_states.dart';
import 'package:proj1/shared/style/themes.dart';

import '../../layout/home_layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/style/color.dart';
class RegisterScreen extends StatelessWidget {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController=TextEditingController();
  var userType='customer';
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (context)=>RegisterCubit(),
       child: BlocConsumer<RegisterCubit,RegisterStates>(
         listener: (context,state){
           if(state is RegisterSuccessState){
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
           if(state is RegisterErrorState){
             print('errorrrrrrrrrrrrrrrrrrrrrr');
             Fluttertoast.showToast(
               msg: 'you can\'t register using these credentials',
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
           return Theme(
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
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             SizedBox(
                               height: 40,
                             ),
                             Text(
                               'Create an account ',
                               style: lightTheme.textTheme.bodyLarge,
                             ),
                             SizedBox(
                               height: 20.0,
                             ),
                             Text(
                               'Welcome, enter your details so lets get',
                               style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk'),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Text(
                               'started in ordering food.',
                               style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk'),
                             ),
                           ],
                         ),
                         SizedBox(
                           height: 50,
                         ),
                         buildTextFormField(
                           validate: (value) {
                             if (value!.isEmpty) {
                               return 'full name must not be empty';
                             }
                             return null;
                           },
                           controller: fullNameController,
                           keyboardType: TextInputType.text,
                           label: 'Full Name',
                           prefix: Icons.person_2,
                         ),
                         SizedBox(
                           height: 15,
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
                           height: 15,
                         ),
                         buildTextFormField(
                           validate: (value) {
                             if (value!.isEmpty) {
                               return 'phone number is required';
                             }
                             return null;
                           },
                           controller: phoneController,
                           keyboardType: TextInputType.phone,
                           label: 'phone',
                           prefix: Icons.phone_android,
                         ),
                         SizedBox(
                           height: 15,
                         ),
                         buildTextFormField(
                             validate: (value) {
                               if (value!.isEmpty) {
                                 return 'password must not be empty';
                               }
                               return null;
                             },
                             controller: passwordController,
                             keyboardType: TextInputType.visiblePassword,
                             label: 'Password',
                             prefix: Icons.lock,
                             secure: true,
                             suffix: Icons.visibility),
                         SizedBox(
                           height: 15,
                         ),
                         buildTextFormField(
                             validate: (value) {
                               if (value!.isEmpty) {
                                 return 'confirm password must not be empty';
                               }
                               return null;
                             },
                             controller: confirmPasswordController,
                             keyboardType: TextInputType.visiblePassword,
                             label: 'Confirm password',
                             prefix: Icons.security,
                             secure: true,
                             suffix: Icons.visibility),
                         SizedBox(
                           height: 40.0,
                         ),
                         ConditionalBuilder(
                           condition: state is! RegisterLoadingState,
                           builder: (BuildContext context) {
                             return defaultButton(
                                 onPress: () {
                                   if (formKey.currentState!.validate()) {
                                     RegisterCubit.get(context).userRegister(
                                         fullName: fullNameController.text,
                                         email: emailController.text,
                                         phone: phoneController.text,
                                         password: passwordController.text,
                                         confirmPassword: confirmPasswordController.text,
                                         userType: userType,
                                         username: emailController.text+fullNameController.text,
                                     );
                                   }
                                 },
                                 width: double.infinity,
                                 bgColor: Colors.blue,
                                 text: 'register');
                           },
                           fallback: (BuildContext context) {
                             return Center(child: CircularProgressIndicator(color: defaultColor,));
                           },
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "You have an account ?",
                               style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk'),
                             ),
                             TextButton(
                               onPressed: () {
                                 navigateAndFinish(context, LoginScreen());
                               },
                               style: ButtonStyle(
                                 overlayColor: MaterialStateProperty.all<Color>(
                                     Color.fromRGBO(249, 136, 31, 200)),
                               ),
                               child: Text(
                                 'Login',
                                 style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk',color: Color.fromRGBO(249, 136, 31, 1),),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
         },
       )
     );
  }
}

