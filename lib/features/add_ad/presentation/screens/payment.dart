import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/customtext.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedOption = 1;
  final List<String> methods = ["Paypal", "Credit Card"];
  final List<String> detailsMethod = [
    "designer.gabut@gmail.com",
    "Visa *** 7621"
  ];
  final List<String> icons = ["paypal", "credit-card"];

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
                    "Payment",
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  ...List.generate(
                      methods.length,
                      (index) => Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(icons[index].svg()),
                              8.pw,
                              Text(
                                methods[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                              4.pw,
                              Text(
                                "(${detailsMethod[index]})",
                                style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                              const Spacer(),
                              Radio<int>(
                                value: (index + 1),
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                    print("Button value: $value");
                                  });
                                },
                              ),
                            ],
                          )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
