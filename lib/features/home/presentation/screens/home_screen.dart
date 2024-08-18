import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/theme/light_theme.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/core/utils/utils.dart';
import 'package:plate_test/features/home/presentation/widgets/widgets.dart';
import 'package:plate_test/shared/widgets/edit_text_widget.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: LightThemeColors.gradient)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'user'.svg(),
                                ),
                                Image.asset("home_logo".png("icons")),
                                SvgPicture.asset(
                                  'notifications'.svg(),
                                )
                              ],
                            ),
                          ),
                          TextFormFieldWidget(
                            // onSaved: (value) => _authRequest.phone = value,
                            backgroundColor: const Color(0xff5237C0),
                            filledColor: const Color(0xff5237C0),

                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    vertical: 16, horizontal: 8),
                            prefixIconWidget: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Image.asset(
                                color: Colors.white,
                                "search".png("icons"),
                              ),
                            ),
                            suffixIconWidget: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                color: Colors.white,
                                "filters".png("icons"),
                              ),
                            ),

                            hintText: 'ابحث عن رقم بليت',
                            hintColor: const Color(0xff94A3B8),
                            validator: (v) => Utils.valid.defaultValidation(v),
                            controller: search,
                            borderRadius: 16,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Column(
                        children: [
                          Image.asset(
                            "banner".png(),
                            width: MediaQuery.of(context).size.width,
                            height: 160,
                            fit: BoxFit.fill,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CustomRow(),
                          ),
                          SizedBox(
                            height: 220,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => const SizedBox(
                                width: 8,
                              ),
                              itemBuilder: (context, index) => Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffE0EBFF)),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("verify_user".png("icons")),
                                     const   Spacer(),
                                        Image.asset("share".png("icons")),
                                        Image.asset("heart".png("icons")),
                                      ],
                                    ),
                                    Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: Image.asset("template".png()),
                                  )],
                                ),
                              ),
                              itemCount: 5,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
