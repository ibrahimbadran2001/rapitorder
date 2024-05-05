import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/layout/home_layout/home_layout.dart';
import 'package:proj1/layout/login/login_screen.dart';
import 'package:proj1/modules/payment/payment_cubit.dart';
import 'package:proj1/modules/payment/payment_states.dart';
import 'package:proj1/shared/components/components.dart';
import 'package:proj1/shared/style/color.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context)=>PaymentCubit(),
       child: BlocConsumer<PaymentCubit,PaymentStates>(
        listener: (BuildContext context, state) {  },
        builder: ( context,  state) {
          PaymentCubit cubit =PaymentCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Payment',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                        'choose a suitable payment method for you :',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 20,),
                    CarouselSlider(
                      carouselController: cubit.carouselController,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          cubit.setCurrentIndex(index);
                        },
                        height: 200,
                        viewportFraction: 1.0,
                        initialPage: 0,
                      ),
                      items: cubit.imageUrls.map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width/2,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                    image: AssetImage(imageUrl),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                              Icons.arrow_left,
                            size: 50,
                            color: defaultColor,
                          ),
                          onPressed: () {
                            cubit.carouselController.previousPage();
                            cubit.showPayButtonOnLeftClick();
                          },
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width/3,
                            child: Center(
                              child: Text(
                                  cubit.payMethods[cubit.currentIndex],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                        ),
                        IconButton(
                          icon: Icon(
                              Icons.arrow_right,
                            size: 50,
                            color: defaultColor,
                          ),
                          onPressed: () {
                            cubit.carouselController.nextPage();
                            cubit.showPayButtonOnRightClick();
                          }
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Cart Price   : ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Order Fee   : ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Total Price  : ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              ' 40,000',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              ' 5,000',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              ' 45,000',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Visibility(
                      visible: cubit.isPay?true:false,
                      child: defaultButton(
                          onPress: (){
                            if(cubit.currentIndex!=0) {
                            cubit.launchUrl(cubit.linkUrls[cubit.currentIndex]);
                          }
                            },
                          text: 'Pay',
                      ),
                    ),
                    SizedBox(height: 10,),
                    defaultButton(
                      onPress: () {
                        Alert(
                          context: context,
                          type: AlertType.success,
                          style: AlertStyle(
                            isButtonVisible: false,
                            backgroundColor: Theme.of(context).cardColor,
                            alertBorder: Border.all(color: Colors.green,width: 2.0,),
                            titleStyle: Theme.of(context).textTheme.bodyLarge??TextStyle(),
                            descStyle: Theme.of(context).textTheme.bodyMedium??TextStyle(),
                          ),
                          title: 'Place Order',
                          desc: 'your order has been successfully placed',
                        ).show().then((value) => navigateAndFinish(context, HomeLayout()));

                      },
                      text: 'place order',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
