import 'package:fitness/screens/dashboard/admin/add_motivation.dart';
import 'package:fitness/screens/dashboard/admin/add_user_screen.dart';
import 'package:fitness/screens/dashboard/admin/admin_dashboard.dart';
import 'package:fitness/screens/dashboard/admin/motivations_screen.dart';
import 'package:fitness/screens/dashboard/admin/testimonies.dart';
import 'package:fitness/screens/dashboard/admin/view_users_screen.dart';
import 'package:fitness/screens/dashboard/coach/coach_dashboard.dart';
import 'package:fitness/screens/dashboard/coach/list_category_screen.dart';
import 'package:fitness/screens/dashboard/user/user_dashboard.dart';
import 'package:fitness/screens/home_page.dart';
import 'package:fitness/screens/login_screen.dart';
import 'package:fitness/screens/profile_page.dart';
import 'package:fitness/screens/recette.dart';
import 'package:fitness/screens/register_screen.dart';
import 'package:fitness/screens/success.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:fitness/viewmodel/exercise_view_model.dart';
import 'package:fitness/viewmodel/sport_view_model.dart';
import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/dashboard/user/view_cat_exercise.dart';
import 'viewmodel/encouragement_view_model.dart';
import 'viewmodel/sport_category_view_model.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>AppSharedPreferences()),
          ChangeNotifierProvider(create: (context)=>SportViewModel()),
          ChangeNotifierProvider(create: (context)=>UserViewModel()),
          ChangeNotifierProvider(create: (context)=>EncouragementViewModel()),
          ChangeNotifierProvider(create: (context)=>SportCategoryViewModel()),
          ChangeNotifierProvider(create: (context)=>ExerciseViewModel()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        //ADMIN ROUTES
        '/testimonies': (context)=>TestimoniesScreen(),
        '/motivations': (context)=>MotivationScreen(),
        '/add_user': (context)=>UserForm(),
        '/view_users': (context)=>ViewUsersScreen(),
        '/add_motivation': (context)=>AddMotivation(),


        '/login': (context)=>LoginScreen(),
        '/register': (context)=>RegisterScreen(),
        '/user_dash': (context)=>UserDashboard(),
        '/admin_dash': (context)=>AdminDashboard(),
        '/profile': (context)=>ProfilePage(),
        '/recette': (context)=>Recette(),
        '/success': (context)=>Success(),

        //COACHE
        '/liste_sport_cat': (context)=>ListeSportCategoryScreen(),

        //EMPLOYEE

      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

