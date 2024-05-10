import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JokeService {
  final String? apiKey = dotenv.env['OPEN_AI_API_KEY'];

  Future<String> getJoke(String topic, String type) async {
    if (type == 'Surprise me') {
      type = 'random';
    }

    OpenAI.apiKey = apiKey!; // Set API key

    OpenAIChatCompletionChoiceMessageModel systemMessage;
    OpenAIChatCompletionChoiceMessageModel userMessage;

    systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "You are a comedian. You are going to be given a joke topic, and a type of joke. Return a funny joke for that topic in the specific style given. The style choices you will be given are Knock-knock, dad, one-liner, pun, yo mama, and a random type. Try to make the jokes unique to each joke type, and not repeat jokes across types.")
      ],
      role: OpenAIChatMessageRole.assistant,
    );

    userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
            "The joke type is $type and the topic is $topic. Only give me the joke, nothing else")
      ],
      role: OpenAIChatMessageRole.user,
    );


    final requestMessages = [systemMessage,userMessage];

    OpenAIChatCompletionModel jokePrompt = await OpenAI.instance.chat.create(
      model: "gpt-4-turbo-preview",
      messages: requestMessages,
      temperature: 1,
      maxTokens: 500,
    );

    OpenAIChatCompletionChoiceMessageModel data =
        jokePrompt.choices.first.message;
    Map map = data.toMap();

    return map['content'][0]['text']; // Return the joke text
  }
}
