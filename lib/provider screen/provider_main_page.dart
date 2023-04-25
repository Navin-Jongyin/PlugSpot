import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/provider%20screen/provider_sidebar.dart';

import '../config/palette.dart';

class ProviderMainPage extends StatefulWidget {
  const ProviderMainPage({Key? key}) : super(key: key);

  @override
  State<ProviderMainPage> createState() => _ProviderMainPageState();
}

class _ProviderMainPageState extends State<ProviderMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ProviderSidebar(),
      appBar: AppBar(
          title: Text('Main Page',
              style:
                  GoogleFonts.montserrat(color: Palette.whiteBackgroundColor)),
          backgroundColor: Palette.yellowTheme,
          leading: InkWell(
            child: Icon(Icons.menu),
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          )),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking Request',
                  style: GoogleFonts.montserrat(
                      color: Palette.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 100, width: 400,
                  child: FloatingActionButton(
                    onPressed: (){},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Palette.yellowTheme,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
