import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/addChrgerDetail.dart';

class AddCharger extends StatefulWidget {
  const AddCharger({Key? key}) : super(key: key);

  @override
  State<AddCharger> createState() => _AddChargerState();
}

class _AddChargerState extends State<AddCharger> {
  late Position userLocation;
  late GoogleMapController mapController;
  List<Marker> myMarker = [];

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
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        title: Text(
          'Add New Charger',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Palette.backgroundColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        height: 100,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ChargerDetail()));
          },
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Add Details",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Palette.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker = [
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          },
        ),
      ];

      // Print the latitude and longitude of the tapped location
      print(tappedPoint);
    });
  }
}
