import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
       children: [
         Positioned(
           top: 60,
           left: 27,
           child: Row(
             children: [
               InkWell(
                 child: Container(
                   margin: EdgeInsets.only(right: 5),
                   height: 50,
                   width: 50,
                   decoration: BoxDecoration(
                     color: Palette.yellowTheme,
                     borderRadius: BorderRadius.circular(10),
                     boxShadow: [BoxShadow(
                         color: Palette.greyColor.withOpacity(0.5),
                         spreadRadius: 1.5,
                         blurRadius: 7,
                         offset: Offset(0,3)
                     ),
                     ],
                   ),
                   child: Icon(
                       Icons.menu,
                     size: 25,
                   ),
                 ),
               ),
               Container(
                 height: 50,
                 width: 285,
                 decoration: BoxDecoration(
                   color: Palette.whiteBackgroundColor,
                   borderRadius: BorderRadius.circular(10),
                     boxShadow: [BoxShadow(
                         color: Palette.greyColor.withOpacity(0.5),
                         spreadRadius: 1.5,
                         blurRadius: 7,
                         offset: Offset(0,3)
                     ),
                     ]
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextField(
                       decoration: InputDecoration(
                         hintText: "Search",
                         hintStyle: GoogleFonts.montserrat(
                           fontSize: 16,
                           fontWeight: FontWeight.w400,
                           color: Palette.greyColor
                         ),
                         prefixIcon: Icon(
                           Icons.search,
                           color: Palette.greyColor,
                         ),
                         border: InputBorder.none,
                         enabledBorder: InputBorder.none,
                         focusedBorder: InputBorder.none,
                         )
                       ),
                   ],
                 ),
                 ),
             ],
           ),
         ),
         Positioned(
           top: 610,
           right: 20,
           child: Column(
             children: [
               InkWell(
                 child: Container(
                   margin: EdgeInsets.only(bottom: 15),
                   height: 45,
                   width: 45,
                   decoration: BoxDecoration(
                     color: Palette.yellowTheme,
                     borderRadius: BorderRadius.circular(30),
                     boxShadow: [
                       BoxShadow(
                         color: Palette.greyColor,
                         spreadRadius: 1.5,
                         blurRadius: 7,
                         offset: Offset(0,3),
                       ),
                     ],
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       ImageIcon(
                         AssetImage(
                           'images/icon/setting.png',
                         ),
                         size: 20,
                       )
                     ],
                   ),
                 ),
               ),
               InkWell(
                 child: Container(
                   height: 45,
                   width: 45,
                   decoration: BoxDecoration(
                     color: Palette.yellowTheme,
                     borderRadius: BorderRadius.circular(30),
                     boxShadow: [
                       BoxShadow(
                         color: Palette.greyColor,
                         spreadRadius: 1.5,
                         blurRadius: 7,
                         offset: Offset(0,3),
                       ),
                     ],
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       ImageIcon(
                         AssetImage(
                           'images/icon/crosshair.png'
                         ),
                         size: 20,
                       ),
                     ],
                   ),
                 ),
               )
             ],
           ),
         ),
       ],
      ),
    );
  }
}
