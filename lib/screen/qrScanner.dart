import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/checkinScreen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrData = "";

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  bool scanned = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!scanned && scanData.code!.startsWith("PlugSpot:")) {
        scanned = true;
        qrData = scanData.code!;
        // If the QR code starts with the "PlugSpot:" prefix, navigate to another page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckIn(
              code: scanData.code!.substring(9),
              qrData: qrData,
            ),
          ),
        );
      } else if (!scanned) {
        scanned = true;
        // If the QR code does not start with the "PlugSpot:" prefix, show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Error",
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Invalid QR Code",
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    scanned = false;
                  },
                  child: Text(
                    "OK",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Palette.yellowTheme),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        elevation: 0,
        title: Text(
          "Check-in",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                _buildScanOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        final scanBoxSize = screenSize.width * 0.65;
        final topHeight = (constraints.maxHeight - scanBoxSize) / 2;

        return Stack(
          children: [
            // Top overlay
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: topHeight,
              child: Container(color: Palette.greyColor.withOpacity(0.7)),
            ),
            // Bottom overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: topHeight,
              child: Container(color: Palette.greyColor.withOpacity(0.7)),
            ),
            // Left overlay
            Positioned(
              top: topHeight,
              left: 0,
              width: (screenSize.width - scanBoxSize) / 2,
              height: scanBoxSize,
              child: Container(color: Palette.greyColor.withOpacity(0.7)),
            ),
            // Right overlay
            Positioned(
              top: topHeight,
              right: 0,
              width: (screenSize.width - scanBoxSize) / 2,
              height: scanBoxSize,
              child: Container(color: Palette.greyColor.withOpacity(0.7)),
            ),
            // Yellow frame
            Positioned(
              top: topHeight,
              left: (screenSize.width - scanBoxSize) / 2,
              width: scanBoxSize,
              height: scanBoxSize,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Palette.yellowTheme, width: 4.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _requestCameraPermission() async {
    await Permission.camera.request();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
