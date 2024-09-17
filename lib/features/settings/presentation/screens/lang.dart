import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/general/general_cubit.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/customtext.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  final List<String> langNames = ["English (US)", "Arabic"];
  final List<String> langIcons = ["us", "ar"];
  int lang = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneralCubit(),
      child: BlocConsumer<GeneralCubit, GeneralState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = GeneralCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
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
                          "Change Language",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        SvgPicture.asset("dots_white".svg())
                      ],
                    ),
                  ),
                  24.ph,
                  Column(
                    children: List.generate(
                        2,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  lang = index;
                                  if (index == 0) {
                                    cubit.changLang(
                                        const Locale('en', 'US'), context);
                                    Utils.lang = "en";
                                  } else {
                                    cubit.changLang(
                                        const Locale('ar', 'EG'), context);
                                    Utils.lang = "ar";
                                  }
                                });
                              },
                              child: Container(
                                color: Colors.white,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                padding: const EdgeInsets.all(24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          langIcons[index].svg(),
                                          width: 20,
                                          height: 15,
                                          fit: BoxFit.fill,
                                        ),
                                        16.pw,
                                        CustomText(langNames[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16)),
                                      ],
                                    ),
                                    // Expanded(child: SizedBox()),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffEEF2F6)),
                                        color: lang == index
                                            ? LightThemeColors.primary
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 15,
                                        color: lang == index
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
