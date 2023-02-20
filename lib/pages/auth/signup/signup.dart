import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:megawallet/components/singleSizeOverflow/overFlow.dart';
import 'package:megawallet/components/text_input/input.dart';
import 'package:megawallet/controller/animation/controller.dart';
import 'package:megawallet/network/result.dart';
import "package:megawallet/network/signup.dart";


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  final TextInputControllers textInputs = TextInputControllers();
  File? _image;
  late AnimationControllTools slide;
   String? _imageName;
  late double stap = 0;
  final SignUpNetwork _signUpNetwork = SignUpNetwork();

  @override
  void initState() {
    slide = AnimationControllTools(
        controlHouse: this,
        duration: const Duration(milliseconds: 500),
        begin: 0,
        end: 1,
        curvesType: Curves.easeOutBack);
    super.initState();
  }

  void _imageLoad() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      if (_validImage(path: file.path)) {
        setState(() {
          textInputs.fileError = null;
          _image = file;
        });
      } else {
        setState(() {
          textInputs.fileError = "only jpg jpeg png file are accepted";
        });
      }
    }
  }

  bool _validImage({String? path}) {
    final ext = RegExp(
      r'(\.jpg|\.png|\.jpeg)$',
    );
    final fileName = RegExp(
      r'\w+(\.jpg|\.png|\.jpeg)$',
    );

    if (ext.firstMatch(path ?? "")?.group(0) != null) {
      _imageName = fileName.firstMatch(path ?? "")?.group(0);
      return true;
    } else {
      return false;
    }
  }

  void errorsClear() {
    setState(() {
      textInputs.nameError = null;
      textInputs.emailError = null;
      textInputs.passwordError = null;
      textInputs.co_password_Error = null;
      textInputs.fileError = null;
      textInputs.codeError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 80,
          width: 80,
          child: const Image(
            image: AssetImage("assets/logo/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        AnimatedBuilder(
            animation: slide.control,
            builder: (context, child) {
              return OverFlow(
                part: 4,
                height: 200,
                width: width * 4 ,
                index: slide.value,
                axis: Axis.horizontal,
                children: [
                  Container(
                    height: double.infinity,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextInput(
                            error: textInputs.nameError,
                            controller: textInputs.name,
                            hintText: "Enter Your Name",
                            isPasswordType: false,
                            labelText: "name",
                            prefixIcon: Icon(Icons.person)),
                        TextInput(
                            error: textInputs.emailError,
                            controller: textInputs.email,
                            hintText: "Enter Your Name",
                            isPasswordType: false,
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email)),
                      ],
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextInput(
                          error: textInputs.passwordError,
                          controller: textInputs.password,
                          hintText: "Enter Your Password",
                          isPasswordType: textInputs.passwordVisible!,
                          labelText: "Password",
                          passwordVisible: textInputs.passwordVisible,
                          prefixIcon: Icon(Icons.key),
                          activeSuffixIcon: true,
                          onPress: () {
                            setState(() {
                              textInputs.passwordVisible =
                                  textInputs.passwordVisible == true
                                      ? false
                                      : true;
                            });
                          },
                        ),
                        TextInput(
                           activeSuffixIcon: true,
                          error: textInputs.co_password_Error,
                          controller: textInputs.coPassword,
                          hintText: "Enter Your Co-Password",
                          isPasswordType: textInputs.Co_passwordVisible!,
                          passwordVisible: textInputs.Co_passwordVisible,
                          labelText: "Co-password",
                          prefixIcon: Icon(Icons.key),
                          onPress: () {
                            setState(() {
                              textInputs.Co_passwordVisible =
                                  textInputs.Co_passwordVisible == true
                                      ? false
                                      : true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: width > 700 ? 500 : width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                _imageLoad();
                              },
                              child: Ink(
                                child: Stack(
                                  children: [
                                    SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: _image == null
                                            ? Image.asset(
                                                "assets/logo/user.png")
                                            : Image.file(
                                                _image!,
                                                fit: BoxFit.cover,
                                              )),
                                    Visibility(
                                        visible: _image != null ? true : false,
                                        child: Positioned(
                                            top: 95,
                                            left: 95,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _image = null;
                                                });
                                              },
                                              icon: Image.asset(
                                                "assets/logo/cross.png",
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.cover,
                                              ),
                                            )))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                       Visibility( visible: textInputs.fileError !=null ? true:false, child: Text(textInputs.fileError.toString(),style: const  TextStyle(
                        color: Colors.red
                       ),))
                      ],
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextInput(
                            error: textInputs.codeError,
                            controller: textInputs.code,
                            hintText: "hash-code",
                            isPasswordType: false,
                            labelText: "hash-code",
                            prefixIcon: Icon(Icons.code)),
                      ],
                    ),
                  ),
                ],
              );
            }),
        Container(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                  if (stap > 0) {
                    slide.animationUpdate(begin: stap, end: stap - 1);
                    stap = stap - 1;
                  }
                },
                icon: const Icon(
                  Icons.navigate_before,
                  size: 30,
                  color: Color.fromARGB(255, 87, 87, 87),
                ),
              ),
              IconButton(
                onPressed: () async {
                  late Result result;
                  if (stap == 0) {
                    result = await _signUpNetwork.stap1(
                      name: textInputs.name.text,
                      email: textInputs.email.text,
                    );
                  } else if (stap == 1) {
                    result = await _signUpNetwork.stap2(
                      password: textInputs.password.text,
                      coPassword: textInputs.coPassword.text,
                    );
                  } else if (stap == 2) {
                    result = await _signUpNetwork.stap3(
                        image: _image, imageName: _imageName,
                        email: textInputs.email.text
                        
                        );
                  } else {
                    result = await _signUpNetwork.stap4(
                        name: textInputs.name.text,
                        email: textInputs.email.text,
                        code: textInputs.code.text,
                        password: textInputs.password.text,
                        image: _image);
                  }
                  if (result.success == true) {
                    errorsClear();
                    if (stap < 3) {
                      setState(() {
                        slide.animationUpdate(begin: stap, end: stap + 1);
                        stap = stap + 1;
                      });
                    }
                  } else {
                    errorsClear();
                    if (result.nameError != null) {
                      setState(() {
                        textInputs.nameError = result.nameError;
                      });
                    } else if (result.emailError != null) {
                      setState(() {
                        textInputs.emailError = result.emailError;
                      });
                    } else if (result.passwordError != null) {
                      setState(() {
                        textInputs.passwordError = result.passwordError;
                      });
                    } else if (result.co_password_Error != null) {
                      setState(() {
                        textInputs.co_password_Error = result.co_password_Error;
                      });
                    } else if (result.fileError != null) {
                      setState(() {
                        textInputs.fileError = result.fileError;
                      });
                    } else {
                      setState(() {
                        textInputs.codeError = result.codeError;
                      });
                    }
                  }
                },
                icon: const Icon(
                  Icons.navigate_next,
                  size: 30,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TextInputControllers {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController coPassword = TextEditingController();
  final TextEditingController code = TextEditingController();
  String? fileError;
  String? nameError;
  String? emailError;
  String? passwordError;
  String? codeError;
  String? co_password_Error;
  bool? passwordVisible = true;
  bool? Co_passwordVisible = true;
}
