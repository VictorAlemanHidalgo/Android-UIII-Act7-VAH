import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/pages/add_name_page.dart';
import 'package:myapp/pages/edit_name_page.dart';
import 'package:myapp/pages/home_page.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crud Victor Aleman Hidalgo",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" :(context) => Home(),
        "/add" :(context) => const AddServicioPage(),
        "/edit" :(context) => const EditServicioPage()
      },
    );
  }
}