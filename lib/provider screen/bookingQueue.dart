import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/data/cookie_storage.dart';
import 'package:plugspot/provider%20screen/provider_sidebar.dart';
import 'package:plugspot/provider%20screen/startCharging.dart';
// import 'package:plugspot/provider%20screen/startCharging.dart';
import '../config/palette.dart';

class Contract {
  final String customerName;
  final String stationName;
  final int timeSlot;
  final DateTime bookingDate;
  final String carPlate;
  final String status;
  final int contractId;

  Contract({
    required this.customerName,
    required this.stationName,
    required this.timeSlot,
    required this.bookingDate,
    required this.carPlate,
    required this.status,
    required this.contractId,
  });
}

class BookingQueue extends StatefulWidget {
  const BookingQueue({Key? key}) : super(key: key);

  @override
  State<BookingQueue> createState() => _BookingQueueState();
}

class _BookingQueueState extends State<BookingQueue> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Contract> contracts = [];

  @override
  void initState() {
    super.initState();
    getAllContract();
  }

  Future<void> getAllContract() async {
    final apiUrl = "https://plugspot.onrender.com/contract/getusercontract";
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );

    setState(() {
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        setState(() {
          contracts = responseData
              .map((item) => Contract(
                    customerName: item['customerName'],
                    stationName: item['stationName'],
                    timeSlot: item['timeSlot'],
                    carPlate: item['carPlate'],
                    contractId: item['contractId'],
                    bookingDate:
                        DateTime.tryParse(item['date']) ?? DateTime.now(),
                    status: item['status'],
                  ))
              .toList();
        });

        // Print the fetched data
        contracts.forEach((contract) {
          print('Customer Name: ${contract.customerName}');
          print('Station Name: ${contract.stationName}');
          print('Time Slot: ${contract.timeSlot}');
          print('Booking Date: ${contract.bookingDate}');
          print('Car Plate: ${contract.carPlate}');
          print('Status: ${contract.status}');
          print('Time Range: ${getTimeRange(contract.timeSlot)}');
          print('-----------------------------------');
        });
      } else {
        print(response.statusCode);
        print(response.body);
      }
    });
  }

  String getTimeRange(int timeSlot) {
    if (timeSlot < 1 || timeSlot > 12) {
      return "Invalid Time Slot";
    }

    int startHour = 7 + timeSlot;
    int endHour = 8 + timeSlot;

    String startTime = startHour.toString().padLeft(2, '0') + ":00";
    String endTime = endHour.toString().padLeft(2, '0') + ":00";

    return "$startTime - $endTime";
  }

  void navigateToStartCharging(Contract contract) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => StartCharging(
          contract: contract,
        ),
      ),
    );
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView.builder(
          itemCount: contracts.length,
          itemBuilder: (context, index) {
            final contract = contracts[index];

            // Check if the contract status is 'in queue'
            if (contract.status == 'in queue') {
              return GestureDetector(
                onTap: () {
                  navigateToStartCharging(contract);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      'Name: ${contract.customerName}',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Car Plate: ${contract.carPlate}',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Booking Time: ${getTimeRange(contract.timeSlot)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Booking Date: ${contract.bookingDate.toString().substring(0, 10)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text('Status: ${contract.status}')
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Return an empty container for contracts not 'in queue'
              return Container();
            }
          },
        ),
      ),
    );
  }
}
