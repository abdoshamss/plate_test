import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/notifications/presentation/widgets/widgets.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../cubit/notifications_cubit.dart';
import '../../cubit/notifications_states.dart';
import '../../domain/model/notifications_model.dart';

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
      create: (context) => NotificationsCubit()..addPageListener(),
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
                  child: PagedListView.separated(
                    pagingController: cubit.notificationController,
                    builderDelegate:
                        PagedChildBuilderDelegate<NotificationModel>(
                      noItemsFoundIndicatorBuilder: (context) {
                        return const EmPtyWidget();
                      },
                      itemBuilder: (context, item, index) {
                        return NotificationItems(
                          item: item.data!,
                          createdAt: item.createdAt!,
                        );
                      },
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                )

                // Expanded(
                //       child: ListView.separated(
                //     itemBuilder: (BuildContext context, int index) {
                //       /// is not Read
                //       // Color(0xffF8FAFC);
                //       return NotificationItems(
                //         item: state.list![index],
                //       );
                //     },
                //     separatorBuilder: (BuildContext context, int index) =>
                //         const Divider(),
                //     itemCount: state.list!.length,
                //   ))
              ]),
            ),
          );
        },
      ),
    );
  }
}

class EmPtyWidget extends StatelessWidget {
  const EmPtyWidget({
    super.key,
    this.function,
  });

  final Function? function;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            "no_notifications",
            fontSize: 18,
            color: LightThemeColors.primary,
          ),
          24.ph,
        ],
      ),
    );
  }
}
