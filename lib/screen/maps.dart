import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/timeSelection.dart';

import 'package:plugspot/screen/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late BuildContext modalContext;
  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//Navigation TODO
  void _launchGoogleMapsNavigation(double lat, double lng) async {}

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'images/marker.png')
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: SideBar(),
      body: Stack(
        children: [
          FutureBuilder(
            future: _getLocation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 17.85,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("new_marker"),
                      position: LatLng(13.726862, 100.76541),
                      icon: markerIcon,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 250,
                              padding: EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "College Town, Ladkrabang",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 25),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Palette.yellowTheme,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Location",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 25),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_iphone,
                                          color: Palette.yellowTheme,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "0812345678",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 170,
                                          height: 50,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      TimeSelection(),
                                                ),
                                              );
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              "Book Now",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 18,
                                                color: Palette.backgroundColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            backgroundColor:
                                                Palette.yellowTheme,
                                          ),
                                        ),
                                        Container(
                                          width: 170,
                                          height: 50,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              _launchGoogleMapsNavigation(
                                                  13.726862, 100.76541);
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.navigation_rounded,
                                                  color: Palette.yellowTheme,
                                                ),
                                                Text(
                                                  "Navigation",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 18,
                                                    color: Palette.yellowTheme,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                Palette.backgroundColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'uniqueTag',
                  onPressed: () async {
                    final Position position = await _getLocation();
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 17.85),
                      ),
                    );
                  },
                  backgroundColor: Palette.yellowTheme,
                  child: ImageIcon(
                    AssetImage('images/icon/crosshair.png'),
                    color: Palette.backgroundColor,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: EdgeInsets.all(10),
              height: 60,
              decoration: BoxDecoration(
                  color: Palette.whiteBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 7,
                        spreadRadius: 3,
                        color: Palette.greyColor),
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      size: 30,
                      color: Palette.yellowTheme,
                    ),
                  ),
                  VerticalDivider(
                    color: Palette.greyColor,
                    thickness: 1.5,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Palette.yellowTheme,
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 16, color: Palette.greyColor)),
                      style: GoogleFonts.montserrat(
                          color: Palette.backgroundColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
