import 'package:flutter/material.dart';
import 'package:personal_credential_storage/screens/app_login_screen.dart';
import 'package:personal_credential_storage/screens/personal_details_screen.dart';
import 'screens/home.dart';
void main() {
  runApp(const MyApp());
}
 class MyApp extends StatelessWidget {
   const MyApp({super.key});
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       initialRoute: '/',
         routes: {
         '/': (context) => const HomePage(),
           '/personalDetails' : (context) => const PersonalDetailsScreen(),
           '/appLogins' : (context) => const AppLoginScreen(),

         },
       //home: HomePage(),
     );
   }
 }
 
