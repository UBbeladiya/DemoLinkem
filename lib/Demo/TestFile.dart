// import 'package:flutter/material.dart';
// import 'package:truecaller_sdk/truecaller_sdk.dart';
// import 'dart:async';
//
// class TruecallerLoginWidget extends StatefulWidget {
//   @override
//   _TruecallerLoginWidgetState createState() => _TruecallerLoginWidgetState();
// }
//
// class _TruecallerLoginWidgetState extends State<TruecallerLoginWidget> {
//   StreamSubscription<TruecallerSdkCallback>? streamSubscription;
//   String? firstName;
//   String? lastName;
//   String? phoneNumber;
//   String? errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     initializeTruecaller();
//     setUpTruecallerStream();
//   }
//
//   Future<void> initializeTruecaller() async {
//     print("call initializeTruecaller");
//     try {
//       final result = await TruecallerSdk.initializeSDK(sdkOptions: TruecallerSdkScope.SDK_OPTION_WITHOUT_OTP);
//       print("SDK result =  $result");
//       if (result == TruecallerSdkCallbackResult.success) {
//         print('Truecaller SDK initialized successfully');
//       } else {
//         print('Failed to initialize Truecaller SDK');
//         setState(() {
//           errorMessage = 'Failed to initialize Truecaller SDK';
//         });
//       }
//     } catch (e) {
//       print('Error initializing Truecaller SDK: $e');
//       setState(() {
//         errorMessage = 'Error initializing Truecaller SDK: $e';
//       });
//     }
//   }
//
//   void setUpTruecallerStream() {
//     streamSubscription = TruecallerSdk.streamCallbackData.listen((callback) {
//       switch (callback.result) {
//         case TruecallerSdkCallbackResult.success:
//           handleSuccessfulVerification(callback);
//           break;
//         case TruecallerSdkCallbackResult.failure:
//           print("Error: ${callback.error?.code}");
//           setState(() {
//             errorMessage = "Truecaller error: ${callback.error?.message}";
//           });
//           break;
//         case TruecallerSdkCallbackResult.verification:
//         // Handle manual verification if needed
//           break;
//         default:
//           break;
//       }
//     });
//   }
//
//   Future<void> loginWithTruecaller() async {
//     try {
//       bool isUsable = await TruecallerSdk.isUsable;
//       if (isUsable) {
//         setState(() {
//           errorMessage = null; // Clear any previous error messages
//         });
//         final result = await TruecallerSdk.getProfile;
//         print("Truecaller result: $result");
//         if (result != TruecallerSdkCallbackResult.success) {
//           setState(() {
//             errorMessage = "Failed to get Truecaller profile. Please try again.";
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage = "Truecaller is not available on this device";
//         });
//       }
//     } catch (e) {
//       print('Error during Truecaller login: $e');
//       setState(() {
//         errorMessage = 'Error during Truecaller login: $e';
//       });
//     }
//   }
//
//   void handleSuccessfulVerification(TruecallerSdkCallback callback) {
//     final profile = callback.profile;
//     if (profile != null) {
//       setState(() {
//         firstName = profile.firstName;
//         lastName = profile.lastName;
//         phoneNumber = profile.phoneNumber;
//         errorMessage = null; // Clear any previous error messages
//       });
//       // Here you would typically send this information to your backend
//       // to authenticate the user or create a new account
//     } else {
//       setState(() {
//         errorMessage = "Failed to retrieve profile information";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Truecaller Login'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (firstName != null)
//               Text('Welcome, $firstName $lastName!', style: TextStyle(fontSize: 20))
//             else
//               ElevatedButton(
//                 onPressed: loginWithTruecaller,
//                 child: Text('Login with Truecaller'),
//               ),
//             SizedBox(height: 20),
//             if (phoneNumber != null)
//               Text('Phone: $phoneNumber', style: TextStyle(fontSize: 16)),
//             if (errorMessage != null)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   errorMessage!,
//                   style: TextStyle(color: Colors.red),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     streamSubscription?.cancel();
//     super.dispose();
//   }
// }