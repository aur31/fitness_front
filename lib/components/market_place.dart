import 'package:flutter/material.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Market Place",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Container(
                    height: 100,
                    width: 100,
                    child: Card(
                      child: Text("fdfdf"),
                    ),
                  ),
                  title: Text("Name of Product"),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("description"),
                      Text("https://")
                    ],
                  ),
                )
              ]
            ),
          ),
        ],
      )
    );
  }
}
