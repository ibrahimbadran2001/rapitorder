import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proj1/layout/home_layout/cubit.dart';
import 'package:proj1/layout/login/login_screen.dart';
import 'package:proj1/modules/profile/profile_screen.dart';
import 'package:proj1/shared/style/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../main.dart';
import '../../shared/components/components.dart';
class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}
class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Theme.of(context).scaffoldBackgroundColor),
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/iconIm.png'),
              ),
            ),
            buildDrawerItem(icon: Icons.person_2_outlined, label: 'Profile', context: context,
                onPress: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      icon: Icon(
                          Icons.person,
                        color: defaultColor,
                        size: 30,
                      ),
                      title: Text(
                          'Personal Information',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      content: Container(
                        height: MediaQuery.sizeOf(context).height/2,
                        width: MediaQuery.sizeOf(context).width/1.5,
                        child: ProfileScreen(),
                      ),
                    );
                  }
              );
            }),
            myDivider(),
            buildDrawerItem(
                icon: AppCubit.get(context).isDark ? Icons.dark_mode_outlined:Icons.light_mode_outlined,
                label: 'Mode',
                context: context,
                suffixIcon: AppCubit.get(context).isDark ? Icons.toggle_on_outlined:Icons.toggle_off_outlined,
                onSuffixPress: (){
                  setState(() {
                    AppCubit.get(context).changeAppMode();
                  });
                }
            ),
            myDivider(),
            buildDrawerItem(icon: Icons.help_outline, label: 'Help', context: context,onPress: (){}),
            myDivider(),
            buildDrawerItem(icon: Icons.attach_email_outlined, label: 'Contact Us', context: context,
                onPress: () async {
                  final Uri params = Uri(
                    scheme: 'mailto',
                    path: 'ibrahimbadran518@gmail.com',
                    query: 'subject=Hello from TIMY',
                  );

                  if (await canLaunchUrl(params)) {
                    await launchUrl(params);
                  } else {
                    throw 'Could not launch $params';
                  }
                },),
            myDivider(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: defaultButton(
                  text: 'Log out',
                  width: double.infinity,
                  onPress: (){
                  },
              ),
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Follow us on social media',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        const String facebookUrl =
                            'https://www.facebook.com/'; // Replace this with your URL.
                        const String facebookScheme =
                            'fb://'; // Custom scheme URL for the Facebook app.

                        try {
                          if (await canLaunchUrlString(facebookScheme)) {
                            // Launch the URL in the Facebook app.
                            await launch(
                              facebookScheme +
                                  'facewebmodal/f?href=' +
                                  facebookUrl,
                              forceSafariVC: false,
                              forceWebView: false,
                            );
                          } else {
                            // The Facebook app is not installed. Launch the URL in the browser.
                            await launch(
                              facebookUrl,
                              forceSafariVC: false,
                              forceWebView: false,
                            );
                          }
                        } on PlatformException catch (e) {
                          // Handle errors that occur when trying to open the URL.
                          print('Error: ${e.message}');
                        }
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          const String instagramUrl =
                              'https://www.instagram.com/'; // Replace this with your URL.
                          const String instagramScheme =
                              'instagram://'; // Custom scheme URL for the Instagram app.
                          try {
                            if (await canLaunch(instagramScheme)) {
                              // Launch the URL in the Instagram app.
                              await launch(
                                instagramScheme +
                                    'user?username=' +
                                    instagramUrl.substring(26),
                                forceSafariVC: false,
                                forceWebView: false,
                              );
                            } else {
                              // The Instagram app is not installed. Launch the URL in the browser.
                              await launch(
                                instagramUrl,
                                forceSafariVC: false,
                                forceWebView: false,
                              );
                            }
                          } on PlatformException catch (e) {
                            // Handle errors that occur when trying to open the URL.
                            print('Error: ${e.message}');
                          }
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.grey,
                          size: 35,
                        )),
                    IconButton(
                        onPressed: () async {
                          final String telegramUrl =
                              'https://t.me/'; // Replace this with your URL.
                          final String telegramScheme =
                              'tg://'; // Custom scheme URL for the Telegram app.

                          try {
                            if (await canLaunch(telegramScheme)) {
                              // Launch the URL in the Telegram app.
                              await launch(
                                telegramScheme +
                                    'resolve?domain=' +
                                    telegramUrl.substring(6),
                                forceSafariVC: false,
                                forceWebView: false,
                              );
                            } else {
                              // The Telegram app is not installed. Launch the URL in the browser.
                              await launch(
                                telegramUrl,
                                forceSafariVC: false,
                                forceWebView: false,
                              );
                            }
                          } on PlatformException catch (e) {
                            // Handle errors that occur when trying to open the URL.
                            print('Error: ${e.message}');
                          }
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.telegram,
                          color: Colors.grey,
                          size: 35,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Expanded buildDrawerItem({required context,required IconData icon , required String label,Function() ?onPress,Function() ?onSuffixPress,IconData ? suffixIcon}) {
  return Expanded(
    child: TextButton(
      onPressed: onPress,
      child: Row(
        children:
        [
          Icon(icon,size: 30,color:Color.fromRGBO(250, 100, 31, 1),),
          SizedBox(width: 15,),
          Text(label,style: Theme.of(context).textTheme.bodyMedium,),
          Spacer(),
          IconButton(
              onPressed:onSuffixPress,
              icon: Icon(
                suffixIcon,
                size: 30,
                color:Color.fromRGBO(250, 100, 31, 1),
              ),
          ),
        ],
      ),
    ),
  );
}