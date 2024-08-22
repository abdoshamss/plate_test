import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/Router/Router.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/utils.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../cubit/add_ad_cubit.dart';
import '../../cubit/add_ad_states.dart';

///// put it in routes
///  import '../../features/add_ad/presentation/screens/AddAd.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  final number = TextEditingController();
  final code = TextEditingController();
  final location = TextEditingController();
  final address = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAdCubit(),
      child: BlocConsumer<AddAdCubit, AddAdStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = AddAdCubit.get(context);
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
                          "Submitting Ad",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        SvgPicture.asset("dots_white".svg())
                      ],
                    ),
                  ),
                  Expanded(
                      child: Form(
                    key: formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: CustomText(
                            "Submit your plate Ad",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                        TextFormFieldWidget(
                          backgroundColor: const Color(0xffF8FAFC),
                          type: TextInputType.number,
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: 'Plate Number',
                          hintColor: const Color(0xff94A3B8),
                          validator: (v) => Utils.valid.defaultValidation(v),
                          controller: number,
                        ),
                        TextFormFieldWidget(
                          backgroundColor: const Color(0xffF8FAFC),
                          type: TextInputType.number,
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: 'Plate Code',
                          hintColor: const Color(0xff94A3B8),
                          validator: (v) => Utils.valid.defaultValidation(v),
                          controller: number,
                        ),
                        TextFormFieldWidget(
                          backgroundColor: const Color(0xffF8FAFC),
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: 'Location',
                          hintColor: const Color(0xff94A3B8),
                          validator: (v) => Utils.valid.defaultValidation(v),
                          controller: number,
                        ),
                        TextFormFieldWidget(
                          backgroundColor: const Color(0xffF8FAFC),
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: 'Address',
                          hintColor: const Color(0xff94A3B8),
                          validator: (v) => Utils.valid.defaultValidation(v),
                          controller: address,
                        ),
                        TextFormFieldWidget(
                          backgroundColor: const Color(0xffF8FAFC),
                          minLines: 5,
                          maxLines: 5,
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: 'Description',
                          hintColor: const Color(0xff94A3B8),
                          validator: (v) => Utils.valid.defaultValidation(v),
                          controller: description,
                        ),
                        TextFormFieldWidget(
                          backgroundColor: const Color(0xffF8FAFC),
                          type: TextInputType.number,
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              vertical: 20, horizontal: 10),
                          hintText: 'Asking Price (SAR)',
                          hintColor: const Color(0xff94A3B8),
                          validator: (v) => Utils.valid.defaultValidation(v),
                          controller: number,
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(16),
              child: ButtonWidget(
                title: 'Continue',
                withBorder: true,

                gradient: const LinearGradient(
                  colors: LightThemeColors.gradientPrimary,
                ),
                textColor: Colors.white,
                borderColor: context.primaryColor,
                width: double.infinity,
                fontSize: 18,
                fontweight: FontWeight.bold,
                // padding: const EdgeInsets.symmetric(horizontal: 15),
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(context, Routes.AddAdImageScreen);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
