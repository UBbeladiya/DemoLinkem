import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Constant.dart';
import '../../Services/CrearteProfileServices.dart';
import '../../Widget/HelpWidget.dart';

class CreateProfileWidget extends StatefulWidget {
  String? email;

  CreateProfileWidget({this.email});

  @override
  State<CreateProfileWidget> createState() => _CreateProfileWidgetState();
}

class _CreateProfileWidgetState extends State<CreateProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController techStackController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  bool isSendData = false;

  int _deviceVersion = 0;

  Future<void> _pickImage() async {
    // Check current status of permissions

    PermissionStatus storageStatus = await Permission.storage.status;
    if (_deviceVersion <= 29) {
      if (storageStatus.isGranted) {
        // Permissions are already granted, proceed with picking the image
        _getImage();
      } else {
        // Request permissions
        Map<Permission, PermissionStatus> statuses =
            await [Permission.storage].request();

        if (statuses[Permission.storage]!.isGranted) {
          // Permissions granted, proceed with picking the image
          _getImage();
        }

        if (statuses[Permission.storage]!.isDenied) {
          openAppSettings();
        }
      }
    } else {
      _getImage();
    }
  }

  Future<void> _getImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        print('Image picked: ${image.path}');
        setState(() {
          _image = File(image.path);
        });

        // Handle the picked image
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  void initState() {
    setState(() {
      emailController.text = widget.email.toString();
    });
    _getDeviceVersion();

    super.initState();
  }

  Future<void> _getDeviceVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    setState(() {
      _deviceVersion = androidInfo.version.sdkInt; // e.g., "10" or "11"
      print("_deviceVersion $_deviceVersion");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: secondaryBackground,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Create Your Profile',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 24,
                              letterSpacing: 0.0,
                              color: primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                            child: Text(
                                'Upload your photo & fill the details to create your profile.',
                                style: titleText(color: primaryText)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                              child: Text('Fields with an \nlater.',
                                  style: titleText(color: primaryText)),
                            ),
                            Text('* ', style: titleText(color: errorColor)),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                              child: Text('are mandatory & can\'t be edited',
                                  style: titleText(color: primaryText)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: size.width / 3,
                              height: size.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: primaryText)),
                              child: Center(
                                child: _image == null
                                    ? Icon(
                                        Icons.person_add_alt_1_rounded,
                                        color: Color(0xFFBDBDBD),
                                        size: 40,
                                      )
                                    : Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          /* Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: secondaryBackground,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xFFBDBDBD),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: IconButton(
                                  borderColor: Color(0x004B39EF),
                                  borderRadius: 20,
                                  borderWidth: 2,
                                  buttonSize: 40,
                                  fillColor: Color(0x004B39EF),
                                  hoverIconColor: secondaryText,
                                  icon: Icon(
                                    Icons.person_add_alt_1_rounded,
                                    color: Color(0xFFBDBDBD),
                                    size: 40,
                                  ),
                                  showLoadingIndicator: true,
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
                            ),
                          ),*/
                          InkWell(
                            onTap: () {
                              _pickImage();
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 10),
                                  child: Text(
                                    'Upload your photo here.',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF4D677B),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        size: 24,
                                        color: primaryText,
                                      ),
                                      Text(
                                        "Upload Photo",
                                        style: titleText(color: primaryText),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 36, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Full Name',
                                      style: titleText(color: primaryText),
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: titleText(color: errorColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: TextFormField(
                                controller: nameController,
                                autofocus: true,
                                obscureText: false,
                                decoration: TextFiledInputDecoration(
                                    hintText: "", labelText: "Full Name"),
                                style: titleText(color: primaryText),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name';
                                  }

                                  // Remove any leading or trailing whitespace
                                  value = value.trim();

                                  // Check if the name contains only letters, spaces, hyphens, and apostrophes
                                  if (!RegExp(r"^[a-zA-Z\s\-']+$")
                                      .hasMatch(value)) {
                                    return 'Name can only contain letters, spaces, hyphens, and apostrophes';
                                  }

                                  // Check if the name is between 2 and 50 characters long
                                  if (value.length < 2 || value.length > 50) {
                                    return 'Name must be between 2 and 50 characters long';
                                  }

                                  // Check if the name starts with a letter
                                  if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
                                    return 'Name must start with a letter';
                                  }

                                  return null;
                                },
                                onSaved: (name) {},
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Email',
                                      style: titleText(color: primaryText),
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: titleText(color: errorColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: TextFormField(
                                controller: emailController,
                                enabled: false,
                                autofocus: true,
                                obscureText: false,
                                decoration: TextFiledInputDecoration(
                                    hintText: '', labelText: "Email"),
                                style: titleText(color: primaryText),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Phone',
                                      style: titleText(color: primaryText),
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: titleText(color: errorColor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: TextFormField(
                                controller: phoneController,
                                autofocus: true,
                                obscureText: false,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                buildCounter: (BuildContext context,
                                    {int? currentLength,
                                    int? maxLength,
                                    bool? isFocused}) {
                                  return null; // Completely hide the counter
                                },
                                decoration: TextFiledInputDecoration(
                                    hintText: 'We Will Send OTP This Number',
                                    labelText: 'Phone'),
                                style: titleText(color: primaryText),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a number';
                                  } else if (int.tryParse(value) == null) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                                onSaved: (phone) {},
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Link',
                                      style: titleText(color: primaryText),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: TextFormField(
                                controller: linkController,
                                autofocus: true,
                                obscureText: false,
                                decoration: TextFiledInputDecoration(
                                    hintText:
                                        'Enter your link to showcase your work.',
                                    labelText: 'Link'),
                                style: titleText(color: primaryText),
                                onSaved: (link) {},
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Techstack',
                                      style: titleText(color: primaryText),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: techStackController,
                              autofocus: true,
                              obscureText: false,
                              decoration: TextFiledInputDecoration(
                                  hintText: 'Enter your skill',
                                  labelText: 'Techstack'),
                              style: titleText(color: primaryText),
                              onSaved: (tech) {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 40),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: !isSendData
                                  ? () async {
                                      if (_formKey.currentState!.validate() &&
                                          _image != null) {
                                        setState(() {
                                          isSendData = true;
                                        });
                                        Attendance()
                                            .getData(
                                                image: _image!.path,
                                                link: linkController.text,
                                                status:
                                                    techStackController.text,
                                                name: nameController.text,
                                                email: emailController.text)
                                            .then(
                                          (value) {
                                            setState(() {
                                              isSendData = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: "$value",
                                                backgroundColor: Colors.green,
                                                toastLength: Toast.LENGTH_LONG);
                                            log("massage $value");
                                          },
                                        ).onError(
                                          (error, stackTrace) {
                                            setState(() {
                                              isSendData = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: "$error",
                                                backgroundColor: errorColor,
                                                toastLength: Toast.LENGTH_LONG);

                                            log("error =  ${error.toString()}");
                                          },
                                        );
                                      } else {
                                        if (_image == null) {
                                          Fluttertoast.showToast(
                                              msg: "Set your profile pic",
                                              backgroundColor: errorColor,
                                              toastLength: Toast.LENGTH_LONG);
                                        }
                                      }
                                    }
                                  : null,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFF4D677B),
                                ),
                                child: Row(
                                  children: [
                                    isSendData
                                        ? Container(
                                            height: 30,
                                            width: 30,
                                            child: Center(
                                              child: LoadingAnimationWidget
                                                  .discreteCircle(
                                                //  leftDotColor: const Color(0xFF1A1A3F),
                                                //rightDotColor: const Color(0xFFEA3799),
                                                size: 30, color: primaryText,
                                              ),
                                            ))
                                        : Text(
                                            "Create",
                                            style:
                                                titleText(color: primaryText),
                                          )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {}
}
