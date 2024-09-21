import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plate_test/core/theme/light_theme.dart';
import 'package:plate_test/shared/widgets/customtext.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/services/alerts.dart';
import '../../core/utils/utils.dart';
import '../../features/layout/presentation/screens/layout_screen.dart';

class WebViewPayment extends StatefulWidget {
  final String url;

  const WebViewPayment({super.key, required this.url});

  @override
  State<WebViewPayment> createState() => _WebViewPaymentState();
}

class _WebViewPaymentState extends State<WebViewPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: CustomText('pay_now'.tr(), color: LightThemeColors.primary),
        // leading: const BackWidget(),
      ),
      body: SafeArea(
          child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar.
                    },
                    onPageStarted: (String url) {},
                    onPageFinished: (String url) {},
                    onWebResourceError: (WebResourceError error) {
                      debugPrint('''
          Page resource error:
        code: ${error.errorCode}
        description: ${error.description}
        errorType: ${error.errorType}
        isForMainFrame: ${error.isForMainFrame}
              ''');
                    },
                    onNavigationRequest: (NavigationRequest request) {
                      // if (request.url.startsWith('https://www.youtube.com/')) {
                      //   print("fffffffffff");
                      //   return NavigationDecision.prevent;
                      // }

                      // debugPrint(
                      //     "navigation url is ${request.url}");
                      // Uri uri = Uri.parse(request.url);
                      // String? responseCode =
                      //     uri.queryParameters['ResponseCode'];
                      // debugPrint("param1Value $responseCode");
                      // if (responseCode == "000") {
                      //   Utils.showMsg("تم الدفع بنجاح".tr());
                      //   Navigator.pop(context);
                      // }
                      return NavigationDecision.navigate;
                    },
                    onUrlChange: (UrlChange change) async {
                      debugPrint('url change to ${change.url}');
                      if (change.url?.contains('message=APPROVED') == true) {
                        Alerts.snack(
                            text: 'payment_success'.tr(),
                            state: SnackState.success);
                        // Utils.userModel.hasPlan = true;

                        await Utils.saveUserInHive(Utils.userModel.toJson());
                        Future.delayed(const Duration(seconds: 2))
                            .then((value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LayoutScreen(index: 1)),
                                  (route) => false,
                                ));
                      }
                    },
                  ),
                )
                ..loadRequest(Uri.parse(widget.url)))),
    );
  }
}

/*

I/flutter ( 8795): ║    {
I/flutter ( 8795): ║         "status": true,
I/flutter ( 8795): ║         "message": "Loaded Successfully",
I/flutter ( 8795): ║         "data": {
I/flutter ( 8795): ║             "items": [
I/flutter ( 8795): ║                {
I/flutter ( 8795): ║                     "id": 112,
I/flutter ( 8795): ║                     "image": "https://plate.almasader.net/storage/items/d0OUleglee7yPO9ZO1qESH7m4Ga
I/flutter ( 8795): ║                      FFjs5IPmuHQg2.jpg"
I/flutter ( 8795): ║                                     "user_id": 95,
I/flutter ( 8795): ║                     "images": [
I/flutter ( 8795): ║                        {
I/flutter ( 8795): ║                             "id": 634,
I/flutter ( 8795): ║                             "sort": 1,
I/flutter ( 8795): ║                             "item_id": 112,
I/flutter ( 8795): ║                             "image": "https://plate.almasader.net/storage/items/d0OUleglee7yPO9ZO1q
I/flutter ( 8795): ║                              ESH7m4GaFFjs5IPmuHQg2.jpg"
I/flutter ( 8795): ║                             "file_type": "image",
I/flutter ( 8795): ║                             "video": null
I/flutter ( 8795): ║                        },
I/flutter ( 8795): ║                        {
I/flutter ( 8795): ║                             "id": 635,
I/flutter ( 8795): ║                             "sort": 1,
I/flutter ( 8795): ║                             "item_id": 112,
I/flutter ( 8795): ║                             "image": "https://plate.almasader.net/storage/items/vRj6JF6YyIcDTWjid4S
I/flutter ( 8795): ║                              G1KpbAIHqWITXMsXt06Bs.jpg"
I/flutter ( 8795): ║                             "file_type": "image",
I/flutter ( 8795): ║                             "video": null
I/flutter ( 8795): ║                        },
I/flutter ( 8795): ║                        {
I/flutter ( 8795): ║                             "id": 636,
I/flutter ( 8795): ║                             "sort": 1,
I/flutter ( 8795): ║                             "item_id": 112,
I/flutter ( 8795): ║                             "image": "https://plate.almasader.net/storage/items/ZpRhnlkJJwUWVj4JQc8
I/flutter ( 8795): ║                              eKNEZok0zmrqcTSAf6hKW.jpg"
I/flutter ( 8795): ║                             "file_type": "image",
I/flutter ( 8795): ║                             "video": null
I/flutter ( 8795): ║                        },
I/flutter ( 8795): ║                        {
I/flutter ( 8795): ║                             "id": 637,
I/flutter ( 8795): ║                             "sort": 1,
I/flutter ( 8795): ║                             "item_id": 112,
I/flutter ( 8795): ║                             "image": "https://plate.almasader.net/storage/items/96IMn13o66hPqR4M1S2
I/flutter ( 8795): ║                              4TMPy52TSN9CVdDHUgt3u.jpg"
I/flutter ( 8795): ║                             "file_type": "image",
I/flutter ( 8795): ║                             "video": null
I/flutter ( 8795): ║                        },
I/flutter ( 8795): ║                        {
I/flutter ( 8795): ║                             "id": 638,
I/flutter ( 8795): ║                             "sort": 1,
I/flutter ( 8795): ║                             "item_id": 112,
I/flutter ( 8795): ║                             "image": "https://plate.almasader.net/storage/items/XjQSY7oqC6VrtmyOu9G
I/flutter ( 8795): ║                              3JaVVJfzB1cbJMu2Wb0YH.jpg"
I/flutter ( 8795): ║                             "file_type": "image",
I/flutter ( 8795): ║                             "video": null
I/flutter ( 8795): ║                        }
I/flutter ( 8795): ║                     ],
I/flutter ( 8795): ║                     "plate": "1234 kkk",
I/flutter ( 8795): ║                     "plate_code": "kkk",
I/flutter ( 8795): ║                     "plate_number": "1234",
I/flutter ( 8795): ║                     "description": "ggggg",
I/flutter ( 8795): ║                     "plate_style_id": 5,
I/flutter ( 8795): ║                     "plate_style": "نوع 3",
I/flutter ( 8795): ║                     "category_id": 6,
I/flutter ( 8795): ║                     "category": "فئة 1",
I/flutter ( 8795): ║                     "amount": "333.00",
I/flutter ( 8795): ║                     "currency": "SAR",
I/flutter ( 8795): ║                     "action": null,
I/flutter ( 8795): ║                     "images_count": 0,
I/flutter ( 8795): ║                     "featured": true,
I/flutter ( 8795): ║                     "is_solid": false,
I/flutter ( 8795): ║                     "appear": true,
I/flutter ( 8795): ║                     "status": false,
I/flutter ( 8795): ║                     "location": {lat: 37.4219985, lng: -122.0839999, text: Santa Clara County, city: Santa Clara County}
I/flutter ( 8795): ║                }
I/flutter ( 8795): ║             ]
I/flutter ( 8795): ║        }
I/flutter ( 8795): ║         "pagination": {
I/flutter ( 8795): ║             "total": 1,
I/flutter ( 8795): ║             "lastPage": 1,
I/flutter ( 8795): ║             "total_pages": 1,
I/flutter ( 8795): ║             "perPage": 20,
I/flutter ( 8795): ║             "currentPage": 1,
I/flutter ( 8795): ║             "next_page_url": null,
I/flutter ( 8795): ║             "prev_page_url": null
I/flutter ( 8795): ║        }
I/flutter ( 8795): ║    }
*/

/*
Body
I/flutter ( 8795): ║
I/flutter ( 8795): ║    {
I/flutter ( 8795): ║         "status": true,
I/flutter ( 8795): ║         "message": "Loaded Successfully",
I/flutter ( 8795): ║         "data": {
I/flutter ( 8795): ║             "user": {
I/flutter ( 8795): ║         ///                       "id": 95,
I/flutter ( 8795): ║                 "name": "abdo",
I/flutter ( 8795): ║                 "mobile": "0512341234",
I/flutter ( 8795): ║                 "email": "a@gmail.com",
I/flutter ( 8795): ║                 "image": "https://plate.almasader.net/placeholders/user.png",
I/flutter ( 8795): ║                 "notify": true,
I/flutter ( 8795): ║                 "lang": "ar",
I/flutter ( 8795): ║                 "banned": false,
I/flutter ( 8795): ║                 "active": true,
I/flutter ( 8795): ║                 "is_verified": false,
I/flutter ( 8795): ║                 "mobile_verified": true,
I/flutter ( 8795): ║                 "email_verified": false,
I/flutter ( 8795): ║                 "area_id": 1,
I/flutter ( 8795): ║                 "area": "السعوديه",
I/flutter ( 8795): ║                 "is_social": false,
I/flutter ( 8795): ║                 "coaching": ""
I/flutter ( 8795): ║            }
I/flutter ( 8795): ║        }
I/flutter ( 8795): ║    }
* */
