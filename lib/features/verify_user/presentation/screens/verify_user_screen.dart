import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/shared/widgets/toast.dart';

import '../../../../core/services/alerts.dart';
import '../../../../core/services/media/alert_of_media.dart';
import '../../../../core/services/media/my_media.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/Utils.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../cubit/verify_user_cubit.dart';
import '../../cubit/verify_user_states.dart';
import '../../domain/request/verify_user_request.dart';

class VerifyUserScreen extends StatefulWidget {
  const VerifyUserScreen({super.key});

  @override
  State<VerifyUserScreen> createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> names = ["front", "back"];
  VerifyUserRequest request = VerifyUserRequest();
  TextEditingController nationalId = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyUserCubit(),
      child: BlocConsumer<VerifyUserCubit, VerifyUserStates>(
        listener: (context, state) {
          if (state is VerifyUserSuccess) {
            Toast.show(state.message ?? "Verified Successfully", context,
                backgroundColor: Colors.green);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = VerifyUserCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: ListView(
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
                          "Verified User",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        SvgPicture.asset("dots_white".svg())
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Become Verified",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        8.ph,
                        const CustomText(
                          "Apply for the being verified.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff64748B)),
                        ),
                        24.ph,
                        const CustomText(
                          "Upload your ID Card",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        ...List.generate(
                          2,
                          (index) => GestureDetector(
                            onTap: () {
                              Alerts.bottomSheet(context,
                                  backgroundColor: LightThemeColors.primary,
                                  child: AlertOfMedia(
                                    cameraTap: () async {
                                      if (index == 0) {
                                        request.frontImage =
                                            await MyMedia.pickImageFromCamera();
                                        if (request.frontImage != null) {
                                          print("a" * 88);
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        request.backImage =
                                            await MyMedia.pickImageFromCamera();
                                        if (request.backImage != null) {
                                          print("a" * 88);

                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    galleryTap: () async {
                                      if (index == 0) {
                                        request.frontImage = await MyMedia
                                            .pickImageFromGallery();
                                        if (request.frontImage != null) {
                                          print("a" * 88);

                                          Navigator.pop(context);
                                        }
                                      } else {
                                        request.backImage = await MyMedia
                                            .pickImageFromGallery();
                                        if (request.backImage != null) {
                                          print("a" * 88);

                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                  )).then((v) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              height: 160,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF8FAFC),
                                  borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 48, horizontal: 100),
                              margin: const EdgeInsets.only(top: 24),
                              child: (index == 0 && request.frontImage != null)
                                  ? Image.file(
                                      request.frontImage!,
                                      fit: BoxFit.fill,
                                    )
                                  : (index == 1 && request.backImage != null)
                                      ? Image.file(
                                          request.frontImage!,
                                          fit: BoxFit.fill,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                                "camera_icon".svg()),
                                            CustomText(
                                              "Upload Photo of ${names[index]} side",
                                              style: const TextStyle(
                                                  color: Color(0xff4D4D4D),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: TextFormFieldWidget(
                            onSaved: (v) {
                              request.nationalId = v;
                            },
                            backgroundColor: const Color(0xffF8FAFC),
                            type: TextInputType.number,
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                    vertical: 20, horizontal: 10),
                            hintText: 'National Id',
                            hintColor: const Color(0xff94A3B8),
                            validator: (v) => Utils.valid.defaultValidation(v),
                            controller: nationalId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ButtonWidget(
                title: 'Submit',
                withBorder: true,
                gradient: const LinearGradient(
                  colors: LightThemeColors.gradientPrimary,
                ),
                textColor: Colors.white,
                borderColor: context.primaryColor,
                width: double.infinity,
                fontSize: 18,
                fontweight: FontWeight.bold,
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    if (request.frontImage == null) {
                      Toast.show("Please upload front image", context,
                          backgroundColor: Colors.red);
                    } else if (request.backImage == null) {
                      Toast.show("Please upload back image", context,
                          backgroundColor: Colors.red);
                    } else {
                      formKey.currentState!.save();
                      cubit.verify(verifyUserRequest: request);
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
