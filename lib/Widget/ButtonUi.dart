import 'package:flutter/material.dart';
import 'package:flutter_truecaller_auth/Constant.dart';


Widget LoginButton({required Size size}){
  return // Generated code for this Row Widget...
    Center(
      child: Container(
        height: 48,
        width: size.width / 1.5,
        decoration: BoxDecoration(
          color: primaryText,
            borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(Icons.email,size: 24,color: secondaryBackground,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text("Continue with Google"),
              )
              // FFButtonWidget(
              //   onPressed: () async {
              //     if (_model.textController.text != null &&
              //         _model.textController.text != '') {
              //       final phoneNumberVal = _model.textController.text;
              //       if (phoneNumberVal == null ||
              //           phoneNumberVal.isEmpty ||
              //           !phoneNumberVal.startsWith('+')) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text(
              //                 'Phone Number is required and has to start with +.'),
              //           ),
              //         );
              //         return;
              //       }
              //       await authManager.beginPhoneAuth(
              //         context: context,
              //         phoneNumber: phoneNumberVal,
              //         onCodeSent: (context) async {
              //           context.goNamedAuth(
              //             'SignIn',
              //             context.mounted,
              //             queryParameters: {
              //               'number': serializeParam(
              //                 _model.textController.text,
              //                 ParamType.String,
              //               ),
              //             }.withoutNulls,
              //             ignoreRedirect: true,
              //           );
              //         },
              //       );
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(
              //           content: Text(
              //             'Please enter your mobile number',
              //             style: TextStyle(
              //               color: FlutterFlowTheme.of(context).primaryText,
              //             ),
              //           ),
              //           duration: Duration(milliseconds: 4000),
              //           backgroundColor: FlutterFlowTheme.of(context).secondary,
              //         ),
              //       );
              //     }
              //   },
              //   text: 'Continue with Google',
              //   icon: Icon(
              //     Icons.phone_sharp,
              //     size: 15,
              //   ),
              //   options: FFButtonOptions(
              //     height: 48,
              //     padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
              //     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              //     color: FlutterFlowTheme.of(context).primaryText,
              //     textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              //       fontFamily: 'Readex Pro',
              //       color: FlutterFlowTheme.of(context).primaryBackground,
              //       letterSpacing: 0.0,
              //     ),
              //     elevation: 6,
              //     borderSide: BorderSide(
              //       color: Colors.transparent,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
}