import 'dart:async';
import 'dart:ffi';
import 'package:path/src/context.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/qrScanner.dart';
import 'package:plugspot/screen/sidebar.dart';

import 'user_profile.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Marker newMarker = Marker(
      markerId: MarkerId('new_marker'),
      position: LatLng(13.726862, 100.76644),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: 'New Marker'),
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            padding: EdgeInsets.fromLTRB(15, 30, 10, 10),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'College Town',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Palette.backgroundColor
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 25,
                      color: Palette.yellowTheme,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '669/1 Chalong Krung 1 Alley, Chalongkrung Road Lat Krabang, Bangkok 10520',
                        style: GoogleFonts.montserrat(fontSize: 15,color: Palette.backgroundColor),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 25,
                      color: Palette.yellowTheme,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '0812345678',
                        style: GoogleFonts.montserrat(fontSize: 15,color: Palette.backgroundColor),
                      ),
                    )
                  ],
                ),


              ],

            ),
          );
        },
      ));


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
                  markers: Set<Marker>.of([newMarker]),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target:
                          LatLng(userLocation.latitude, userLocation.longitude),
                      zoom: 17.85),
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
                  VerticalDivider(
                    color: Palette.greyColor,
                    thickness: 1.5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  QRCodeScannerPage(),
                          transitionDuration: Duration(seconds: 5),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 30,
                      color: Palette.backgroundColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
