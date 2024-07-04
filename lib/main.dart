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
import 'package:fitness/screens/dashboard/admin_dashboard.dart';
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
        '/': (context) => HomePage(),
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

