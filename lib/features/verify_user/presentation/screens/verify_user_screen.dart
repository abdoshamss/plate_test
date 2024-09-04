
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/verify_user_cubit.dart';
import '../../cubit/verify_user_states.dart';
///// put it in routes 
///  import '../../features/verify_user/presentation/screens/VerifyUser.dart';
/// static const String VerifyUserScreen = "VerifyUserScreen";
//  case Routes.VerifyUserScreen:
        // return CupertinoPageRoute(
        //     settings: routeSettings,
        //     builder: (_) {
        //       return const VerifyUserScreen();
        //     });
class VerifyUserScreen extends StatefulWidget {
  const VerifyUserScreen({Key? key}) : super(key: key);

  @override
  State<VerifyUserScreen> createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>  VerifyUserCubit(),
    child:  BlocConsumer<VerifyUserCubit, VerifyUserStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = VerifyUserCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Text("VerifyUserScreen"),
      
                  
                ],
              ),
            ),
            );
        },
      ),);
    
  }
}
