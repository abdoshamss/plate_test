import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plate_test/core/extensions/all_extensions.dart';
import 'package:plate_test/core/theme/light_theme.dart';
import 'package:plate_test/core/utils/extentions.dart';

import '../../shared/widgets/button_widget.dart';
import 'alerts.dart';

class MapItem extends StatefulWidget {
  late double lat;
  late double lng;
  final bool lightMode;

  MapItem({super.key, this.lat = 31, this.lng = 31, this.lightMode = false});

  @override
  State<MapItem> createState() => _State();
}

class _State extends State<MapItem> {
  Set<Marker> markers = {};
  final _controller = Completer<GoogleMapController>();
  late String locationName;

  @override
  void initState() {
    super.initState();
    if (widget.lightMode) {
      goToMyLocation(location: LatLng(widget.lat, widget.lng));
    } else {
      determinePositionAsync();
    }
  }

  Future<void> determinePositionAsync() async {
    final location = await determinePosition();
    area = await getLocation(location.latitude, location.longitude);
    compeleted = true;
  }

  String? area;
  bool compeleted = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        GoogleMap(
          liteModeEnabled: widget.lightMode,
          mapType: MapType.normal,
          markers: markers,
          mapToolbarEnabled: false,
          onTap: (location) async {
            if (!widget.lightMode) {
              await goToMyLocation(location: location);
              area = await getLocation(location.latitude, location.longitude);
              print("areaaaa");
              print(area);
              // await CacheHelper.saveCurrentLocationWithNameMap(locationName);
              //
              // await CacheHelper.saveLatAndLng(location);
            }
            // else {
            // await getMaps(widget.lat, widget.lng);
            // }
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(widget.lat, widget.lng)),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        if (!widget.lightMode)
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  await determinePosition();
                  area = await getLocation(widget.lat, widget.lng);
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13)),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: LightThemeColors.primary,
                      size: 32,
                    ),
                  ),
                ),
              ),
              100.pw,
              SizedBox(
                width: 100,
                child: ButtonWidget(
                  title: 'Pick',
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
                    if (area != null || compeleted) {
                      Navigator.pop(context, [area, widget.lat, widget.lng]);
                      print(area);
                      print(widget.lat);
                      print(widget.lng);
                    }
                    // AuthRequest registerModel = AuthRequest(
                    //   password: password.text,
                    //   phone: phone.text,
                    // );
                    // FocusScope.of(context).unfocus();
                    // if (formKey.currentState!.validate()) {
                    //   final response = await cubit.login(
                    //       loginRequestModel: registerModel);
                    //   if (response == true) {
                    //     Navigator.pushNamedAndRemoveUntil(
                    //         context, Routes.LayoutScreen, (route) => false);
                    //   } else if (response == false) {
                    //     Alerts.snack(
                    //         text: 'You have to activate your account'.tr(),
                    //         state: SnackState.failed);
                    //     Navigator.pushNamed(
                    //       context,
                    //       Routes.OtpScreen,
                    //       arguments: OtpArguments(
                    //           sendTo: phone.text,
                    //           onSubmit: (s) async {
                    //             registerModel.code = s;
                    //             final res = await cubit.activate(
                    //                 registerRequestModel: registerModel);
                    //
                    //             if (res == true) {
                    //               Navigator.pushNamedAndRemoveUntil(
                    //                   context,
                    //                   Routes.LayoutScreen,
                    //                       (route) => false);
                    //             }
                    //           },
                    //           onReSend: () async {
                    //             await cubit
                    //                 .resendCode(registerModel.phone ?? '');
                    //           },
                    //           init: false),
                    //     );
                    //   }
                    // }
                  },
                ),
              ),
            ],
          )
      ],
    );
  }

  Future<void> goToMyLocation({required LatLng location}) async {
    widget.lat = location.latitude;
    widget.lng = location.longitude;

    final GoogleMapController controller = await _controller.future;
    markers.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(location.latitude, location.longitude)));
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(zoom: widget.lightMode ? 12 : 14, target: location)));

    getLocation(location.latitude, location.longitude);
    setState(() {});
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission = await Geolocator.requestPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Alerts.snack(
          text: 'Location services are disabled'.tr(),
          state: SnackState.failed);
      // Toast.show(
      //     "Location services are disabled", navigatorKey.currentContext!,
      //     messageType: MessageType.warning);

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var currentLocation = await Geolocator.getCurrentPosition();

    await goToMyLocation(
        location: LatLng(currentLocation.latitude, currentLocation.longitude));
    print(currentLocation.latitude);
    print(currentLocation.longitude);
    widget.lat = currentLocation.latitude;
    widget.lng = currentLocation.longitude;

    // await CacheHelper.saveCurrentLocation(currentLocation);

    // await CacheHelper.saveLatAndLng(currentLocation);
    return currentLocation;
  }
}

Future<String> getLocation(double lat, double lng) async {
  List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);
  print(placeMarks.toString());
  print("1" * 80);
  print(placeMarks[0].subAdministrativeArea.toString());
  print("area");
  return placeMarks[0].subAdministrativeArea.toString();
  // await CacheHelper.saveCurrentLocationWithNameMap(
  //     placeMarks[0].locality.toString());
}

// Future<void> getMaps(double lat, double lng) async {
//   final availableMaps = await MapLauncher.installedMaps;
//   print(availableMaps);
//   if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
//     await availableMaps.first.showMarker(
//       coords: Coords(lat, lng),
//       title: "test",
//     );
//   }
// }
