import "package:flutter/material.dart";
import 'package:megawallet/components/singleSizeOverflow/overFlow.dart';
import 'package:megawallet/components/text_input/input.dart';
import 'package:megawallet/controller/animation/controller.dart';
import "package:megawallet/network/forgot.dart";
import 'package:megawallet/network/result.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> with TickerProviderStateMixin {
  late AnimationControllTools slide;
  final TextInputControllers textInputs = TextInputControllers();
  late double stap = 0;
  final ForgotNetwork _network = ForgotNetwork();
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

  void errorsClear() {
    setState(() {
      textInputs.secretCodeError = null;
      textInputs.emailError = null;
      textInputs.passwordError = null;
      textInputs.co_password_Error = null;
      textInputs.fileError = null;
      textInputs.hash_code_error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 80,
            width: 80,
            child: const Image(
              image: AssetImage("assets/logo/forgot.png"),
              fit: BoxFit.cover,
            ),
          ),
          AnimatedBuilder(
              animation: slide.control,
              builder: (context, child) {
                return OverFlow(
                  part: 3,
                  height: 200,
                  width: width * 3,
                  index: slide.value,
                  axis: Axis.horizontal,
                  children: [
                    Container(
                      height: double.infinity,
                      width: width > 700 ? 500 : width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextInput(
                              controller: textInputs.secretCode,
                              hintText: "secret-code",
                              isPasswordType: false,
                              labelText: "secret-code",
                              error: textInputs.secretCodeError,
                              prefixIcon: Icon(Icons.security)),
                          TextInput(
                              controller: textInputs.email,
                              hintText: "Enter Your Name",
                              isPasswordType: false,
                              labelText: "email",
                              error: textInputs.emailError,
                              prefixIcon: Icon(Icons.email)),
                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: width > 700 ? 500 : width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextInput(
                            error: textInputs.passwordError,
                            controller: textInputs.password,
                            hintText: "Enter Your Password",
                            isPasswordType: true,
                            labelText: "Password",
                            passwordVisible: true,
                            prefixIcon: Icon(Icons.key),
                          ),
                          TextInput(
                            error: textInputs.co_password_Error,
                            controller: textInputs.coPassword,
                            hintText: "Enter Your Co-Password",
                            isPasswordType: true,
                            passwordVisible: true,
                            labelText: "Co-Password",
                            prefixIcon: Icon(Icons.key),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: width > 700 ? 500 : width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           TextInput(
                            error: textInputs.hash_code_error,
                            controller: textInputs.hashcode,
                            hintText: "#code",
                            isPasswordType: false,
                            labelText: "#code",
                            prefixIcon: Icon(Icons.code),
                          ),
                          TextInput(
                            error: textInputs.tokenError,
                            controller: textInputs.token,
                            hintText: "Token",
                            isPasswordType: false,
                            labelText: "Token",
                            prefixIcon: Icon(Icons.token),
                          ),
                         
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
                  onPressed: () {
                    if (stap > 0) {
                      setState(() {
                        slide.animationUpdate(begin: stap, end: stap - 1);
                        stap = stap - 1;
                      });
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
                      result = await _network.stap1(
                        secretCode: textInputs.secretCode.text,
                        email: textInputs.email.text,
                      );
                    } else if (stap == 1) {
                      result = await _network.stap2(
                        password: textInputs.password.text,
                        coPassword: textInputs.coPassword.text,
                        email: textInputs.email.text,
                      );
                    } else {
                      result = await _network.stap3(
                        email: textInputs.email.text,
                        code: textInputs.hashcode.text,
                        token: textInputs.token.text,
                        password: textInputs.password.text,
                      );
                    }
                    print(result.success);
                    if (result.success == true) {
                      errorsClear();
                      if (stap < 2) {
                        setState(() {
                          slide.animationUpdate(begin: stap, end: stap + 1);
                          stap = stap + 1;
                        });
                      }
                    } else {
                      errorsClear();
                      if (result.nameError != null) {
                        setState(() {
                          textInputs.secretCodeError = result.secretError;
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
                          textInputs.co_password_Error =
                              result.co_password_Error;
                        });
                      } else if (result.tokenError != null) {
                        setState(() {
                          textInputs.tokenError = result.tokenError;
                        });
                      } else {
                        setState(() {
                          textInputs.hash_code_error = result.codeError;
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
      ),
    );
  }
}

class TextInputControllers {
  final TextEditingController secretCode = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController coPassword = TextEditingController();
  final TextEditingController hashcode = TextEditingController();
  final TextEditingController token = TextEditingController();
  String? fileError;
  String? secretCodeError;
  String? emailError;
  String? passwordError;
  String? co_password_Error;
  String? hash_code_error;
  String? tokenError;
}
