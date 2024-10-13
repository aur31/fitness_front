import 'package:fitness/services/app_colors.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((val)async{
      await context.read<UserViewModel>().getUsers().then((val){
        if(val){

        }
      });
    });
  }

  int femalNumber(UserViewModel userViewModel){
    int number = userViewModel.users.where((element)=>element.sex!.toLowerCase().compareTo("f") == 0).length;
    return number;
  }

  int maleNumber(UserViewModel userViewModel){
    int number = userViewModel.users.where((element)=>element.sex!.toLowerCase().compareTo("m") == 0).length;
    return number;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Admin Dashboard'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed("/profile",arguments: context.read<AppSharedPreferences>().user);
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.person,size: 50,),
              )
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Consumer<UserViewModel>(
                builder: (context,userViewModel,child){
                  return Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/logo.png",width: 100,height: 50,),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed("/view_users");
                                },
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("${userViewModel.users.length}"),
                                          SizedBox(width: 10,),
                                          Icon(Icons.people),
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            Navigator.of(context).pushNamed("/view_users");
                                          },
                                          child: Text("View")
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularPercentIndicator(radius: 40,lineWidth: 8,percent: femalNumber(userViewModel) / userViewModel.users.length,center: Text("${femalNumber(userViewModel)}"),),
                                SizedBox(height: 20,),
                                Text("Females")
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularPercentIndicator(radius: 40,lineWidth: 8,percent: maleNumber(userViewModel) / userViewModel.users.length,center: Text("${maleNumber(userViewModel)}")),
                                SizedBox(height: 20,),
                                Text("Males")
                              ],
                            )
                          ],
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed("/testimonies");
                          },
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(child: Text("Testimonies")),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed("/motivations");
                                },
                                child: Container(
                                  height: 100,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Center(child: Text("Motivations")),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed("/add_user");
                              },
                              child: Container(
                                height: 100,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.primaryColor,
                                ),
                                child: Center(child: Text("Add User")),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue,
      child: Center(
        child: Text(
          'Welcome to Admin Dashboard',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _sport() {
    return Container(
      padding: EdgeInsets.all(16.0),

      child: Card(
        elevation: 3.0,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sport.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Sport Overview',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // Placeholder for charts or other widgets
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recette() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 3.0,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/food.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Recette',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // Placeholder for table or other widgets
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _users() {
    return Container(
      padding: EdgeInsets.all(16.0),

      child: Card(
        elevation: 3.0,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/image12.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Users',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // Placeholder for table or other widgets

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _components() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 3.0,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/food.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Food Components',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // Placeholder for table or other widgets
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _encouragement() {
    return Container(
      padding: EdgeInsets.all(16.0),

      child: Card(
        elevation: 3.0,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage('assets/images/encourage.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Encouragement',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // Placeholder for table or other widgets
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _diets() {
    return Container(
      padding: EdgeInsets.all(16.0),

      child: Card(
        elevation: 3.0,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage('assets/images/diet.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Diets',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // Placeholder for table or other widgets
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _guide() {
    return Container(
      padding: EdgeInsets.all(16.0),

      child: Card(
        elevation: 3.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage('assets/images/guide.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Guide+',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // Placeholder for table or other widgets
              ],
            ),
          ),
        ),
      ),
    );
  }
}
