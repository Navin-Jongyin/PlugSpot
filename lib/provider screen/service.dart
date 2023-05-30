import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';
import 'package:plugspot/provider%20screen/end_charging.dart';

class Contract {
  final int contractId;
  final String customerName;
  final DateTime bookingDate;
  final String carPlate;
  final String status;
  final int timeSlot;

  Contract({
    required this.contractId,
    required this.customerName,
    required this.bookingDate,
    required this.carPlate,
    required this.status,
    required this.timeSlot,
  });
}

class OnGoingService extends StatefulWidget {
  const OnGoingService({Key? key}) : super(key: key);

  @override
  State<OnGoingService> createState() => _OnGoingServiceState();
}

class _OnGoingServiceState extends State<OnGoingService> {
  List<Contract> contracts = [];

  @override
  void initState() {
    super.initState();
    getContracts();
  }

  Future<void> getContracts() async {
    // Simulated data fetch
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      contracts = [
        Contract(
          contractId: 1,
          customerName: 'John Doe',
          bookingDate: DateTime.now(),
          carPlate: 'ABC123',
          status: 'On Going',
          timeSlot: 1,
        ),
        Contract(
          contractId: 2,
          customerName: 'Jane Smith',
          bookingDate: DateTime.now(),
          carPlate: 'DEF456',
          status: 'On Going',
          timeSlot: 2,
        ),
        Contract(
          contractId: 3,
          customerName: 'Robert Johnson',
          bookingDate: DateTime.now(),
          carPlate: 'GHI789',
          status: 'On Going',
          timeSlot: 3,
        ),
      ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BookingQueue(),
              ),
            );
          },
        ),
        title: Text(
          'On Going',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Palette.backgroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: GestureDetector(
          child: ListView.builder(
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final contract = contracts[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => EndCharging(contract: contract),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  padding: EdgeInsets.all(15),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${contract.customerName}',
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Car Plate: ${contract.carPlate}',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Booking Date: ${contract.bookingDate.toString().substring(0, 10)}',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Time: ${getTimeRange(contract.timeSlot)}',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          '${contract.status.toUpperCase()}',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: (contract.status == 'in queue')
                                ? Colors.orange
                                : (contract.status == 'on going')
                                    ? Colors.blue
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
