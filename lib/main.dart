
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:proton/Signup.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'forgotpass.dart';
import 'loadingdialogue.dart';






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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MaterialApp(home: Loginpage()));
}

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  LoginpageState createState() => LoginpageState();

}



class LoginpageState extends State<Loginpage> {
  RegExp pass_Valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass){
    String password = pass.trim();
    if(pass_Valid.hasMatch(password)){
      return true;
    }else{
      return false;
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';
  final firestore = FirebaseFirestore.instance;
  get data => null;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var _mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: KeyboardDismisser( gestures: const [
        GestureType.onVerticalDragDown,
        GestureType.onTap,
      ],
        child: Scaffold(body: Stack(children: [
          Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('Assets/Images/b2.jpg'), fit: BoxFit.cover)),),
          SingleChildScrollView(child: Column(children: [ Center(child: Padding(padding: EdgeInsets.only(top: 200.h,),
            child: SizedBox(height: 370.w,width: _mediaQuery.size.width * 0.9,child: Container(decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(20.r)),
              child: Padding(padding: EdgeInsets.only(bottom: 18.w),
                child: SingleChildScrollView (physics: const BouncingScrollPhysics(),
                  child: Column(children: [ Padding(padding:  EdgeInsets.only(right: 200.w, top: 20.h,left: 20.w,), child: Text('Login',style: TextStyle(fontFamily: 'SF compact',fontSize: 35.sp, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1,)),),


                    SafeArea(
                      child: Form( key: _formKey,
                        child: Column(children: <Widget>[ Padding(padding: EdgeInsets.only(left: 20.w, right: 20.w,),
                          child: SizedBox(height: _mediaQuery.size.width * 0.17,
                            child: TextFormField(cursorColor: Colors.blue,cursorHeight: 17.w,cursorWidth: 10.w,decoration: ShapeOfBox().textInputDecoration('Email' ,'Enter your Email',), controller: _emailController,autofillHints: const [AutofillHints.email],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Email Address";
                                }
                                if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                  return "Invalid Email format";
                                }
                                else {
                                  return null;
                                }
                              },textInputAction: TextInputAction.next, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,fontFamily: 'SF compact'),
                            ),
                          ),),
                          Padding(padding: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
                            child: SizedBox(height: _mediaQuery.size.width * 0.17,
                              child: TextFormField( obscureText: true,cursorColor: Colors.blue,cursorHeight: 17.w,cursorWidth: 10.w,decoration: ShapeOfBox().textInputDecoration('Password', 'Enter Password',), controller: _passwordController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Please Enter your Password";
                                  }else{
                                    //call function to check password
                                    bool result = validatePassword(value);
                                    if(result){
                                      // create account event
                                      return null;
                                    }else{
                                      return "Password should be Standard";
                                    }
                                  }
                                } ,textInputAction: TextInputAction.done,style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,fontFamily: 'SF compact'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.h,left: 17.w),
                            child: Center(
                              child: Text(errorMessage,style: const TextStyle(color: Colors.red),),
                            ),
                          ),


                        ],),
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 235.w,right: 20.w),
                      child:  ElevatedButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Forpass()));},
                        style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),backgroundColor: MaterialStateProperty.all<Color>(Colors.blue,),),
                        child: FittedBox(child: AutoSizeText('Fp', style: TextStyle(color: Colors.white,fontFamily: 'SF compact', fontSize: 14.sp,fontWeight: FontWeight.bold),)),),
                    ),



                    Padding(padding: EdgeInsets.only(top: 20.w,left: 20.w,right: 20.w,), child: SizedBox( height: 40.w, width: 275.w,
                        child: ElevatedButton(onPressed: ()
                        {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Signup()));},
                          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.r))),backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue, // Change this color to the desired color
                          ),),
                          child: Text('Create an account', style: TextStyle(color: Colors.white,fontFamily: 'SF compact', fontSize: 20.sp),),)),
                    ),
                  ],
                  ),
                ),

              ),),),
          ),),



            Center(child: Padding(
              padding: EdgeInsets.only(top: 30.w),
              child: SizedBox(height: 90.w, width: 90.w,
                child: ElevatedButton(onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      firestore.collection("LI users").add({

                        "Email" : _emailController.text,
                        "Password" : _passwordController.text,
                      });
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text).
                      then((value) {
                        showDialog(
                            context: context,
                            builder: (context){
                              return const Loadingdialogue();
                            });
                      });
                      errorMessage = '';
                    } on FirebaseAuthException catch (error)
                    {



                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Stack(clipBehavior: Clip.none,
                        children: [ Container(padding: const EdgeInsets.all(16),height: 90.h,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(20.r)),),
                            child: Row( children: [ SizedBox(width: 48.w,),Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [ Text("Oh snap!",style: TextStyle(fontFamily: 'SF compact',fontSize: 18.sp,color: Colors.white),),
                                Text(error.message!,style: TextStyle(fontFamily: 'SF compact',fontSize: 14.sp,color: Colors.white),maxLines: 2,overflow: TextOverflow.ellipsis,),],)),
                            ],
                            )),
                          Positioned(bottom: 0,child: ClipRRect( borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r)),child: SvgPicture.asset("Assets/Images/bubbles.svg",height: 48.h,width: 40.w,color: const Color(0xFF801336),))),
                          Positioned(top: -10,left: 0,child: Stack(alignment: Alignment.center,
                            children: [
                              SvgPicture.asset("Assets/Images/fail.svg",height: 40.h,),
                              Positioned(top: 10,child: SvgPicture.asset("Assets/Images/close.svg",height: 16.h,))
                            ],
                          )),

                        ],
                      ),behavior: SnackBarBehavior.floating,backgroundColor: Colors.transparent,elevation: 0,));


                    }
                    setState(() {});
                  }

                },

                  style: ButtonStyle(shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200.r))),backgroundColor: MaterialStateProperty.all<Color>(Colors.blue,),),



                        child: Center(
                          child: FittedBox(
                            child: Text('Li', style: TextStyle(fontFamily: 'SF compact',
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              ),),
                          ),
                        ),






                ),
              ),
            ),
            ),
            SizedBox(height: 30.h,)


          ],),),


        ],),
        ),
      ),
    );
  }


}




Future<bool> _onBackButtonPressed(BuildContext context) async {
  bool? exitApp = await showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(backgroundColor: Colors.black  ,
          title: const Text("Hey 😥",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'SF compact')),
          content: const Text("Can i wait for your Presence?",style: TextStyle(color: Colors.white,fontFamily: 'SF compact'),),
          actions: <Widget> [
            TextButton(onPressed: () {
              Navigator.of(context).pop(false);
            },
              child: const Text("No",style: TextStyle(fontSize: 20.0,color: Colors.blue,fontFamily: 'SF compact'),),
            ) ,
            TextButton(onPressed: () {
              Navigator.of(context).pop(true);
            },
              child: const Text("Yes",style: TextStyle(fontSize: 15.0,color: Colors.blue,fontFamily: 'SF compact')),
            )
          ],
        );

      }
  );
  return exitApp ?? false;
}









class ShapeOfBox {
  get labelStyle => TextStyle(fontSize: 15.sp,fontFamily: 'SF compact',);

  get hintStyle => TextStyle(fontSize: 15.sp,fontFamily: 'SF compact',);






  InputDecoration textInputDecoration([String lableText = "", String hintText = "" ,]) {


    return InputDecoration(
      hintStyle: hintStyle,
      labelStyle: labelStyle,
      labelText: lableText,
      errorStyle: TextStyle(fontSize: 12.sp,color: Colors.red,fontFamily: 'SF compact',),

      hintText: hintText,
      fillColor: Colors.transparent,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 5.w),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: Colors.grey,width: 2.w,),),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide(color: Colors.grey.shade200,width: 2.w)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r),borderSide:  BorderSide(color: Colors.red,width: 2.w),),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r),borderSide:  BorderSide(color: Colors.red, width: 2.w),),


    );
  }
}





