import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_states.dart';
import '../widgets/widgets.dart';

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
      create: (context) => ChatCubit()..chatRooms(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = ChatCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: LightThemeColors.gradient)),
                  child: const CustomText(
                    "Message",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                if (state is GetChatRoomsSuccess)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.ChatDetailsScreen,
                            arguments:
                                int.parse(state.chats![index].id.toString()),
                          );
                        },
                        child: ChatItem(
                          chat: state.chats?[index],
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.chats?.length ?? 0,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
