import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/Router/Router.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/services/alerts.dart';
import 'package:plate_test/core/services/media/alert_of_media.dart';
import 'package:plate_test/core/services/media/my_media.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';

class AddAdImageScreen extends StatefulWidget {
  const AddAdImageScreen({super.key});

  @override
  State<AddAdImageScreen> createState() => _AddAdImageScreenState();
}

class _AddAdImageScreenState extends State<AddAdImageScreen> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: LightThemeColors.gradient)),
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Upload the photo",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Alerts.bottomSheet(context,
                          backgroundColor: LightThemeColors.primary,
                          child: AlertOfMedia(
                            cameraTap: () async {
                              image = await MyMedia.pickImageFromCamera();
                            },
                            galleryTap: () async {
                              image = await MyMedia.pickImageFromGallery();
                            },
                          ));
                      setState(() {});
                    },
                    child: Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: image != null
                              ? DecorationImage(
                                  image: FileImage(image!), fit: BoxFit.fill)
                              : null,
                          color: const Color(0xffF8FAFC),
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 48, horizontal: 100),
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("camera_icon".svg()),
                          const CustomText(
                            "Upload Photo of Plate",
                            style: TextStyle(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ButtonWidget(
          title: 'Submit an Ad for 50 SAR',
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
            Navigator.pushNamed(context, Routes.PaymentScreen);
          },
        ),
      ),
    );
  }
}
