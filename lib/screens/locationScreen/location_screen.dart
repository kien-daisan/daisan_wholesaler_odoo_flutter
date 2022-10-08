
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  AppLocalizations? _localizations;
  double? latitude;
  double? longitude;
  late LatLng position;
  location.Location currentLocation = location.Location();
  GoogleMapController? _controller;
  String address = '';
  Map<String, dynamic> addressMap = {};

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ((latitude != null) && (longitude != null))
                ? Stack(children: [
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            latitude ?? 28.6296987, longitude ?? 77.3762753),
                        zoom: 16.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      onCameraMove: (positions) {
                        setState(() {
                          position = positions.target;
                        });
                      },
                      onCameraIdle: () {
                        getLocation(position);
                        setState(() {
                          address = '';
                        });
                      },
                    ),
                    const Positioned(
                        right: 0,
                        top: 0,
                        left: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.location_pin,
                          color: AppColors.red,
                          size: 40,
                        )),
                    Positioned(
                        bottom: 15,
                        right: 15,
                        child: InkWell(
                          onTap: getCurrentLocation,
                          child:  CircleAvatar(
                            backgroundColor:  Theme.of(context).colorScheme.onPrimary,
                            child: const Icon(Icons.my_location_sharp,  ),
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        placeSearchBottomModelSheet(context, (value) {
                          print(' callback value $value');
                          placeSearch(value);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.mediumPadding),
                        margin: const EdgeInsets.all(AppSizes.mediumPadding),
                        color: Theme.of(context).cardColor,
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            const SizedBox(
                              width: AppSizes.extraPadding,
                            ),
                            Text(
                              _localizations?.translate(
                                      AppStringConstant.searchLocation) ??
                                  '',
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ])
                : Loader(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context, addressMap);
            },
            child: Container(
              padding: const EdgeInsets.all(AppSizes.extraPadding),
              height: AppSizes.height / 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      const SizedBox(
                        width: AppSizes.imageRadius,
                      ),
                      Text(_localizations
                              ?.translate(AppStringConstant.selectLocation) ??
                          ''),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.extraPadding,
                  ),
                  (address != '')
                      ? Flexible(
                          child: Text(
                          address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: AppColors.lightGray),
                        ))
                      : Text(_localizations
                              ?.translate(AppStringConstant.loadingMessage) ??
                          'loading...')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getCurrentLocation() async {
    var location;
    try {
      location = await currentLocation.getLocation();
    } catch (e) {
      if(e is PlatformException){
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        AlertMessage.showError(e.message.toString(), context);
      });
      }else {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(e.toString(), context);
        });
      }
      Navigator.pop(context);
      print('exception----------- $e');
    }
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
    position = LatLng(latitude!, longitude!);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude ?? 28.6296987, longitude ?? 77.3762753),
      zoom: 16.0,
    )));
  }

  void placeSearch(LatLng location) {
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
    position = LatLng(latitude!, longitude!);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude ?? 28.6296987, longitude ?? 77.3762753),
      zoom: 16.0,
    )));
    getLocation(location);
  }

  void getLocation(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    setState(() {
      if ((placemarks.first.street ?? '') != '') {
        address += '${placemarks.first.street}, ';
        addressMap['street1'] = placemarks.first.street;
      }
      if ((placemarks.first.thoroughfare ?? '') != '') {
        address += '${placemarks.first.thoroughfare}, ';
        addressMap['street2'] = placemarks.first.thoroughfare;
      }
      if ((placemarks.first.subLocality ?? '') != '') {
        address += '${placemarks.first.subLocality}, ';
        addressMap['street3'] = placemarks.first.subLocality;
      }
      if ((placemarks.first.locality ?? '') != '') {
        address += '${placemarks.first.locality}, ';
        addressMap['city'] = placemarks.first.locality;
      }
      if ((placemarks.first.administrativeArea ?? '') != '') {
        address += '${placemarks.first.administrativeArea}, ';
        addressMap['state'] = placemarks.first.administrativeArea;
      }
      if ((placemarks.first.postalCode ?? '') != '') {
        address += '${placemarks.first.postalCode}, ';
        addressMap['zip'] = placemarks.first.postalCode;
      }
      if ((placemarks.first.country ?? '') != '') {
        address += '${placemarks.first.country} ';
        addressMap['country'] = placemarks.first.country;
      }
    });
    print(" placemarks------- $placemarks");
    print("------------------------------------------------");
  }
}
