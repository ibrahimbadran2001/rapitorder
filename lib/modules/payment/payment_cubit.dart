import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/payment/payment_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/style/color.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitialState());
  static PaymentCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  CarouselController carouselController=CarouselController();
  void setCurrentIndex(int index){
    currentIndex = index;
    emit(PaymentStatusChangeState());
  }
  final List<String> imageUrls = [
    'assets/images/cash-in-hand.png',
    'assets/images/syriatel.png',
    'assets/images/mtn.png',
  ];
  final List<String> linkUrls = [
    'https://example.com/link3',
    'https://example.com/link2',
    'https://www.mtnsyr.com/',
  ];
  final List<String> payMethods = [
    'Cash',
    'Syriatel Cash',
    'MTN Cash Mobile',
  ];
  bool isPay=false;
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void showPayButtonOnRightClick(){
    if(currentIndex==0||currentIndex==1){
      isPay=true;
    }
    if(currentIndex==2){
      isPay=false;
    }
    print(isPay);
  }
  void showPayButtonOnLeftClick(){
    if(currentIndex==0){
      isPay=true;
    }
    if(currentIndex==1){
      isPay=false;
    }
    print(isPay);
  }
}