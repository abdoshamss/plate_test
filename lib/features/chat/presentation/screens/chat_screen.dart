
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_states.dart';
///// put it in routes 
///  import '../../features/chat/presentation/screens/Chat.dart';
/// static const String ChatScreen = "ChatScreen";
//  case Routes.ChatScreen:
        // return CupertinoPageRoute(
        //     settings: routeSettings,
        //     builder: (_) {
        //       return const ChatScreen();
        //     });
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>  ChatCubit(),
    child:  BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = ChatCubit.get(context);
          return const Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Text("ChatScreen"),
      
                  
                ],
              ),
            ),
            );
        },
      ),);
    
  }
}
