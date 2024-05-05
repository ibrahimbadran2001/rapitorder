import 'package:flutter/material.dart';
import 'package:proj1/modules/restaurant/restaurants_cubit.dart';

import '../style/color.dart';
void navigateAndFinish(context,widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>widget),
            (route) => false);

void navigateTo(BuildContext context,widget) =>
    Navigator.push(
      context,
      MaterialPageRoute(
          builder:(context)=>widget
      ),
    );

Widget defaultButton({
  required  Function() onPress,
  double width=double.infinity,
  double height=50,
  List<Color> gradientColors = const [Color.fromRGBO(249, 136, 31, 1), Color.fromRGBO(255, 119, 76, 1)],
  Color bgColor=Colors.blue,
  required String text,
  double radius = 20.0,
})=>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(radius)
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
        ),
      ),
    );

Widget buildTextFormField(
    {
      required TextEditingController controller,
      required TextInputType keyboardType,
      required String label,
      required IconData prefix,
      bool secure=false,
      IconData ? suffix,
      String? Function(String?)? validate,
      double radius=15.0,
      Function()? onSuffixPressed,
      Color labelColor=  Colors.grey,
      Color enableBorderColor= const Color.fromRGBO(223, 226, 229, 1),
      Color focusBorderColor= const Color.fromRGBO(249, 136, 31, 1),
    }) {
  return TextFormField(
    cursorColor: Colors.grey[50],
    validator: validate,
    obscureText: secure,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color:labelColor, fontFamily: 'sk',fontSize: 16.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color:enableBorderColor),
      ),
        errorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.black),
        ) ,
        focusedErrorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.black),
        ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: focusBorderColor),
      ),
      prefixIcon: Icon(prefix),
      suffixIcon: suffix !=null ? IconButton(icon: Icon(suffix),
        onPressed: onSuffixPressed,
      ):null,
    ),
  );
}
Container myDivider({double width=double.infinity,double height=0.5}) {
  return Container(
    width: width,
    height: height,
    color: Colors.grey[400],
  );
}
BoxDecoration myBoxShadow(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).cardColor,
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).shadowColor,
        //color: 3// Shadow color
        spreadRadius: 2, // Spread radius
        blurRadius: 3, // Blur radius
        offset: Offset(0, 3), // Offset in x and y directions
      ),
    ],
    borderRadius: BorderRadius.circular(10),
    //color: Colors.white,
  );
}
Widget buildToggleContainer(
    {required BuildContext context,
      required String text,
      required Function() onPress,
      required Color color,
      TextStyle? theme,
      Color? borderColor}) {
  return Container(
    height: 40,
    width: MediaQuery.sizeOf(context).width / 3,
    decoration: BoxDecoration(
      border: Border.all(color: borderColor ?? Colors.transparent),
      borderRadius: BorderRadius.circular(20),
      color: color,
    ),
    child: TextButton(
      onPressed: onPress,
      child: Text(
        text,
        style: theme,
      ),
    ),
  );
}
Future<void> showFavoriteDialog({context,int? index}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(Icons.favorite,color: defaultColor,size: 40,),
        title: Text(
          'Add To Favorite',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        content: Text(
          'Are you sure you want to add this item?',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel delete
            },
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: defaultColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              RestaurantCubit.get(context).moveNews(index!);
              Navigator.of(context).pop(true); // Confirm delete
            },
            child: Text(
              'add',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: defaultColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
Widget buildListItemItem(
    { required BuildContext context, required Function() onPress, String? image, String? text1, String? text2, IconData? icon1, IconData? icon2, favVisible = false,}) {
  return Container(
    height: 100,
    width: double.infinity,
    decoration: myBoxShadow(context),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 125,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                '${image}',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '$text1',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),

                Text(
                  '$text2',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                visible: favVisible,
                child: TextButton(
                  onPressed: () async {
                    return await showFavoriteDialog(context: context,);
                  },
                  child: Text(
                    'add to favorite',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(
                        color: defaultColor
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onPress,
                icon: Icon(
                  icon2,
                  color: defaultColor,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

AppBar buildAppBarForm() {
  return AppBar(
    elevation: 0.0,
    surfaceTintColor: Color.fromRGBO(248, 251, 255, 1),
    title: Image(image: AssetImage('assets/images/Icon.png')),
    centerTitle: true,
    backgroundColor: Color.fromRGBO(248, 251, 255, 1),
  );
}