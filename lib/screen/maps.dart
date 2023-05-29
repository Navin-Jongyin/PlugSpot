import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:plugspot/screen/timeSelection.dart';
import 'package:plugspot/screen/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late BuildContext modalContext;
  late Position userLocation;
  late GoogleMapController mapController;
  Set<Marker> _stationMarkers = {};
  int? stationId;
  String? stationName;

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
    getStation();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'images/marker.png',
    ).then(
      (icon) {
        setState(
          () {
            markerIcon = icon;
          },
        );
      },
    );
  }

  Future<void> getStation() async {
    final apiUrl = 'https://plugspot.onrender.com/station/getallstation';
    final cookie = await CookieStorage.getCookie();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List<dynamic> stations = responseData as List<dynamic>;

      _addMarkers(stations);
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }

  Future<void> _addMarkers(List<dynamic> stations) async {
    final markers = stations.map((station) {
      final stationId = station['ID'];
      final latitude = double.parse(station['Latitude']);
      final longitude = double.parse(station['Longitude']);
      final stationName = station['StationName'];
      final stationDetail = station['StationDetail'];
      final providerPhone = station['ProviderPhone'];
      final stationImageUrl = station['StationImage'];
      final userId = station['UserId'];

      return Marker(
        markerId: MarkerId(stationId.toString()),
        position: LatLng(latitude, longitude),
        icon: markerIcon,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeSelection(
                stationId: stationId,
                stationName: stationName,
                stationDetail: stationDetail,
                providerPhone: providerPhone,
                stationImageUrl: stationImageUrl,
                providerId: userId,
              ),
            ),
          );
        },
      );
    }).toSet();

    setState(() {
      _stationMarkers = markers;
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
                    target: LatLng(
                      userLocation.latitude,
                      userLocation.longitude,
                    ),
                    zoom: 17.85,
                  ),
                  markers: _stationMarkers,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
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
                          target: LatLng(
                            position.latitude,
                            position.longitude,
                          ),
                          zoom: 17.85,
                        ),
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
                    color: Palette.greyColor,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
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
                          fontSize: 16,
                          color: Palette.greyColor,
                        ),
                      ),
                      style: GoogleFonts.montserrat(
                        color: Palette.backgroundColor,
                      ),
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
