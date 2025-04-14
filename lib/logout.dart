import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Logout()));
}


class Logout extends StatefulWidget{
  const Logout({super.key});

  @override
  State<StatefulWidget> createState() {
    return LogoutState();
  }
}

class LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(body: Stack(children: [ Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('Assets/Images/b2.jpg'),fit: BoxFit.cover))),
    Center(
      child: SizedBox(height: 30.h,
        child: ElevatedButton(onPressed: (){ FirebaseAuth.instance.signOut().then((value) { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loginpage())); }); },
            child: Column(children: [ Text('Log out',style: TextStyle(fontFamily: 'SF compact',color: Colors.white70,fontSize: 18.sp),), ],)),
      ),
    )],),);

  }
}