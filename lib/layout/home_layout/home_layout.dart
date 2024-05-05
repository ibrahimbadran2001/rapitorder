import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proj1/layout/home_layout/states.dart';
import 'package:proj1/list.dart';
import 'package:proj1/modules/restaurant/restaurants_cubit.dart';
import '../../shared/style/color.dart';
import 'cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: cubit.Screen[cubit.currentindex],
          bottomNavigationBar: ConvexAppBar(
            top: -20,
            height: MediaQuery.sizeOf(context).height/14,
           backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor ,
            color:  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            activeColor: Color.fromRGBO(150, 255, 100,0.2),
            initialActiveIndex: cubit.currentindex,
            onTap: (index) {
              cubit.setcurrenetindex(index);
            },
            items: [
              buildTabItem(
                  context: context,
                  unselectedIcon: Icons.home_outlined,
                  selectedIcon: Icons.home,
              ),
              buildTabItem(
                  context: context,
                  unselectedIcon: Icons.playlist_add_check_circle_outlined,
                  selectedIcon: Icons.playlist_add_check_circle,
              ),
              buildTabItem(
                  context: context,
                  unselectedIcon: Icons.shopping_cart_outlined,
                  selectedIcon: Icons.shopping_cart,
              ),
              buildTabItem(
                  context: context,
                unselectedIcon: Icons.location_on_outlined,
                selectedIcon: Icons.location_on,
              ),
              buildTabItem(
                  context: context,
                  unselectedIcon: Icons.favorite_border,
                  selectedIcon: Icons.favorite,
              ),
            ],
          ),
        );
      },
    );
  }

  TabItem<dynamic> buildTabItem({required BuildContext context,required IconData selectedIcon,required IconData unselectedIcon, String ? label}) {
    return TabItem(
                  activeIcon:Icon(
                    selectedIcon,
                  color: Color.fromRGBO(255, 119, 76, 1),
                ),
                  icon: Icon(
                    unselectedIcon,
                    color: defaultColor,
                  ),
                  fontFamily: 'lato',
                  title: label,
                );
  }
}
// bottomNavigationBar: Container(
//   padding: EdgeInsets.all(0),
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [Color.fromRGBO(249, 136, 31, 1), Color.fromRGBO(255, 119, 76, 1),],
//         begin: Alignment.centerLeft,
//         end: Alignment.centerRight,
//       ),
//     ),
//   child: BottomNavigationBar(
//     backgroundColor:Colors.transparent,
//       currentIndex: cubit.currentindex,


//   ),
// ),
