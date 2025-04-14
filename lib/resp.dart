import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proton/main.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
  {
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyDtslhfLdv8mj9SSAFzmFOxA6L4Nlpglk4",
        appId: "1:773717459757:web:54afab1d5430469d8c89a4",
        messagingSenderId: "773717459757",
        projectId: "proton17092000"));
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (BuildContext context, child) {
      return MaterialApp(
      title: 'Proton',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: const Loginpage(),
      );
}

    );

}
}