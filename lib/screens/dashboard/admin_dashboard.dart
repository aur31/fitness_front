import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed("/profile",arguments: context.read<AppSharedPreferences>().user);
              },
              child: CircleAvatar(
                radius: 30,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildHeader(),
                  _sport(),
                  _recette(),
                  _users(),
                  _components(),
                  _encouragement(),
                  _diets(),
                  _guide(),

                  // Add more sections/widgets as needed
                ],
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
