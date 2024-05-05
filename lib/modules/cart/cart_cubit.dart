import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/list.dart';
import 'package:proj1/modules/cart/cart_states.dart';
import 'package:proj1/modulesorder.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());
  static CartCubit get(context) => BlocProvider.of(context);
  void minus(Order order){
    order.count--;
    if(order.count<=1){
      order.count=1;
    }
    updateOrderPrice(order);
    emit(CartMinusState());
  }
  void plus(Order order){
    order.count++;
    updateOrderPrice(order);
    emit(CartPlusState());
  }
  void updateOrderPrice(Order order) {
    // Assuming order.itemPrice represents the price of a single item
    order.price = order.count * order.itemPrice;
  }
  double calculateTotalPrice(List<Order> orders){
    double total=0;
    for(var x in orders){
      total+=x.price;
    }
    return total;
  }
}