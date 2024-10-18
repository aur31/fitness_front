import 'package:fitness/screens/dashboard/user/view_cat_exercise.dart';
import 'package:fitness/viewmodel/sport_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sport extends StatefulWidget {
  const Sport({super.key});

  @override
  State<Sport> createState() => _SportState();
}

class _SportState extends State<Sport> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0)).then((val) async {
      await context.read<SportCategoryViewModel>().getSportCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SportCategoryViewModel>(
        builder: (context, sportCategoryViewModel, child) {
          return Column(
            children: [
              Text("Workouts",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...sportCategoryViewModel
                        .sportCategories
                        .map((cat) {
                      return InkWell(
                        onTap: (){
                          //Navigator.of(context).pushNamed("/view_sport",arguments: cat);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViewCatExercise(cat: cat,)),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                ),
                                child: Text("${cat.name}",style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${cat.description}"),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
