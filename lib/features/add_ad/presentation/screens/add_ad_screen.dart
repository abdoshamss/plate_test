import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/services/alerts.dart';
import '../../../../core/services/media/alert_of_media.dart';
import '../../../../core/services/media/my_media.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/utils.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../../item_details/presentation/widgets/widgets.dart';
import '../../cubit/add_ad_cubit.dart';
import '../../cubit/add_ad_states.dart';

///// put it in routes
///  import '../../features/add_ad/presentation/screens/AddAd.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedTap = 0;
  final List<String> titles = ["Ad Price", "Sales Tax", "Total"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  File? image;
  final formKey = GlobalKey<FormState>();
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
            return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Scaffold(
                    body: SafeArea(
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: LightThemeColors.gradient)),
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
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ListView(
                            padding: const EdgeInsets.all(24),
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: CustomText(
                                        "Submit your plate Ad",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    TextFormFieldWidget(
                                      backgroundColor: const Color(0xffF8FAFC),
                                      type: TextInputType.number,
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Plate Number',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      controller: number,
                                    ),
                                    TextFormFieldWidget(
                                      backgroundColor: const Color(0xffF8FAFC),
                                      type: TextInputType.number,
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Plate Code',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      controller: code,
                                    ),
                                    TextFormFieldWidget(
                                      onTap: () {
                                        Navigator.pushNamed(
                                                context, Routes.mapScreen)
                                            .then((value) {
                                          var data = value as List?;
                                          String latAndLng =
                                              "Lat is ${data?[1]},Lang is ${data?[2]}";
                                          print(latAndLng);
                                          location.text = latAndLng;
                                          address.text = data?[0];
                                        });
                                      },
                                      borderColor: Colors.transparent,
                                      activeBorderColor: Colors.transparent,
                                      backgroundColor: const Color(0xffF8FAFC),
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Location',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      controller: location,
                                    ),
                                    TextFormFieldWidget(
                                      backgroundColor: const Color(0xffF8FAFC),
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Address',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      controller: address,
                                    ),
                                    TextFormFieldWidget(
                                      backgroundColor: const Color(0xffF8FAFC),
                                      minLines: 5,
                                      maxLines: 5,
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Description',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      controller: description,
                                    ),
                                    TextFormFieldWidget(
                                      backgroundColor: const Color(0xffF8FAFC),
                                      type: TextInputType.number,
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Asking Price (SAR)',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      controller: price,
                                    ),
                                  ],
                                ),
                              ),
                              24.ph,
                              Padding(
                                padding: const EdgeInsets.all(16),
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
                                    _tabController.animateTo(1);
                                  },
                                ),
                              ),
                            ],
                          ),
                          ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      "Upload the photo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Alerts.bottomSheet(context,
                                            backgroundColor:
                                                LightThemeColors.primary,
                                            child: AlertOfMedia(
                                              cameraTap: () async {
                                                image = await MyMedia
                                                    .pickImageFromCamera();
                                              },
                                              galleryTap: () async {
                                                image = await MyMedia
                                                    .pickImageFromGallery();
                                              },
                                            ));
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 160,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            image: image != null
                                                ? DecorationImage(
                                                    image: FileImage(image!),
                                                    fit: BoxFit.fill)
                                                : null,
                                            color: const Color(0xffF8FAFC),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 48, horizontal: 100),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 24),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                                "camera_icon".svg()),
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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                    _tabController.animateTo(2);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(24),
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffEEF2F6),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                          "Order summary",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        myDivider(),
                                        ...List.generate(
                                            titles.length,
                                            (index) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        titles[index],
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Color(0xff64748B),
                                                        ),
                                                      ),
                                                      CustomText(
                                                        "SAR 50",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: index == 2
                                                                ? const Color(
                                                                    0xff5C44BB)
                                                                : const Color(
                                                                    0xff000000)),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                      ])),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        "Add Promo Code",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          TextFormFieldWidget(
                                            backgroundColor:
                                                const Color(0xffF8FAFC),
                                            contentPadding:
                                                const EdgeInsetsDirectional
                                                    .symmetric(
                                                    vertical: 20,
                                                    horizontal: 10),
                                            hintText: 'Promo Code',
                                            hintColor: const Color(0xff94A3B8),
                                            validator: (v) => Utils.valid
                                                .defaultValidation(v),
                                            controller: price,
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 5,
                                            child: TextButtonWidget(
                                              function: () {},
                                              text: "Add",
                                              fontweight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ButtonWidget(
                                  title: 'Proceed for Payment',
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
                                    Navigator.pushNamed(
                                      context, Routes.WebViewPaymentScreen,
                                      // arguments:
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
                )));
          },
        ));
  }
}
