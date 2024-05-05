import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj1/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              onChanged: (value) {
               // NewsCubit.get(context).getSearch(value);
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  border: OutlineInputBorder()),
            ),
          ),
             Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>Container(),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: myDivider(),
              ),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
