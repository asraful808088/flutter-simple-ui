import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:megawallet/components/opoup/box.dart';
import 'package:megawallet/data/auth/authdata.dart';
import 'package:megawallet/pages/auth/forgot/forgot.dart';
import 'package:megawallet/pages/auth/login/login.dart';
import 'package:megawallet/pages/auth/signup/signup.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  late double width;
  late double height;
  late double margin;
  Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Responsive valueOfItems = responsive(height: height, width: width);

    return ChangeNotifierProvider(
      create: (context) => AuthData(),
      child: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background/loginbackgroud.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              body: Builder(builder: (context) {
                return PopUpBox(
                  child: FractionallySizedBox(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: valueOfItems.width,
                              padding:
                                  EdgeInsets.only(left: 10, top: height * .12),
                              margin: EdgeInsets.only(
                                  top: valueOfItems.margin!,
                                  bottom: valueOfItems.margin!),
                              child: Builder(builder: (context) {
                                final index = context.watch<AuthData>().index;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      index == 0
                                          ? "assets/text/login.png"
                                          : index == 1
                                              ? "assets/text/Signup.png"
                                              : "assets/text/fa.png",
                                      height: valueOfItems.logo!,
                                    )
                                  ],
                                );
                              }),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/background/subbg.png"),
                                      fit: BoxFit.cover)),
                              width: valueOfItems.width,
                              height: valueOfItems.height,
                              child: Builder(builder: (context) {
                                final index = context.watch<AuthData>().index;
                                return index == 0
                                    ? Login()
                                    : index == 1
                                        ? Signup()
                                        : Forgot();
                              }),
                            ),
                            Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    top: valueOfItems.margin!,
                                    bottom: valueOfItems.margin!),
                                width: valueOfItems.width,
                                child: Builder(builder: (context) {
                                  final dataProvite = context.watch<AuthData>();
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ImageButton(
                                          image: "assets/logo/${dataProvite.index == 0 ?"forgot.png":dataProvite.index == 1 ?"login.png":dataProvite.index == 2 ?"login.png":"" }",
                                          onPressed: () {
                                            if (dataProvite.index == 0) {
                                              //forgot
                                              dataProvite.changePage(index: 2);
                                            } else if (dataProvite.index == 1) {
                                              // login
                                              dataProvite.changePage(index: 0);
                                            } else if (dataProvite.index == 2) {
                                              //login
                                              dataProvite.changePage(index: 0);
                                            }
                                          }),
                                      ImageButton(
                                          image: "assets/logo/${ dataProvite.index == 0 ?"create.png":dataProvite.index == 1 ?"forgot.png":dataProvite.index == 2 ?"create.png":""}",
                                          onPressed: () {
                                            if (dataProvite.index == 0) {
                                              //userCreate
                                               dataProvite.changePage(index: 1);
                                            } else if (dataProvite.index == 1) {
                                              //forgot
                                               dataProvite.changePage(index: 2);
                                            } else if (dataProvite.index == 2) {
                                              // userCreate
                                               dataProvite.changePage(index: 1);

                                            }
                                          })
                                    ],
                                  );
                                }))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }

  Widget ImageButton(
      {Widget? icon,
      String? image,
      double? height,
      double? width,
      required Function onPressed}) {
    return Container(
      height: height ?? 50,
      width: width ?? 50,
      child: Material(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        child: IconButton(
            onPressed: () {
              onPressed();
            },
            focusColor: Colors.transparent,
            color: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: icon ??
                Image(
                  image: AssetImage(image!),
                  fit: BoxFit.cover,
                )),
      ),
    );
  }

  Responsive responsive({required double height, required double width}) {
    //target 500
    late double widthValue;
    late double heightValue;
    late double transform;
    late double margin;
    late double logo;
    if ((width > 500 && height < 700) || width > 700) {
      widthValue = 500;
      heightValue = 500;
      logo = 70;
      margin = 10;
      transform = 0;
      return Responsive(
          height: heightValue,
          width: widthValue,
          margin: margin,
          transform: transform,
          logo: logo);
    } else {
      heightValue = height * .5;
      widthValue = width;
      logo = height * .1;
      margin = height * .01;
      transform = ((heightValue + (margin * 4) + logo) / 4);
      return Responsive(
          height: heightValue,
          margin: margin,
          logo: logo,
          width: widthValue,
          transform: transform);
    }
  }
}

class Responsive {
  late double? height;
  late double? width;
  late double? margin;
  late double? transform;
  late double? logo;
  Responsive({this.height, this.margin, this.width, this.transform, this.logo});
}
