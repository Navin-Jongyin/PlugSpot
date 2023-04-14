import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/qrScanner.dart';
import 'package:plugspot/screen/sidebar.dart';
import 'package:plugspot/screen/wallet.dart';

import 'car_user_profile.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      zoom: 18),
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
            top: 700,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    final Position position = await _getLocation();
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 17.25),
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
          Positioned(
            top: 60,
            left: 27,
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: FloatingActionButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    backgroundColor: Palette.yellowTheme,
                    child: Icon(
                      Icons.menu,
                      size: 30,
                      color: Palette.backgroundColor,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 220,
                  decoration: BoxDecoration(
                      color: Palette.whiteBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 7.0,
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        cursorColor: Palette.yellowTheme,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 18, color: Palette.greyColor),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                          ),
                          prefixIconColor: Palette.yellowTheme,
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QRScanner()));
                    },
                    backgroundColor: Palette.yellowTheme,
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 30,
                      color: Palette.backgroundColor,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
