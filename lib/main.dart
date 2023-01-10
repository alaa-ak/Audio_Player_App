import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'view/home_screen.dart';

//  (July 23, 2022 :) => Finish My First App :)
void main() {
  runApp(const AudioPlayerApp());
}

class AudioPlayerApp extends StatelessWidget {
  const AudioPlayerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Audio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF607D8B).withOpacity(0.80),
        primarySwatch: Colors.blueGrey,
      ),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
      ],
    );
  }
}
