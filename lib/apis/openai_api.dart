import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/src/widgets/editable_text.dart';

const String openai_api_secret_key = 'sk-proj-nkmoZlDBkiUCZl8VnSiWT3BlbkFJeeYDdzr7vrkRP2bZGvso';

class OpenAPIController{
  OpenAPIController(textController);

  Future<String> _getJoke(controller,text) async {
    var _text = text;
    OpenAI.apiKey = 'sk-proj-4x8WAxdshQIBQ3DIcvHTT3BlbkFJkgDp2c79lyBFcM6tyGjS';

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "give me a knock-knock joke using the subject of $_text.",
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );



// all messages to be sent.
    final requestMessages = [
      systemMessage
    ];

// the actual request.
    OpenAIChatCompletionModel jokePrompt = await OpenAI.instance.chat.create(
      model: "gpt-4",
      seed: 6,
      messages: requestMessages,
      temperature: 0.2,
      maxTokens: 500,
    );

    OpenAIChatCompletionChoiceMessageModel data = jokePrompt.choices.first.message;
    Map map = data.toMap();

    String finalJoke = map['content'][0]['text'];
    return finalJoke;
  }
}