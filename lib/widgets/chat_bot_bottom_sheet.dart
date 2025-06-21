// lib/widgets/chat_bot_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:findlab/models/chat_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotBottomSheet extends StatefulWidget {
  const ChatBotBottomSheet({super.key});

  @override
  State<ChatBotBottomSheet> createState() => _ChatBotBottomSheetState();
}

class _ChatBotBottomSheetState extends State<ChatBotBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          'Bonjour ! Merci de contacter FindLab. Comment pouvons-nous vous aider ?',
      isUser: false,
    ),
  ];

  // Predefined responses for the chatbot
  final Map<String, String> _responses = {
    'Comment puis-je prendre rendez-vous ?':
        'Pour prendre rendez-vous, veuillez vous rendre sur votre page d’accueil, sélectionner le test souhaité, indiquer votre code postal, puis choisir votre assurance. Cliquez ici pour voir les tests disponibles que nous proposons.',
    'quels tests proposez-vous ?':
        'Nous proposons une variété de tests, y compris des analyses de sang, des examens d’imagerie, et plus encore. Vous pouvez consulter la liste complète sur la page d’accueil, sous « Tests disponibles ».',
    'comment puis-je changer mon mot de passe ?':
        'Pour changer votre mot de passe, allez dans l’écran Profil, sélectionnez « Sécurité », puis saisissez votre mot de passe actuel et le nouveau.',
  };

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      // Add the user's message
      _messages.add(ChatMessage(text: _controller.text, isUser: true));

      // Get the bot's response
      String userMessage = _controller.text.toLowerCase();
      String botResponse =
          _responses[userMessage] ??
          'Je ne suis pas sûr de pouvoir vous aider avec cela. Veuillez essayer de poser une autre question ou choisir un sujet ci-dessous.';
      _messages.add(ChatMessage(text: botResponse, isUser: false));
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75, // 60% of screen height
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 233, 241, 255),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/vector_solo.png',
                    height: 30,
                    fit: BoxFit.contain,
                    width: 50,
                  ),
                  const Text(
                    'Assistant IA FindLab',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          // Chat messages
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment:
                      message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border:
                          message.isUser
                              ? Border.all(
                                color: const Color.fromARGB(255, 67, 118, 199),
                                width: 1.5,
                              )
                              : Border.all(
                                color: const Color.fromARGB(255, 68, 68, 68),
                                width: 2,
                              ),
                      color:
                          message.isUser
                              ? Color.fromARGB(255, 233, 241, 255)
                              : const Color.fromARGB(255, 68, 68, 68),
                      borderRadius:
                          message.isUser
                              ? const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                              : const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color:
                            message.isUser
                                ? const Color.fromARGB(255, 67, 118, 199)
                                : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Sélectionnez un sujet'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  _responses.keys.map((question) {
                                    return ListTile(
                                      title: Text(question),
                                      onTap: () {
                                        setState(() {
                                          _messages.add(
                                            ChatMessage(
                                              text: question,
                                              isUser: true,
                                            ),
                                          );
                                          _messages.add(
                                            ChatMessage(
                                              text: _responses[question]!,
                                              isUser: false,
                                            ),
                                          );
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  }).toList(),
                            ),
                          ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 67, 118, 199),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 110.h,
                      vertical: 11.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Changer de sujet'),
                ),
                SizedBox(height: 75),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    suffixIconColor: const Color.fromARGB(255, 67, 118, 199),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send_sharp),
                      onPressed: _sendMessage,
                    ),
                    hintText: 'Comment pouvons-nous vous aider ?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  onSubmitted: (value) => _sendMessage(),
                ),
              ),
            ],
          ),
          // Change topic button
        ],
      ),
    );
  }
}
