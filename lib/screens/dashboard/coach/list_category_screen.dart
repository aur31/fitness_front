import 'package:fitness/components/loading_indicator.dart';
import 'package:fitness/models/sport_category.dart';
import 'package:fitness/viewmodel/sport_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListeSportCategoryScreen extends StatefulWidget {
  const ListeSportCategoryScreen({super.key});

  @override
  State<ListeSportCategoryScreen> createState() => _ListeSportCategoryScreenState();
}

class _ListeSportCategoryScreenState extends State<ListeSportCategoryScreen> {
  final _searchController = TextEditingController();
  List<SportCategory> suggestions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((val)async{
      await context.read<SportCategoryViewModel>().getSportCategory().then((val){
        if(val){
          suggestions.addAll(context.read<SportCategoryViewModel>().sportCategories);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sport Categories"),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Consumer<SportCategoryViewModel>(
                builder: (context,specialiteViewModel,child){
                  if(specialiteViewModel.sportCategories.length - suggestions.length == 1){
                    suggestions.clear();
                    suggestions.addAll(context.read<SportCategoryViewModel>().sportCategories);
                  }

                  return Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher...',
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          prefixIcon: Icon(Icons.search),
                          //border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          suggestions.clear();
                          suggestions.addAll(specialiteViewModel.sportCategories.where((element)=>element.name!.toLowerCase().contains(value.toLowerCase())));

                          if(value.isEmpty){
                            suggestions.clear();
                            suggestions.addAll(specialiteViewModel.sportCategories);
                          }
                          setState(() {

                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (context,index){
                            return Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              child: ListTile(
                                onTap: (){
                                  //Navigator.of(context).pushNamed("/voir_hopital");
                                },
                                title: Text("${suggestions[index].name}".toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900),),
                                subtitle: Text("${suggestions[index].description}"),
                                trailing: Icon(Icons.update,color: Colors.blue,),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Consumer<SportCategoryViewModel>(
            builder: (context,specialiteViewModel,child){
              return Visibility(
                visible: specialiteViewModel.loadingSportCategories,
                child: LoadingIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}



Future<void> showAddSpecialtyDialog(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _specialiterData = <String, dynamic>{};

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Specialtes',textAlign: TextAlign.center,),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                  ),
                  onSaved: (value) {
                    _specialiterData['titre'] = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez un nom svp';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                  ),
                  onSaved: (value) {
                    _specialiterData['description'] = value;
                  },
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Annuler'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Enregistrer'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Save the specialty data
                // You can access the form field values using the controllers
                // For example: _nameController.text
                //Navigator.of(context).pop();
                print(_specialiterData);

                await context.read<SportCategoryViewModel>().registerSportCategory(context, _specialiterData).then((val){
                  if(val){
                    Navigator.pop(context);
                  }
                });
              }
            },
          ),
        ],
      );
    },
  );
}
