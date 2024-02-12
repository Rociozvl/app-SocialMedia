import 'package:flutter/material.dart';

import 'package:lulu/services.dart/post_service.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {runApp(MyApp());}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social media',
      
      home: ChangeNotifierProvider(
        create: (context) => PostService(),
        child: HomeScreen(),
      ),
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
