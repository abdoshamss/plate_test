import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:plate_test/core/theme/light_theme.dart';
import 'package:plate_test/features/static_page/cubit/cubit.dart';
import 'package:plate_test/features/static_page/cubit/states.dart';

import '../../../shared/widgets/customtext.dart';
import '../../../shared/widgets/loadinganderror.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaticPageCubit()..getaboutPage(),
      child: BlocConsumer<StaticPageCubit, StaticPageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return LoadingAndError(
              isError: state is StaticpagesAboutFailed,
              isLoading: state is StaticpagesAboutLoading,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  backgroundColor: LightThemeColors.primary,
                  elevation: 0,
                  title: CustomText(
                    "aboutUs".tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: false,
                ),
                body: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: HtmlWidget(
                          state is StaticpagesAboutLoaded
                              ? state.content!
                              : "لا يوجد بيانات",
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ),
                  ],
                ),
                // body: FutureBuilder(
                //     future: StaticPagesRepo.aboutUs(context),
                //     builder: (context, snapshot) {
                //       return snapshot.connectionState == ConnectionState.waiting
                //           ? Center(
                //               child: MyLoading.loadingWidget(),
                //             )
                //           : Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 16, vertical: 10),
                //               child: HtmlWidget(snapshot.data.toString()),
                //             );
                //     }),
              ));
        },
      ),
    );
  }
}
