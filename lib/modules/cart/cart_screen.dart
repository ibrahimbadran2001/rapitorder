import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj1/modules/cart/cart_cubit.dart';
import 'package:proj1/modules/cart/cart_states.dart';
import 'package:proj1/modules/drawer/app_drawer.dart';
import 'package:proj1/modules/payment/payment_screen.dart';
import '../../modulesorder.dart';
import '../../shared/components/components.dart';
import '../../list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: TextButton(
                onPressed: (){},
                  child: Text(
                    'Delivery to >',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ),
            ),
            drawer: AppDrawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 30,
                  ),
                  Text(
                      'My Cart',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildCartItem(orders[index], index, context);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: orders.length),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 30,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 26,
                                    ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 3,
                          ),
                          Text(
                            '${CartCubit.get(context).calculateTotalPrice(orders)}\$',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .color,
                                      fontSize: 26,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: defaultButton(
                          onPress: () {navigateTo(context, PaymentScreen());},
                          text: 'Payment Proccess',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildCartItem(Order order, int index, BuildContext context) {
  return Dismissible(
    key: ValueKey(index),
    direction: DismissDirection.startToEnd,
    background: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.0),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(width: 8.0),
          Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    confirmDismiss: (_) async {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this item?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel delete
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirm delete
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
    },
    onDismissed: (_) {
      // // Handle delete action here
      // setState(() {
      // // Remove the item from the list
      // });
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: myBoxShadow(context),
        width: double.infinity,
        height: 102,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/burger.png',
                    ),
                  ),
                ),
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${order.price}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    // Text(
                    //   '${order.price}',
                    //   style: Theme.of(context).textTheme.titleSmall,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              defaultButton(
                onPress: () {
                  CartCubit.get(context).minus(order);
                },
                text: '-',
                width: 40.0,
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${order.count}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              defaultButton(
                onPress: () {
                  CartCubit.get(context).plus(order);
                },
                text: '+',
                width: 40.0,
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
