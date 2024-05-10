import 'package:ai_joke/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'views/home_view.dart';
import 'views/loading.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



void main() async {
  await dotenv.load(fileName: '.env');
  runApp(GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(
              name: '/',
              page: () => Home(),
              binding: HomeBinding()
          )
        ],
        debugShowCheckedModeBanner: false,
        title: 'Joke Creator',
      ));
}