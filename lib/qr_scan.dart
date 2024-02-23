import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:slovogram/data.dart';
import 'package:slovogram/main.dart';
import 'functions2.dart';
import 'provider.dart';

class QRScan extends StatefulWidget {
  const QRScan({ Key? key }) : super(key: key);

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  bool scanned = false;
  String scannedWord = '';

  @override
  void reassemble() async{
    super.reassemble();
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            QRView(
              key: qrKey, 
              onQRViewCreated: (controller){
                controller.scannedDataStream.listen((barcode) async { 
                  await controller.pauseCamera();
                  setState(() {
                    scannedWord = barcode.code!;
                    scanned=true;
                  });
                });
              },
              overlay: QrScannerOverlayShape(
                cutOutSize: MediaQuery.of(context).size.width*0.8,
                borderWidth: 10,
                borderLength: 20,
                borderRadius: 10,
                borderColor: sec
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.only(left: 32, bottom: 32, right: 32),
                color: sec,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () async {
                    if (scanned) {
                      scannedMultiWords(scannedWord.toUpperCase());
                      dt = DateTime.now();
                      multiMode = true;
                      multiWords2= multiWords.toList();
                      nextWord(multiWords[0]);
                      context.read<Provider0>().refresh();
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    }
                  },
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Center(
                      child: scanned?Text(
                        cyr?'Започни':'Započni',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: pri,
                          fontSize: 16
                        ),
                      ):Container(),
                    )
                  ),
                ),
              ),
            )
          ]
        )
      )
    );
  }
}