import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'loadingdialogue.dart';
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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MaterialApp(home: Signup()));
}


class Signup extends StatefulWidget{
  const Signup({super.key});


  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup>{

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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  String errorMessage = '';
  final firestore = FirebaseFirestore.instance;
  get data => null;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold( body: Stack(children: [ Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('Assets/Images/b2.jpg'),fit: BoxFit.cover)),),
      SingleChildScrollView(child: Column(children: [ Center(child:
        Padding(padding: EdgeInsets.only(top: 150.h),
          child: SizedBox(height: 400.w,width: mediaQuery.size.width * 0.9,child: Container(decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.circular(20.r)),
           child: Padding(padding: EdgeInsets.only(bottom: 25.w),
             child: SingleChildScrollView(
               child: Column(children: [ Padding(padding: EdgeInsets.only(right: 180.w,top: 25.w,left: 20.w),
                           child: Text('Signup',style: TextStyle( fontFamily: 'SF compact', fontSize: 35.sp, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1 )),),

                SafeArea(child: Column(children: [ Padding(
                padding: EdgeInsets.only(left: 20.w,right: 20.w),
                  child: Form( key: _formKey,
                    child: Column(children: <Widget> [ SizedBox(height: mediaQuery.size.width * 0.17,
                      child: TextFormField(cursorColor: Colors.blue,cursorHeight: 17.w,cursorWidth: 10.w,decoration: ShapeOfBox().textInputDecoration('Username','Enter the username'),controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter your Username';
                          }
                          if(!RegExp("^[\\^]*[a-zA-Z]+[\\^]*[0-9]*[\\^]*").hasMatch(value)) {
                              return "Invali Username format";
                            }
                          else {
                            return null;
                          }
                        },textInputAction: TextInputAction.next,style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,fontFamily: 'SF compact')),
                    ),
                      Padding(padding: EdgeInsets.only(top: 5.w),
                        child: SizedBox(height: mediaQuery.size.width * 0.17,
                          child: TextFormField(cursorColor: Colors.blue,cursorHeight: 17.w,cursorWidth: 10.w,decoration: ShapeOfBox().textInputDecoration('Email','Enter your Email'),controller: _emailController,
                            validator: ( value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter the Email Address";
                              }
                              if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                return "Invalid Email format";
                              }
                              else {
                                firestore.collection("SI users").add({
                                  "Username" : _usernameController.text,
                                  "Email" : _emailController.text,
                                  "Password" : _passwordController.text,
                                });
                              }
                            },textInputAction: TextInputAction.next,style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,fontFamily: 'SF compact')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.w),
                        child: SizedBox(height: mediaQuery.size.width * 0.17,
                          child: TextFormField(obscureText: true,cursorColor: Colors.blue,cursorHeight: 17.w,cursorWidth: 10.w,decoration: ShapeOfBox().textInputDecoration( 'Password', 'Enter the Password',),controller: _passwordController,keyboardType: TextInputType.text,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Please Enter your Password";
                              }else{
                                //call function to check password
                                bool result = validatePassword(value);
                                if(result){
                                  // create account event
                                  return null;
                                }else{
                                  return " Password should be Standard";
                                }
                              }
                            } ,textInputAction: TextInputAction.next,style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,fontFamily: 'SF compact')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.w),
                        child: SizedBox(height: mediaQuery.size.width * 0.17,
                          child: TextFormField(obscureText: true,cursorColor: Colors.blue,cursorHeight: 17.w,cursorWidth: 10.w,decoration: ShapeOfBox().textInputDecoration( 'Confirm Password', 'Confirm the Password'),controller: _confirmpassController,keyboardType: TextInputType.text,
                            validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm your Password ';
                            }
                             else if(_passwordController.text!=_confirmpassController.text) {
                              return "Password do not match";
                            }else {
                              return null;
                            }
                            },textInputAction: TextInputAction.go,style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035,fontFamily: 'SF compact')),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 7.h,left: 12.w),
                        child: Center( child: Text(errorMessage,style: const TextStyle(color: Colors.red),),),),
                    ],),
                  ),),],),),
    Padding(padding: EdgeInsets.only(top: 10.w,left: 20.w,right: 20.w),
      child: SizedBox(width: 380.w,height: 40.w,
        child: ElevatedButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loginpage()));},
          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.r))),backgroundColor: MaterialStateProperty.all<Color>(Colors.blue,),),
        child: FittedBox(child: Text('Back', style: TextStyle(color: Colors.white,fontFamily: 'SF compact', fontSize: 25.sp),)),
        ),
      ),
    )
               ],),
             ),
           ),),),),),



        Center(child: Padding(
          padding: EdgeInsets.only(top: 30.w),
          child: SizedBox(height: 90.w,width: 90.w, child: ElevatedButton(onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                 await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text)
                 .then((value) {
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
                  children: [ Container(padding: const EdgeInsets.all(16),height: 90,decoration: const BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(20)),),
                      child: Row( children: [ const SizedBox(width: 48,),Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ const Text("Oh snap!",style: TextStyle(fontFamily: 'SF compact',fontSize: 18,color: Colors.white),),const Spacer(),
                          Text(error.message!,style: const TextStyle(fontFamily: 'SF compact',fontSize: 14,color: Colors.white),maxLines: 2,overflow: TextOverflow.ellipsis,),],)),
                      ],
                      )),
                    Positioned(bottom: 0,child: ClipRRect( borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),child: SvgPicture.asset("Assets/Images/bubbles.svg",height: 48,width: 40,color: const Color(0xFF801336),))),
                    Positioned(top: -10,left: 0,child: Stack(alignment: Alignment.center,
                      children: [
                        SvgPicture.asset("Assets/Images/fail.svg",height: 40,),
                        Positioned(top: 10,child: SvgPicture.asset("Assets/Images/close.svg",height: 16,alignment: Alignment.center,))
                      ],
                    )),

                  ],
                ),behavior: SnackBarBehavior.floating,backgroundColor: Colors.transparent,elevation: 0,));


              }
              setState(() {});
            }

          },
            style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.r))),backgroundColor: MaterialStateProperty.all<Color>(Colors.blue,),),



            child:  Stack(
                  children: [
                    Center(
                      child: FittedBox(
                        child: Text('Sp', style: TextStyle(fontFamily: 'SF compact',
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,),),
                      ),
                    ),

                  ],
                ),

            ),
          ),
          ),
        ),

        SizedBox(height: 30.w,)



      ],),)
  ]));

  }

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
