import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plugspot/config/palette.dart';

import '../screen/sidebar.dart';
class AddCharger extends StatefulWidget {
  const AddCharger({Key? key}) : super(key: key);

  @override
  State<AddCharger> createState() => _AddChargerState();
}

class _AddChargerState extends State<AddCharger> {
  late Position userLocation;
  late GoogleMapController mapController;
  List <Marker> myMarker =[];

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
      onTap: () {});










  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        title: Text(
          'Add New Charger',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),

        ),

      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _getLocation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                  // markers: Set<Marker>.of([newMarker]),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onTap: handleTap,
                  markers: Set.from(myMarker),
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
          // GoogleMap(
          //   initialCameraPosition: CameraPosition(target: LatLng(13.726862,100.76644),zoom: 17.85),
          //   onTap: handleTap,
          //   markers: Set.from(myMarker),
          // ),
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
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => QRCodeScannerPage()));
                  //   },
                  //   child: Icon(
                  //     Icons.qr_code_scanner,
                  //     size: 30,
                  //     color: Palette.backgroundColor,
                  //   ),
                  // )
                  // GoogleMap(
                  //   initialCameraPosition: CameraPosition(target: LatLng(13.726862,100.76644)),
                  //   onTap: handleTap,
                  //   markers: Set.from(myMarker),
                  // ),

                ],
              ),
            ),
          ),
        ],

      ),

    );
  }
  handleTap(LatLng tappedPoint){
    setState(() {
      myMarker = [];
      myMarker.add(
          Marker(markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            draggable: true,
            onDragEnd: (dragEndPosition){
              print(dragEndPosition);
            }
          )
      );

    });
  }
}
