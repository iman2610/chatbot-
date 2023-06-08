import 'dart:convert';
import 'dart:core';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/presentations/screens/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstapp/presentations/screens/reponse.dart';
import 'package:intl/intl.dart';
import 'package:firstapp/logic/auth.dart';
import 'package:firstapp/logic/cubit/chat_cubit.dart';
import 'package:firstapp/models/chatmodel.dart';
import 'package:firstapp/models/loginmodel.dart';
import 'package:firstapp/presentations/screens/changePasswrd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../logic/chat.dart';
import '../constants/constants.dart';
import '../providers/themeprovider.dart';
import 'localizations.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'message.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'profile.dart';

class ChatScreen extends StatefulWidget {
  final LoginModel model;
  const ChatScreen({Key? key, required this.model}) : super(key: key);

  get model1 => null;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class ChatMessage {}

String? response;
String? url;

class _ChatScreenState extends State<ChatScreen> {
  List<String> _messages = [];
  List<String> _reponses = [];
  List<String> _dates = [];

  void _changeLanguage(BuildContext context, Locale locale) {
    setState(() {
      AppLocalizations localizations = AppLocalizations(locale);
      localizations.load().then((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) => ChatScreen(
                    model: widget.model,
                  )),
        );
      });
    });
  }

  String _date = DateFormat.Hm().format(DateTime.now());

  final TextEditingController _textController = TextEditingController();

  void _repondre(String reponse, String d) {
    setState(() {
      _reponses.add(reponse);
      _dates.add(d);
    });
  }

  void _sendMessage(String message) {
    setState(() {
      _messages.add(message);
    });
    _textController.clear();
  }

  void _startNewChat() {
    setState(() {
      _messages.clear();
      _reponses.clear();
    });
    _textController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget _buildPlaceholderImage() {
    if (widget.model.profile != null) {
      return CircleAvatar(
        radius: 45,
        backgroundImage: NetworkImage(url ?? widget.model.profile),
      );
    }
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      radius: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.person,
            size: 60,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidthPercentage = 0.7;
    final drawerWidth = screenWidth * drawerWidthPercentage;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('Sewelni')),
        backgroundColor: kPrimaryColor,
      ),
      drawer: Drawer(
        width: drawerWidth,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              model: widget.model,
                            ),
                          ),
                        );
                      },
                      child: _buildPlaceholderImage()),
                  Text(
                    widget.model.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
                Row(
                  children: [
                    Icon(
                      themeProvider.isDarkMode
                          ? Icons.nightlight_round
                          : Icons.wb_sunny,
                      color: themeProvider.isDarkMode
                          ? Color.fromARGB(255, 206, 200, 149)
                          : Color.fromARGB(255, 247, 212, 144),
                    ),
                    SizedBox(width: 8),
                    Text(
                      themeProvider.isDarkMode
                          ? AppLocalizations.of(context)!.translate('Dark Mode')
                          : AppLocalizations.of(context)!
                              .translate('Light Mode'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text(AppLocalizations.of(context)!.translate('New chat')),
              onTap: () {
                _startNewChat();
                Navigator.pop(context);
                //Handle language selection
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(AppLocalizations.of(context)!.translate('Language')),
              onTap: () {
                _changeLanguage(context, Locale('fr'));
                // Handle language selection
              },
            ),
            ListTile(
              leading: Icon(Icons.password),
              title: Text(
                  AppLocalizations.of(context)!.translate('Change password')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
                // Handle language selection
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text('Settings'),
            //   onTap: () {
            //     // Handle settings selection
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(AppLocalizations.of(context)!.translate('Log out')),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
                Auth.clearTokens();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _reponses.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                final response = _reponses[index];
                return Column(
                  children: [
                    ListTile(
                      title: TextMessage(
                        message: message,
                      ),
                      subtitle: Text(
                        _date,
                        textAlign: TextAlign.right,
                        selectionColor:
                            Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    ListTile(
                      title: Textreponse(
                        reponse: response,
                      ),
                      subtitle: Text(
                        _dates[index],
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Divider(height: 0.6),
                  ],
                );
              },
            ),
          ),
          Divider(height: 0.6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!
                              .translate('Type a question...'),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocConsumer<ChatCubit, ChatState>(listener: (context, state) {
                  if (state is ChatSuccess) {
                    final chatmodel model1 =
                        (state as ChatSuccess).modelc; // Get the chat model
                    String rep = model1.response;
                    String recieved = model1.date;
                    _repondre(rep, recieved);
                  } else if (state is ChatError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!
                            .translate(state.errorMessage)),
                      ),
                    );
                  }
                }, builder: (context, state) {
                  return IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      context.read<ChatCubit>().chat(_textController.text);
                      String message = _textController.text.trim();

                      if (message.isNotEmpty) {
                        _sendMessage(message);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


  
  //   ),
  // },