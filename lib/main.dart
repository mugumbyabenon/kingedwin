import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zoom_clone_tutorial/homepage.dart';
import 'package:zoom_clone_tutorial/homeui.dart';
import 'package:zoom_clone_tutorial/register.dart';
import 'package:zoom_clone_tutorial/resources/auth_methods.dart';
import 'package:zoom_clone_tutorial/screens/home_screen.dart';
import 'package:zoom_clone_tutorial/screens/login_screen.dart';
import 'package:zoom_clone_tutorial/screens/video_call_screen.dart';
import 'package:zoom_clone_tutorial/utils/colors.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yo Class',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
       // '/login': (context) => const LoginScreen(),
        '/home': (context) => const FirstPage(),
        '/video-call': (context) => const VideoCallScreen(),
          '/login': (context) =>  FirstPage(),
           '/register': (context) =>  RegisterView(),
       '/start': (context) =>  LoginScreen(),   
     //   '/books': (context) =>  Books(),    
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return const HOMEUI();
          }

          return const HOMEUI();
        },
      ),
    );
  }
}


Future<void> downloadFile(context) async {
  final  ref =
      FirebaseStorage.instance
      .ref('myapp.png');

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  final File tempFile = File(appDocPath + '/' + 'myapp.png');
  try {
    await ref.writeToFile(tempFile);
    await tempFile.create();
    await OpenFile.open(tempFile.path);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error, occurred',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text(
          'File Berhasil diunduh',
          style: Theme.of(context).textTheme.bodyText1,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).primaryColorLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
    );
}