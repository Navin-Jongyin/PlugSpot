import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';
import 'package:plugspot/screen/accountSettings.dart';
import 'package:plugspot/screen/edit_profile.dart';
import 'package:plugspot/screen/LoginPage.dart';
import 'package:plugspot/screen/maps.dart';
import 'package:plugspot/data/cookie_storage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String data = '';
  int statusCode = 0;
  String responseBody = '';
  String userName = '';
  String? imageUrl;
  String? endpointUrl;
  String baseUrl = 'https://plugspot.onrender.com';
  String? userRole;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = 'https://plugspot.onrender.com/userAccount/currentuser';
    try {
      final cookie = await CookieStorage.getCookie(); // Retrieve the cookie
      print('Cookie: $cookie');
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie ?? ''},

        // Include the cookie in the headers
      );

      setState(() {
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          data = response.body;
          statusCode = response.statusCode;
          responseBody = response.body;
          print(data);
          print(response);
          print(statusCode);

          final jsonData = jsonDecode(responseBody);
          final role = jsonData['message']['Role'];
          final fullname = jsonData['message']['Fullname'];
          final imageUrl = jsonData['message'][
              'ProfileImage']; // Replace 'image_url' with the actual key for the image URL in the API response
          setState(() {
            this.imageUrl = endpointUrl;
          });
          endpointUrl = baseUrl + imageUrl.toString().replaceFirst('.', '');
          userName = fullname ?? '';
          userRole = role;

          print(userName);
          print('$imageUrl');
          print(endpointUrl);
          print(endpointUrl);
          print(userRole);
        } else {
          // Request failed, store the error code
          statusCode = response.statusCode;
        }
      });
    } catch (error) {
      // Error occurred during the request
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: CookieStorage.getCookie(), // Get the cookie asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.yellowTheme,
              title: const Text(
                "Profile",
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // If an error occurred while fetching the cookie, display an error message
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.yellowTheme,
              title: const Text("Profile", style: TextStyle()),
            ),
          );
        } else {
          // Cookie fetched successfully, check if it is null or empty
          final cookie = snapshot.data;
          final hasCookie = cookie != null && cookie.isNotEmpty;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  if (userRole == 'customer') {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MapSample(),
                      ),
                    );
                  } else if (userRole == 'provider') {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const BookingQueue(),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Palette.backgroundColor,
                ),
              ),
              backgroundColor: Palette.yellowTheme,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
              ],
              iconTheme: const IconThemeData(
                color: Palette.backgroundColor,
              ),
              title: Text(
                "Profile",
                style: GoogleFonts.montserrat(
                  color: Palette.backgroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -900,
                        left: -500,
                        right: -500,
                        child: Container(
                          height: 1000,
                          width: 1000,
                          decoration: const BoxDecoration(
                            color: Palette.yellowTheme,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                                blurRadius: 7.0,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Transform.translate(
                          offset: const Offset(0, 20),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                height: 130,
                                width: 130,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 2),
                                      blurRadius: 7.0,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: endpointUrl != null
                                      ? FadeInImage.assetNetwork(
                                          placeholder: 'images/avatarimage.png',
                                          image: endpointUrl!,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'images/avatarimage.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Text(
                                "$userName",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  color: Palette.backgroundColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasCookie)
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 30, 25, 15),
                    padding: const EdgeInsets.all(15),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Palette.whiteBackgroundColor,
                      border: Border.all(color: Palette.greyColor),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const EditProfile(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                color: Palette.yellowTheme,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Edit Profile",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Palette.backgroundColor,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Palette.yellowTheme,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (hasCookie)
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                    padding: const EdgeInsets.all(15),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Palette.whiteBackgroundColor,
                      border: Border.all(color: Palette.greyColor),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const AccountSetting(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.settings,
                                color: Palette.yellowTheme,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Account Settings",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Palette.backgroundColor,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Palette.yellowTheme,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
