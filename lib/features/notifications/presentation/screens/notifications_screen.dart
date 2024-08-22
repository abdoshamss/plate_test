
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/notifications_cubit.dart';
import '../../cubit/notifications_states.dart';
///// put it in routes 
///  import '../../features/notifications/presentation/screens/Notifications.dart';
/// static const String NotificationsScreen = "NotificationsScreen";
//  case Routes.NotificationsScreen:
        // return CupertinoPageRoute(
        //     settings: routeSettings,
        //     builder: (_) {
        //       return const NotificationsScreen();
        //     });
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>  NotificationsCubit(),
    child:  BlocConsumer<NotificationsCubit, NotificationsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = NotificationsCubit.get(context);
          return const Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Text("NotificationsScreen"),
      
                  
                ],
              ),
            ),
            );
        },
      ),);
    
  }
}
