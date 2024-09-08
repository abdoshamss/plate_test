import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/Locator.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/add_ad/domain/model/list_data_model.dart';
import 'package:plate_test/features/add_ad/domain/repository/repository.dart';
import 'package:plate_test/features/add_ad/domain/request/add_ad_request.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/services/alerts.dart';
import '../../../../core/services/media/alert_of_media.dart';
import '../../../../core/services/media/my_media.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../core/utils/utils.dart';
import '../../../../shared/widgets/autocomplate.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../../../shared/widgets/toast.dart';
import '../../../item_details/presentation/widgets/widgets.dart';
import '../../cubit/add_ad_cubit.dart';
import '../../cubit/add_ad_states.dart';
import '../../domain/model/summary_model.dart';

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

  AddAdRequest addAdRequest = AddAdRequest();
  final formKey = GlobalKey<FormState>();
  final number = TextEditingController();
  final code = TextEditingController();
  final location = TextEditingController();
  final address = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final coupon = TextEditingController();
  File? image;
  List<File>? images = [];
  double? lat, lng;
  bool isFeatured = false, isBid = false;
  Details? model = Details();

  // List<String?> itemsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddAdCubit(),
        child: BlocConsumer<AddAdCubit, AddAdStates>(
          listener: (context, state) {
            if (state is AddAdSuccessState) {
              context.read<AddAdCubit>().getSummaryData("", 1);
            } else if (state is GetSummarySuccessState) {
              model = state.model?.details;
              // itemsList.add(state.model?.details?.price);
              // itemsList.add(state.model?.details?.tax);
              // itemsList.add(state.model?.details?.total);
            }
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
                              if (_tabController.index == 0) {
                                Navigator.pop(context);
                              } else if (_tabController.index == 1 ||
                                  _tabController.index == 2) {
                                _tabController
                                    .animateTo(--_tabController.index);
                              }
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
                                      onSaved: (v) {
                                        addAdRequest.plateNumber =
                                            int.tryParse(v!);
                                      },
                                      backgroundColor: const Color(0xffF8FAFC),
                                      type: TextInputType.number,
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Plate Number',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: cubit.validatePlateNumber(),
                                      controller: number,
                                    ),
                                    TextFormFieldWidget(
                                      onSaved: (v) {
                                        addAdRequest.plateCode = v;
                                      },
                                      backgroundColor: const Color(0xffF8FAFC),
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      hintText: 'Plate Code',
                                      hintColor: const Color(0xff94A3B8),
                                      validator: cubit.validateCodeNumber(),
                                      controller: code,
                                    ),
                                    TextFormFieldWidget(
                                      onSaved: (v) {
                                        addAdRequest.lat = lat;
                                        addAdRequest.lng = lng;
                                      },
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
                                          lat = data?[1];
                                          lng = data?[2];
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
                                      onSaved: (v) {
                                        addAdRequest.location = v;
                                        print("location is $v");
                                      },
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
                                    CustomAutoCompleteTextField<Categories>(
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      onChanged: (value) {
                                        addAdRequest.categoryID = value.id;
                                      },
                                      function: (s) async {
                                        // return await locator<GeneralRepo>()
                                        //         .getAreas() ??
                                        //     [];

                                        return (await locator<AddAdRepository>()
                                                    .getListData())
                                                ?.categories ??
                                            [];
                                      },

                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      showSufix: false,
                                      localData: false,
                                      showLabel: false,
                                      hint: "Category",
                                      itemAsString: (a) => a.name ?? '',

                                      // border: InputBorder.none,
                                    ),
                                    CustomAutoCompleteTextField<PlateStyles>(
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                              vertical: 20, horizontal: 10),
                                      onChanged: (value) {
                                        addAdRequest.itemStyleId = value.id;
                                      },
                                      function: (s) async {
                                        // return await locator<GeneralRepo>()
                                        //         .getAreas() ??
                                        //     [];

                                        return (await locator<AddAdRepository>()
                                                    .getListData())
                                                ?.plateStyles ??
                                            [];
                                      },

                                      validator: (v) =>
                                          Utils.valid.defaultValidation(v),
                                      showSufix: false,
                                      localData: false,
                                      showLabel: false,
                                      hint: "Plate Style",
                                      itemAsString: (a) => a.name ?? '',

                                      // border: InputBorder.none,
                                    ),
                                    TextFormFieldWidget(
                                      onSaved: (v) {
                                        addAdRequest.description = v;
                                      },
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
                                      onSaved: (v) {
                                        addAdRequest.amount =
                                            double.tryParse(v!);
                                      },
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
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      FocusScope.of(context).unfocus();

                                      _tabController.animateTo(1);
                                    }
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
                                        if (images!.length < 5) {
                                          Alerts.bottomSheet(context,
                                              backgroundColor:
                                                  LightThemeColors.primary,
                                              child: AlertOfMedia(
                                                cameraTap: () async {
                                                  image = await MyMedia
                                                      .pickImageFromCamera();
                                                  if (image != null) {
                                                    print("a" * 88);
                                                    images?.add(image!);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                galleryTap: () async {
                                                  image = await MyMedia
                                                      .pickImageFromGallery();
                                                  if (image != null) {
                                                    images?.add(image!);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              )).then((v) {
                                            setState(() {});
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 160,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
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
                              if (images!.isNotEmpty)
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: images!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: FileImage(
                                                        images![index]),
                                                    fit: BoxFit.fill),
                                                color: const Color(0xffF8FAFC),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                          ),
                                          16.ph,
                                          GestureDetector(
                                            onTap: () {
                                              images!.removeAt(index);
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: const Icon(
                                                Icons.delete_forever_rounded,
                                                color: Colors.red,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      "Featured",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Switch(
                                      value: isFeatured,
                                      onChanged: (value) {
                                        setState(() {
                                          isFeatured = value;
                                        });
                                      },
                                      inactiveTrackColor: Colors.white,
                                      activeColor: LightThemeColors.primary,
                                      inactiveThumbColor: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      "Negotiable",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Switch(
                                      value: isBid,
                                      onChanged: (value) {
                                        setState(() {
                                          isBid = value;
                                        });
                                      },
                                      inactiveTrackColor: Colors.white,
                                      activeColor: LightThemeColors.primary,
                                      inactiveThumbColor: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
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
                                    if (images!.length == 5) {
                                      addAdRequest.images = images;
                                      addAdRequest.isFeatured = isFeatured;
                                      addAdRequest.isBid = isBid;
                                      cubit.addAdd(addAdRequest: addAdRequest);
                                      _tabController.animateTo(2);
                                    } else {
                                      Toast.show(
                                          "please upload 5 images", context,
                                          backgroundColor: Colors.red);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          ListView(
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
                                        if (model?.itemsList != null)
                                          ...List.generate(
                                              model!.itemsList.length,
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0xff64748B),
                                                          ),
                                                        ),
                                                        CustomText(
                                                          "SAR ${model?.itemsList[index]}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                            controller: coupon,
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 5,
                                            child: TextButtonWidget(
                                              function: () {
                                                cubit.validateCoupon(
                                                    coupon.text);
                                              },
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
                                    cubit.orderCharge();
                                    if (state is OrderChargeSuccessState) {
                                      Navigator.pushNamed(
                                          context, Routes.WebViewPaymentScreen,
                                          arguments: state.chargeLink);
                                    }
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
