import 'dart:convert';
import 'dart:ffi';

import 'package:ai_joke/controllers/home_controller.dart';
import 'package:ai_joke/services/joke_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../apis/openai_api.dart';
import '../services/network_service.dart';
import 'package:dart_openai/dart_openai.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('AI Joke Maker',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 32,
                color: Colors.grey[900])),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Obx( () => TextField(
              decoration: const InputDecoration(
                labelText: "Enter a joke topic",
                border: OutlineInputBorder(),
              ),
              controller: controller.textController,
              readOnly:  controller.isLoading.value ? true : false,
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text(
              'Joke Type',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.grey[800],
              ),
            ),
          ),
          Obx(
            () => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(controller.jokeTypes.length, (index) {
                return ElevatedButton(
                  onPressed: (() {
                    if(!controller.isLoading.value) {
                        controller.selectJokeType(index);
                       FocusScope.of(context).unfocus();
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedButton.toInt() == index
                        ? Colors.blue
                        : Colors.white70, // Active or inactive color
                    foregroundColor: controller.selectedButton.toInt() == index
                        ? Colors.white
                        : Colors.black,
                    //
                  ),
                  child: Text(controller.jokeTypes[index]),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Obx( () =>TextButton(
              style: TextButton.styleFrom(
                backgroundColor: controller.isLoading.value ? Colors.grey : Colors.lightBlueAccent,
                foregroundColor: Colors.grey[50],
                shadowColor: Colors.black,
                elevation: controller.isLoading.value ? 0:8,
              ),
              onPressed: controller.isLoading.value ? null :() async {
                FocusScope.of(context).unfocus();
                controller.createJoke();
              },
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Create Joke",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            )
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  // Light grey background to indicate area
                  border: Border.all(
                    color: Colors.grey, // Color of the border
                    width: 2, // Width of the border
                  ),
                  borderRadius: BorderRadius.circular(12),
                  // Rounded corners for a softer look
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      // Shadow color with some transparency
                      spreadRadius: 2,
                      // Extent of the shadow spreading beyond the box
                      blurRadius: 5,
                      // How blurry the shadow should be
                      offset: const Offset(
                          0, 3), // Horizontal, Vertical offset of the shadow
                    )
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                // Padding inside the container
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                // Margin around the container, making it a bit more inset
                //alignment: Alignment.center, // Center the text inside
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 100.0,
                    );
                  } else {
                    return Text(
                      controller.joke.value.isEmpty
                          ? "Your joke will appear here!"
                          : controller.joke.value,
                      // Displays a placeholder or the joke
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    );
                  }
                })),
          )
        ],
      ),
    );
  }
}
