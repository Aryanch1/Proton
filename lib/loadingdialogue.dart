import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'logout.dart';


Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MaterialApp(home: Loadingdialogue()));
}




class Loadingdialogue extends StatefulWidget {
  const Loadingdialogue({super.key});

  @override
  State<Loadingdialogue> createState() => Loadingdialoguestate();
}

class Loadingdialoguestate extends State<Loadingdialogue> {
  Timer? timer;
  int selectedIndex = 0;
  final chara = [ ];

  @override
  void initState() {
    // TODO: implement initStateh
    super.initState();
    Timer(const Duration(seconds: 5),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Logout())));
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(elevation: 0,backgroundColor: Colors.transparent,
          child: Column(mainAxisSize: MainAxisSize.min,
              children: [ Center(child: Lottie.asset('Assets/Lottie/an.json',alignment: Alignment.center),)])),
    );

  }
}