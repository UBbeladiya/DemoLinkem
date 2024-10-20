import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_truecaller_auth/Constant.dart';
import 'package:flutter_truecaller_auth/Widget/ButtonUi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import 'CreateProfile.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  //TrueCallerAuthService trueCallerAuthService = TrueCallerAuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  double? latitude;

  double? longitude;


  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if(user != null){
        Fluttertoast.showToast(msg: '${user.email}',toastLength: Toast.LENGTH_SHORT);
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProfileWidget(email:user.email),));
      }

      // Use the user object for further operations or navigate to a new screen.
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_SHORT,backgroundColor: errorColor);
      print(e.toString());
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    print("My URl =  ${BASEURL}");
  }
  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        print("latitude $latitude longitude $longitude");
      });
    } catch (e) {
      setState(() {
        Fluttertoast.showToast(msg: "Error: $e",backgroundColor: errorColor,toastLength: Toast.LENGTH_LONG);
      });
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        String locationMessage = 'Location services are disabled. Please enable the services';
        Fluttertoast.showToast(msg: locationMessage,backgroundColor: errorColor,toastLength: Toast.LENGTH_LONG);
      });
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          openAppSettings();
        });
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        openAppSettings();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: secondaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: size.width/1,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: (){
              signInWithGoogle();
            },child: LoginButton(size:size),),
          )
/*
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24),
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
                icon: Image.network(
                  "https://w7.pngwing.com/pngs/314/17/png-transparent-truecaller-android-telephone-phone-blue-telephone-call-mobile-phones.png",
                  width: 30,
                  height: 30,
                ),
                onPressed: () {

                  //  trueCallerAuthService.startVerfication(context);
                },
                label: Text(
                  "Login With TrueCaller ".toUpperCase(),
                  style: const TextStyle(fontSize: 18),
                )),
          )*/
        ],
      ),
    );
  }

  @override
  void dispose() {
    //trueCallerAuthService.dispose();
    super.dispose();
  }

}
