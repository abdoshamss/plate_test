import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/features/notifications/presentation/widgets/widgets.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/notifications_cubit.dart';
import '../../cubit/notifications_states.dart';

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
      create: (context) => NotificationsCubit(),
      child: BlocConsumer<NotificationsCubit, NotificationsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = NotificationsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: LightThemeColors.gradient)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      const CustomText(
                        "Notifications",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    /// is not Read
                    // Color(0xffF8FAFC);
                    return const NotificationItem();
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: 15,
                ))
              ]),
            ),
          );
        },
      ),
    );
  }
}
