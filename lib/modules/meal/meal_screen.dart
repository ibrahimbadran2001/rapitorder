import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/components/components.dart';
class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Center(child: Text('Delivery To',style: TextStyle(fontSize: 20,fontFamily: 'sk'),)),
        actions:
        [
          IconButton(onPressed: (){}, icon: Icon(Icons.person_pin,size: 30,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/burger.png',
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height/30,),
              Text(
                ' boys cheese burger Resameboys cheese burger Resameboys cheese burger Res boys cheese burger Resameboys cheese burger Resameboys cheese burger Res boys cheese burger Resameboys cheese burger Resameboys cheese burger Res boys cheese burger Resameboys cheese burger Resameboys cheese burger Res boys cheese burger Resameboys cheese burger Resameboys cheese burger Res boys cheese burger Resameboys cheese burger Resameboys cheese burger Res ',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.center,
                style:
                Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height/60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Icon(FontAwesomeIcons.solidStar,size: 12,color: Colors.deepOrange[400],),
                  SizedBox(
                    width: 10,
                  ),
                  Text('+4',style: TextStyle(fontFamily: 'sk',fontSize: 10),),
                  SizedBox(
                    width: 30,
                  ),
                  Text('🔥'),
                  SizedBox(
                    width: 5,
                  ),
                  Text('+300cal',style: TextStyle(fontFamily: 'sk',fontSize: 10),),
                  SizedBox(
                    width: 30,
                  ),
                  Text('⏰'),
                  SizedBox(
                    width: 5,
                  ),
                  Text('5-10 min',style: TextStyle(fontFamily: 'sk',fontSize: 10),),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height/30,),
              Text(
                'Our simple, classic cheeseburger begins r is topped riptiot DescriptionResturantThe McDonald’s Cheeseburger is topped riptiot DescriptionResturantThe McDtOur simple, classic cheeseburger begins r is topped riptiot DescriptionResturantThe McDonald’s Cheeseburger is topped riptiot DescriptionResturantThe McDtsimple, classic cheeseburger begins r is topped riptiot DescriptionResturantThe McDonald’s Cheeseburger is topped riptiot DescriptionResturantThe McDtOur simple, classic cheeseburger begins r is topped riptiot DescriptionResturantThe McDonald’s Cheeseburger is topped riptiot DescriptionResturantThe McDt ',
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
                style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: 'sk'),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height/12,),
              defaultButton(
                onPress: () {  },
                text: 'Add to favorite',
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height/40,),
              defaultButton(
                onPress: () {  },
                text: 'Add to Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
