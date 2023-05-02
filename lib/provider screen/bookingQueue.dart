import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/provider%20screen/provider_sidebar.dart';

import '../config/palette.dart';

class BookingQueue extends StatefulWidget {
  const BookingQueue({super.key});

  @override
  State<BookingQueue> createState() => _BookingQueueState();
}

class _BookingQueueState extends State<BookingQueue> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ProviderSidebar(),
      appBar: AppBar(
        title: Text(
          'Booking Queue',
          style: GoogleFonts.montserrat(
            color: Palette.backgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.yellowTheme,
        leading: InkWell(
          child: Icon(
            Icons.menu,
            color: Palette.backgroundColor,
            size: 30,
          ),
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
    );
  }
}
