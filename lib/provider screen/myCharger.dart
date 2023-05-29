import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:plugspot/provider%20screen/add_charger.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';
import 'package:plugspot/provider%20screen/editCharger.dart';

class MyCharger extends StatefulWidget {
  const MyCharger({Key? key}) : super(key: key);

  @override
  State<MyCharger> createState() => _MyChargerState();
}

class _MyChargerState extends State<MyCharger> {
  Station? station;
  bool hasData = false;
  int? stationID;
  int? userId;

  @override
  void initState() {
    super.initState();
    getUserId().then((id) {
      if (id != null) {
        userId = id;
        getStation();
      }
    });
  }

  Future<int?> getUserId() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/currentuser';
    final cookie = await CookieStorage.getCookie();

    final response =
        await http.get(Uri.parse(apiUrl), headers: {'Cookie': cookie ?? ""});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final id = data['message']['ID'];
      return id;
    }
    return null;
  }

  Future<void> getStation() async {
    final apiUrl = "https://plugspot.onrender.com/station/getuserstation";
    final cookie = await CookieStorage.getCookie();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final stationId = data['stationId'] as int;
      stationID = stationId;
      station = Station(
        stationName: data['stationName'],
        stationDetail: data['stationDetail'],
      );
      setState(() {
        hasData = true;
      });
    } else {
      print('Failed to fetch station data');
    }
  }

  Future<void> deleteStation() async {
    final apiUrl = "https://plugspot.onrender.com/station/deletestation";
    final cookie = await CookieStorage.getCookie();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm Delete",
            style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Palette.backgroundColor),
          ),
          content: Text(
            "Are you sure you want to delete this station?",
            style: GoogleFonts.montserrat(
                fontSize: 14, color: Palette.backgroundColor),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Palette.yellowTheme)),
              child: Text(
                "Cancel",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text(
                "Delete",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Palette.whiteBackgroundColor),
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                final response = await http.delete(
                  Uri.parse(apiUrl),
                  headers: {'Cookie': cookie ?? ""},
                  body: json.encode({
                    'userId': userId,
                    'stationId': stationID,
                  }),
                );

                if (response.statusCode == 200) {
                  print("Delete Successful");
                  print(response.body);

                  setState(() {
                    hasData = false;
                    station = null;
                  });
                } else {
                  print("Error ${response.statusCode}");
                  print(response.body);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Charger",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BookingQueue(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Palette.backgroundColor,
            )),
        backgroundColor: Palette.yellowTheme,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 25),
            child: Text(
              "One user can have one station at a time",
              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.red),
            ),
          ),
          Visibility(
            visible: hasData,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EditCharger(),
                  ),
                );
              },
              child: Container(
                height: 120,
                width: 400,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                decoration: BoxDecoration(
                  border: Border.all(color: Palette.greyColor),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${station?.stationName ?? ""}',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Address: ${station?.stationDetail ?? ""}',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deleteStation();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: FloatingActionButton(
          onPressed: hasData
              ? null
              : () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => AddCharger(),
                    ),
                  );
                },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: hasData ? Colors.grey : Palette.yellowTheme,
          child: Text(
            "Add New Charger",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Palette.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class Station {
  final String stationName;
  final String stationDetail;

  Station({
    required this.stationName,
    required this.stationDetail,
  });
}
