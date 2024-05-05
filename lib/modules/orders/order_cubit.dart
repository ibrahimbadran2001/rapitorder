import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/orders/order_states.dart';
import 'package:proj1/shared/style/color.dart';
class OrderCubit extends Cubit<OrderStates>{
  OrderCubit ()  : super(OrderInitialState());
  static OrderCubit get(context) => BlocProvider.of(context);
  List<Color> borderColors=[Colors.green,defaultColor,defaultColor];
  List<Color> containerColors=[transGreen,Colors.transparent,Colors.transparent];
  // void changeToPending( BuildContext context){
  //   if(!isPending){
  //     isPending=!isPending;
  //     selectedContainerColor=Theme.of(context).cardColor;
  //     unselectedContainerColor=Color.fromRGBO(150, 255, 100,0.3);
  //     selectedBorderColor=Color.fromRGBO(249, 136, 31, 1);
  //     unselectedBorderColor=Colors.green;
  //     print('2222222222');
  //     print(isPending);
  //     emit(OrderPaindingChangeState());
  //   }
  // }
  // void changeToComplete( BuildContext context){
  //   if(isPending){
  //     isPending=!isPending;
  //     selectedContainerColor=Color.fromRGBO(150, 255, 100,0.3);
  //     unselectedContainerColor=Theme.of(context).cardColor;
  //     selectedBorderColor=Colors.green;
  //     unselectedBorderColor=Color.fromRGBO(249, 136, 31, 1);
  //     print('11111111');
  //     print(isPending);
  //     emit(OrderCompleteChangeState());
  //   }
  // }
  List<String>status=['pending','confirmed','complete'];
  int selectedIndex = 0;
  void setSelectedIndex(int index){
    selectedIndex = index;
    changeColors(selectedIndex);
    emit(OrderStatusChangeState());
  }
  void changeColors(int index){
    if(index==1){
    borderColors[1]=Colors.green;
    borderColors[0]=defaultColor;
    borderColors[2]=defaultColor;
    containerColors[1]=transGreen;
    containerColors[0]=Colors.transparent;
    containerColors[2]=Colors.transparent;
    }
    else if(index==2){
      borderColors[2]=Colors.green;
      borderColors[1]=defaultColor;
      borderColors[0]=defaultColor;
      containerColors[2]=transGreen;
      containerColors[0]=Colors.transparent;
      containerColors[1]=Colors.transparent;
    }
    else{
      borderColors[0]=Colors.green;
      borderColors[1]=defaultColor;
      borderColors[2]=defaultColor;
      containerColors[0]=transGreen;
      containerColors[1]=Colors.transparent;
      containerColors[2]=Colors.transparent;
    }
  }
}