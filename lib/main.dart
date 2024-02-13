import 'package:flutter/material.dart';
import 'package:lulu/screens/screens.dart';

import 'package:lulu/services.dart/post_service.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';


void main() => runApp(AppState());

class AppState extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _)=> PostService())
      ],
      child: MyApp(),
      );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social media',
      initialRoute:'login',
      routes: {
        'login' : ( _) => LoginScreen(),
        'home'  : (_) => HomeScreen()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 189, 185, 185),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color:  Color.fromARGB(255, 228, 143, 47)
      ),
      
      )
    );
  }
  }
