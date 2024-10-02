import 'package:fitness/screens/dashboard/admin/add_motivation.dart';
import 'package:fitness/screens/dashboard/admin/add_user_screen.dart';
import 'package:fitness/screens/dashboard/admin/admin_dashboard.dart';
import 'package:fitness/screens/dashboard/admin/motivations_screen.dart';
import 'package:fitness/screens/dashboard/admin/testimonies.dart';
import 'package:fitness/screens/dashboard/admin/view_users_screen.dart';
import 'package:fitness/screens/dashboard/coach/coach_dashboard.dart';
import 'package:fitness/screens/dashboard/user_dashboard.dart';
import 'package:fitness/screens/home_page.dart';
import 'package:fitness/screens/login_screen.dart';
import 'package:fitness/screens/profile_page.dart';
import 'package:fitness/screens/recette.dart';
import 'package:fitness/screens/register_screen.dart';
import 'package:fitness/screens/success.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:fitness/viewmodel/sport_view_model.dart';
import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>AppSharedPreferences()),
          ChangeNotifierProvider(create: (context)=>SportViewModel()),
          ChangeNotifierProvider(create: (context)=>UserViewModel()),
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
      initialRoute: '/',
      routes: {
        '/': (context) => CoachDashboard(),
        //ADMIN ROUTES
        '/testimonies': (context)=>TestimoniesScreen(),
        '/motivations': (context)=>MotivationScreen(),
        '/add_user': (context)=>AddUserScreen(),
        '/view_users': (context)=>ViewUsersScreen(),
        '/add_motivation': (context)=>AddMotivation(),


        '/login': (context)=>LoginScreen(),
        '/register': (context)=>RegisterScreen(),
        '/user_dash': (context)=>UserDashboard(),
        '/admin_dash': (context)=>AdminDashboard(),
        '/profile': (context)=>ProfilePage(),
        '/recette': (context)=>Recette(),
        '/success': (context)=>Success(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

