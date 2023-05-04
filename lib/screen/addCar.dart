import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/carBrands.dart';
import 'package:plugspot/data/carModels.dart';
import 'package:plugspot/screen/my_car.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  String _selectedBrand = "Select Brand";
  String _selectedModel = "Select Model";
  int _selectedBrandIndex = 0;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
                    child: Text(
                      "Car Brand",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 300,
                            child: ListView.builder(
                              itemCount: CarBrands.getBrands().length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(CarBrands.getBrands()[index]),
                                  onTap: () {
                                    setState(() {
                                      _selectedBrand =
                                          CarBrands.getBrands()[index];
                                      _selectedBrandIndex = index;
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.greyColor),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedBrand,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Palette.backgroundColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Palette.yellowTheme,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Car Model",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 300,
                            child: ListView.builder(
                              itemCount: CarBrands.getBrands().length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                      CarModels.getModels()[_selectedBrandIndex]
                                          [index]),
                                  onTap: () {
                                    setState(() {
                                      _selectedModel = CarModels.getModels()[
                                          _selectedBrandIndex][index];
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.greyColor),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedModel,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Palette.backgroundColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Palette.yellowTheme,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Car Plate",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.only(
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _textController,
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
