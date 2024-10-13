import 'package:fitness/components/loading_indicator.dart';
import 'package:fitness/viewmodel/encouragement_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({super.key});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((val)async{
      await context.read<EncouragementViewModel>().getEncouragement().then((val){
        if(val){

        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Motivations"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/add_motivation");
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<EncouragementViewModel>(
          builder: (context,encouragementViewModel,child){
            return Stack(
              children: [
                ListView.builder(
                  itemCount: encouragementViewModel.encouragements.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.primaries[index % Colors.primaries.length])
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 20,
                          height: 70,
                          color: Colors.primaries[index % Colors.primaries.length],
                          child: Center(child: Text("$index")),
                        ),
                        title: Container(
                          margin: EdgeInsets.only(left: 10),
                          //color: Colors.primaries[index % Colors.primaries.length],
                          child: Text("${encouragementViewModel.encouragements[index].encouragement}"),
                        ),
                      ),
                    );
                  },
                ),
                Visibility(
                  visible: encouragementViewModel.loadingEncouragement,
                  child: LoadingIndicator()
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
