import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/customtext.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../cubit/settings_cubit.dart';
import '../../cubit/settings_states.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? wallet;
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          if (state is GetWalletDataSuccess) {
            wallet = state.balance;
          }
        },
        builder: (context, state) {
          final cubit = SettingsCubit.get(context);
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
                        "Wallet",
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
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.wallet,
                          size: 200,
                          color: context.primaryColor.withOpacity(1),
                        ),
                      ),
                      48.ph,
                      const CustomText(
                        "Your Wallet",
                        color: LightThemeColors.textPrimary,
                        fontSize: 18,
                        weight: FontWeight.w700,
                      ),
                      24.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            "Balacne",
                            color: LightThemeColors.primary,
                            fontSize: 16,
                            weight: FontWeight.w700,
                          ),
                          CustomText(
                            "${wallet ?? 0}",
                            color: LightThemeColors.textPrimary,
                            fontSize: 16,
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                      100.ph,
                      TextFormFieldWidget(
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            vertical: 20, horizontal: 10),
                        hintColor: LightThemeColors.textHint,
                        hintSize: 16,
                        hintText: "amount",
                        controller: amount,
                        type: TextInputType.number,
                      ),
                      32.ph,
                      ButtonWidget(
                        onTap: () async {
                          if (amount.text.isEmpty) {
                            return;
                          }
                          final res = await cubit.chargeWallet(
                            amount.text,
                          );
                          if (res != null) {
                            Navigator.pushNamed(
                              context,
                              Routes.WebViewPaymentScreen,
                              arguments: res,
                            );
                          }
                        },
                        gradient: const LinearGradient(
                          colors: LightThemeColors.gradientPrimary,
                        ),
                        textColor: Colors.white,
                        title: "Charge",
                        fontSize: 18,
                        fontweight: FontWeight.w700,
                      )
                    ],
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
