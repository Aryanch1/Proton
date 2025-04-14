import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'main.dart';



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
  runApp(const MaterialApp(home: Forpass()));
}


class Forpass extends StatefulWidget{
  const Forpass({super.key});


  @override
  State<StatefulWidget> createState() {
    return ForpassState();
  }
}

class ForpassState extends State<Forpass>{
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass){
    String password = pass.trim();
    if(pass_valid.hasMatch(password)){
      return true;
    }else{
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  String Message = '';
  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(body: Stack(children: [ Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('Assets/Images/b2.jpg'),fit: BoxFit.cover)),),
      SingleChildScrollView(child: Column( children: [ Center(child: Padding(
        padding: EdgeInsets.only(top: 50.w,right: 270.w,left: 10.w),
        child: SizedBox(width: 60.w, height: 30.w, child: ElevatedButton(onPressed: () async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loginpage()));},
            style: ButtonStyle( shape: MaterialStateProperty.all<RoundedRectangleBorder>( RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)) ),backgroundColor: MaterialStateProperty.all<Color>(Colors.blue,),),
             child:  FittedBox(child: Text('B',style: TextStyle(fontFamily: 'SF compact',color: Colors.white, fontSize: 20.sp,))),),),),),

        Center(child: Padding( padding:  EdgeInsets.only(top: 130.w),
          child: SizedBox(height: 270.w,width: _mediaQuery.size.width * 0.9,child: Container(decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(20.r)),
              child: Column(
                children: [ Padding(padding: EdgeInsets.only(left: 40.w,right: 50.w,top: 40.w),
                  child: Text('You will receive a Email to Reset your password',style: TextStyle( fontFamily: 'SF compact', fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1 )),),



                  SafeArea(child: Column(
                    children: [ Padding( padding: EdgeInsets.only(left: 40.w,right: 40.w),
                      child: Form(key: _formKey,
                        child: Column(children: <Widget> [ SizedBox(height: _mediaQuery.size.width * 0.17,
                          child: TextFormField(cursorColor: Colors.blue,cursorHeight: 17.w,cursorWidth: 10.w,decoration: ShapeOfBox().textInputDecoration('Email','Enter your Email'),controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter the Email Address";
                              }
                              if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                return "Please Enter valid Email Address";
                              }
                              else {
                                return null;
                              }
                            },textInputAction: TextInputAction.done,style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,fontFamily: 'SF compact'),),),
                          Center( child: Text(errorMessage,style: const TextStyle(color: Colors.red),),),
                        ],),),
                    ),
                    ],
                  )),

                  Center(child: Padding(
                    padding: EdgeInsets.only(left: 40.w,right: 40.w),
                    child: SizedBox(height: 40.w, width: 250.w, child: ElevatedButton(onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text.trim());

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Stack(clipBehavior: Clip.none,
                            children: [ Container(padding: const EdgeInsets.all(16),height: 90.h,decoration: BoxDecoration(color: const Color(0xFF2d6a4f),borderRadius: BorderRadius.all(Radius.circular(20.r)),),
                                child:  Row( children: [ SizedBox(width: 48.w,),Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [  Text("Sent",style: TextStyle(fontFamily: 'SF compact',fontSize: 18.sp,color: Colors.white),),
                                    Text("Check your Email to reset your password",style: TextStyle(fontFamily: 'SF compact',fontSize: 15.sp,color: Colors.white),maxLines: 2,overflow: TextOverflow.ellipsis,),],)),
                                ],
                                )),
                              Positioned(bottom: 0.h,child: ClipRRect( borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r)),child: SvgPicture.asset("Assets/Images/bubbles.svg",height: 48.h,width: 40.w,color: const Color(0xFF1e4634),))),
                              Positioned(top: -16.h,left: 0.w,child: SvgPicture.asset("Assets/Images/fail.svg",height: 40.h,color: const Color(0xFF1e4634),)),

                            ],
                          ),behavior: SnackBarBehavior.floating,backgroundColor: Colors.transparent,elevation: 0,));

                        } on FirebaseAuthException catch (error)
                        {

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Stack(clipBehavior: Clip.none,
                            children: [ Container(padding: const EdgeInsets.all(16),height: 90.h,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(20.r)),),
                                  child: Row( children: [ SizedBox(width: 48.w,),Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [   Text("Oh snap!",style: TextStyle(fontFamily: 'SF compact',fontSize: 18.sp,color: Colors.white),),const Spacer(),
                                      Text(error.message!,style:  TextStyle(fontFamily: 'SF compact',fontSize: 14.sp,color: Colors.white),maxLines: 2,overflow: TextOverflow.ellipsis,),],)),
                                    ],
                                  )),
                              Positioned(bottom: 0.h,child: ClipRRect( borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r)),child: SvgPicture.asset("Assets/Images/bubbles.svg",height: 48.h,width: 40.w,color: const Color(0xFF801336),))),
                              Positioned(top: -16.h,left: 0.w,child: Stack(alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset("Assets/Images/fail.svg",height: 40.h,),
                                  Positioned(top: 10.h,child: SvgPicture.asset("Assets/Images/close.svg",height: 16.h,))
                                ],
                              )),

                            ],
                          ),behavior: SnackBarBehavior.floating,backgroundColor: Colors.transparent,elevation: 0,));
                        }
                        setState(() {});
                      }
                    },
                      style: ButtonStyle( shape: MaterialStateProperty.all<RoundedRectangleBorder>( RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),backgroundColor: MaterialStateProperty.all<Color>(Colors.blue,),),
                      child: AutoSizeText('Reset Password', maxLines: 1,style: TextStyle(color: Colors.white,fontFamily: 'SF compact', fontSize: 20.sp),textAlign: TextAlign.center,),


                    ),
                    ),
                  ),
                  ),

                ],
              )
          )),)),
        SizedBox(height: 20.w,)







        ],
        ),
      ),

    ],),);

  }


}




