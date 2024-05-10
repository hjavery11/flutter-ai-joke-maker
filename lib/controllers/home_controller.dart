import 'package:ai_joke/services/joke_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final JokeService jokeService;
  HomeController(this.jokeService);


  //reactive list of joke types
  RxList<String> jokeTypes = <String>['Knock-Knock','Dad','One-Liner','Pun','Yo Mama','Surprise Me'].obs;
//reactive variable for selected joke type index
  RxInt selectedButton = (-1).obs; //initial value -1 indicating no selection

  var joke = ''.obs;
  var jokeTopic = ''.obs;

  RxBool isLoading = false.obs;

  TextEditingController textController = TextEditingController();




  void enterJokeTopic(){
    jokeTopic.value = textController.text;
  }


  void selectJokeType(int index){
    selectedButton.value = index;
  }

  Future<void> createJoke() async{
   String topic = textController.text;
    if(topic.isEmpty){
      // Handle no topic entered
      Get.snackbar("Error", "Please enter a joke topic!");
      return;
    }
    if(selectedButton.value == -1){
      // Handle no joke type selected
      Get.snackbar("Error", "Please select a joke type first!");
      return;
    }
    String selectedJokeType = jokeTypes[selectedButton.value];

    isLoading.value = true;
    joke.value = await jokeService.getJoke(textController.text, selectedJokeType);
    isLoading.value = false;
  }



}