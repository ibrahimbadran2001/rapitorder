import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proj1/modules/orders/order_states.dart';
import 'package:proj1/shared/style/color.dart';
import '../../list.dart';
import '../../shared/components/components.dart';
import '../cart/cart_screen.dart';
import '../drawer/app_drawer.dart';
import 'order_cubit.dart';

class OrdersScreen extends StatelessWidget {
      OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) => {},
          builder: (context, state) {
            OrderCubit cubit = BlocProvider.of(context);
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Orders',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              drawer: AppDrawer(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildToggleContainer(
                            context: context,
                            text: '${cubit.status[index]}',
                            theme: Theme.of(context).textTheme.bodyMedium,
                            onPress: () {
                              cubit.setSelectedIndex(index);
                            },
                            color: cubit.containerColors[index],
                            borderColor: cubit.borderColors[index],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        itemCount: cubit.status.length,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 25,
                    ),
                    Expanded(
                      child: buildOrdersList(cubit.status[cubit.selectedIndex]),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 25,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  ListView buildOrdersList(String type) {
    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index){
                       return buildOrder(context,type);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: 10,
                    );
  }

  Widget buildOrder(BuildContext context,String type) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: myBoxShadow(context),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        type,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Restaurant Name',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    '11:25 AM',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Text('11-4-2024',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 10,
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                     // barrierColor:  ,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              Text(
                                'order id : 1d34ced44dddddddddddddddddddbbbbbbbb',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Price : ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    ' 2500.0\$',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        '5:39 PM ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Text(
                                        '20-4-2024',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          content: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            height: MediaQuery.sizeOf(context).height/2,
                            width: MediaQuery.sizeOf(context).width,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 90,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration:BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: defaultColor,
                                                  ),
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                ),
                                                width: 30,
                                                height: 30,
                                                child: Center(
                                                  child: Text(
                                                    '${index+1}',
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15.0,),
                                              Expanded(
                                                child: Text(
                                                  'Food NameFood NameFood Name',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '54',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                              Text(
                                                '20000.0\$',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return myDivider();
                              },
                              itemCount: orders.length,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(0)),
                  ),
                  child: Text(
                    'see cart >>',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontFamily: 'sk',
                          color: Color.fromRGBO(249, 136, 31, 1),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget Count2() {
  return Container(
    height: 1,
    width: 130,
    color: Colors.black,
  );
}

Widget itembiulder(int index, BuildContext context) {
  return Dismissible(
    key: ValueKey(index),
    direction: DismissDirection.startToEnd,
    background: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.deepOrange),
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
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(20, 40, 40, 1),
      ),
      width: double.infinity,
      height: 102,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              height: 70,
              width: 70,
              // child: ImageIcon(NetworkImage("")),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'naaaaa',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'name',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '10',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "20",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
