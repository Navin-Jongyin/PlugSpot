import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/my_car.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        iconTheme: IconThemeData(
          color: Palette.backgroundColor,
        ),
        title: Text(
          "My Car",
          style: GoogleFonts.montserrat(
            color: Palette.backgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Text(
                "Add Your Car",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Palette.backgroundColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: 310,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Palette.greyColor, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text("Car Brand"),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Brand"),
                          Icon(Icons.arrow_drop_down_sharp)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text("Car Model"),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Model"),
                          Icon(Icons.arrow_drop_down_sharp)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text("Car Plate"),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "ex. 1กก1234",
                          hintStyle:
                              GoogleFonts.montserrat(color: Palette.greyColor)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        height: 50,
        width: 400,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCar(),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Save",
            style: GoogleFonts.montserrat(
                color: Palette.backgroundColor,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
