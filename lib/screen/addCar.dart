import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/carBrands.dart';
import 'package:plugspot/data/carModels.dart';

class AddNewCar extends StatefulWidget {
  const AddNewCar({super.key});

  @override
  State<AddNewCar> createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {
  String _selectedButton = 'Select Car Brand';
  String _selectedModels = 'Select Model';
  void _updateSelectedButton(String newValue) {
    setState(() {
      _selectedButton = newValue;
    });
  }

  void _updateModelButton(String newValue) {
    setState(() {
      _selectedModels = newValue;
    });
  }

  List<String> brands = CarBrands.getBrands();
  List<List<String>> models = CarModels.getModels();

  int selectedIndex = 0;

  int selectedModelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        iconTheme: IconThemeData(
          color: Palette.backgroundColor,
        ),
        title: Text(
          "Add New Car",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: Palette.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.whiteBackgroundColor,
          border: Border.all(
            color: Palette.greyColor,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 3),
              blurRadius: 7,
              spreadRadius: 2,
              color: Palette.greyColor,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Car Brand",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                            height: 400.0,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      ListWheelScrollView(
                                        physics: FixedExtentScrollPhysics(),
                                        diameterRatio: 2,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                        },
                                        itemExtent: 50,
                                        children: [
                                          for (String brand in brands)
                                            Container(
                                              child: Text(
                                                brand,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 60,
                                        child: IgnorePointer(
                                          child: Center(
                                            child: Container(
                                              width: 400,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: 400,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _updateSelectedButton(
                                          brands[selectedIndex]);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Palette.yellowTheme,
                                    child: Text(
                                      "Confirm",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: Palette.backgroundColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 400,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Palette.greyColor),
                          color: Palette.whiteBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 3),
                              color: Palette.greyColor,
                              blurRadius: 4,
                              spreadRadius: 1.5,
                            ),
                          ]),
                      child: Text(
                        _selectedButton,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Palette.backgroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
