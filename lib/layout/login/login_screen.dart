import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proj1/layout/login/login_cubit.dart';
import 'package:proj1/modules/forget_password/forgoet_password_screen.dart';
import 'package:proj1/modules/home/home_screen.dart';
import 'package:proj1/modules/register/register_screen.dart';
import 'package:proj1/shared/components/constants.dart';
import 'package:proj1/shared/network/local/cache_helper.dart';
import 'package:proj1/shared/style/color.dart';
import '../../shared/components/components.dart';
import '../../shared/style/themes.dart';
import '../home_layout/home_layout.dart';
import 'login_states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
         create: (context)=>LoginCubit(),
       child: BlocConsumer<LoginCubit,LoginStates>(
         listener: (BuildContext context, state) {
           if(state is CustomerLoginSuccessState){
             if(state.model.status){
               print(state.model.status);
               CacheHelper.saveData(key: 'token', value: state.model.data.token).then(
                       (value) => {
                         token=state.model.data.token,
                     navigateAndFinish(context,HomeLayout()),
                   });
               Fluttertoast.showToast(
                 msg: state.model.message,
                 toastLength: Toast.LENGTH_LONG,
                 gravity:ToastGravity.BOTTOM ,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.green,
                 textColor: Colors.white,
                 fontSize: 16.0,
               );
               navigateAndFinish(context,HomeLayout());
             }
             else{
               print('falsssssssse');
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
           if(state is CustomerLoginErrorState){
             print('errrrrrrrrrror');
           }
         },
         builder: (BuildContext context, Object? state)
         {
           LoginCubit cubit=BlocProvider.of(context);
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
                               'Login to your account ',
                               style: lightTheme.textTheme.bodyLarge,
                             ),
                             SizedBox(
                               height: 20.0,
                             ),
                             Text(
                               'Good to see you again ,',
                               style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk'),
                             ),
                             SizedBox(
                               height: 10,
                             ),
                             Text(
                               'Enter your details below to continue ordering',
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
                                 return 'password must not be empty';
                               }
                               return null;
                             },
                             controller: passwordController,
                             keyboardType:TextInputType.visiblePassword,
                             label: 'Password',
                             prefix: Icons.lock,
                             secure: cubit.isPass ? false:true,
                             suffix:cubit.isPass ? Icons.visibility:Icons.visibility_off,
                           onSuffixPressed: (){
                             cubit.changePassIcon();
                           }
                         ),
                         Row(
                           children: [
                             Spacer(),
                             Padding(
                               padding: const EdgeInsets.only(right: 13.7, ),
                               child: TextButton(
                                 onPressed: () {
                                   navigateTo(context, ForgetPasswordScreen());
                                 },
                                 style: ButtonStyle(
                                   overlayColor: MaterialStateProperty.all<Color>(
                                       Color.fromRGBO(249, 136, 31, 200)),
                                 ),
                                 child: Text(
                                   'Forget Password?',
                                   style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk',color: Color.fromRGBO(249, 136, 31, 1),),
                                 ),
                               ),
                             ),
                           ],
                         ),
                         SizedBox(height: 20.0,),
                         ConditionalBuilder(
                           condition: state is! CustomerLoginLoadingState,
                           builder: (BuildContext context) {
                             return defaultButton(
                                 onPress: () {
                                   if (formKey.currentState!.validate()) {
                                     cubit.userLogin(email: emailController.text, password: passwordController.text);
                                   }
                                 },
                                 width: double.infinity,
                                 bgColor: Colors.blue,
                                 text: 'login',
                             );
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
                               "You don't have an account ?",
                               style: lightTheme.textTheme.bodyMedium!.copyWith(fontFamily: 'sk',),
                             ),
                             TextButton(
                               onPressed: () {
                                 navigateAndFinish(context, RegisterScreen());
                               },
                               style: ButtonStyle(
                                 overlayColor: MaterialStateProperty.all<Color>(
                                     Color.fromRGBO(249, 136, 31, 200)),
                               ),
                               child: Text(
                                 'Register now',
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
       ),
     );
  }
}
