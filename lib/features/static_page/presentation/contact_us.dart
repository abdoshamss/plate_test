import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/theme/light_theme.dart';
import 'package:plate_test/core/utils/extentions.dart';
import 'package:plate_test/features/auth/domain/request/auth_request.dart';
import 'package:plate_test/features/static_page/cubit/cubit.dart';
import 'package:plate_test/features/static_page/cubit/states.dart';

import '../../../core/utils/Utils.dart';
import '../../../shared/widgets/button_widget.dart';
import '../../../shared/widgets/customtext.dart';
import '../../../shared/widgets/edit_text_widget.dart';
import '../../../shared/widgets/loadinganderror.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final AuthRequest _authRequest = AuthRequest();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaticPageCubit(),
      child: BlocConsumer<StaticPageCubit, StaticPageStates>(
        listener: (context, state) {
          if (state is FaqLaodedState) {
            phone.clear();
            name.clear();
            email.clear();
            message.clear();
          }
        },
        builder: (context, state) {
          return LoadingAndError(
              isError: state is StaticpagesPolicyFailed,
              isLoading: state is StaticpagesPolicyLoading,
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
                    "ContactUs".tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      32.ph,
                      TextFormFieldWidget(
                        controller: name,
                        backgroundColor: context.primaryColor.withOpacity(.04),
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        type: TextInputType.name,
                        hintText: 'Name',
                        password: false,
                        onSaved: (e) {
                          _authRequest.name = e;
                        },
                        validator: (v) => Utils.valid.defaultValidation(v),
                        borderRadius: 16,
                      ),
                      16.ph,
                      TextFormFieldWidget(
                        onSaved: (value) => _authRequest.phone = value,
                        backgroundColor: const Color(0xffF8FAFC),
                        type: TextInputType.phone,
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        hintText: 'Phone Number',
                        hintColor: const Color(0xff94A3B8),
                        validator: (v) => Utils.valid.defaultValidation(v),
                        controller: phone,
                      ),
                      16.ph,
                      TextFormFieldWidget(
                        controller: email,
                        backgroundColor: context.primaryColor.withOpacity(.04),
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        type: TextInputType.emailAddress,
                        hintText: 'Email',
                        password: false,
                        onSaved: (e) {
                          _authRequest.email = e;
                        },
                        validator: (v) => Utils.valid.emailValidation(v),
                        borderRadius: 16,
                      ),
                      16.ph,
                      TextFormFieldWidget(
                        controller: message,
                        backgroundColor: context.primaryColor.withOpacity(.04),
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        type: TextInputType.emailAddress,
                        hintText: 'Message',
                        password: false,
                        onSaved: (e) {
                          _authRequest.message = e;
                        },
                        maxLines: 9,
                        minLines: 9,
                        validator: (v) => Utils.valid.defaultValidation(v),
                        borderRadius: 16,
                      ),
                      64.ph,
                      ButtonWidget(
                        title: 'Sign in',
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
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            StaticPageCubit.get(context)
                                .postFaqs(authRequest: _authRequest);
                          }
                        },
                      ),
                    ],
                  ),
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
