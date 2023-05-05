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

  int _notificationCount = 0;

  void _incrementNotificationCount() {
    setState(() {
      _notificationCount++;
    });
  }

  void _decrementNotification() {
    setState(() {
      _notificationCount--;
    });
  }

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
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Palette.backgroundColor,
                    size: 25,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                    child: Text(
                      '$_notificationCount',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          FloatingActionButton(
            onPressed: _incrementNotificationCount,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _decrementNotification,
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
