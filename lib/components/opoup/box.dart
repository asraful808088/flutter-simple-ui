import 'package:flutter/material.dart';
import 'package:megawallet/components/loading/loading.dart';
import 'package:megawallet/components/singleSizeOverflow/overFlow.dart';
import 'package:megawallet/controller/animation/controller.dart';
import 'package:megawallet/data/auth/authdata.dart';
import 'package:provider/provider.dart';


class PopUp extends StatefulWidget {
  late bool popUp = true;
  late GETDATA stage = GETDATA.PANDING;
  late String message = "Some Message";
  PopUp(
      {Key? key,
      required this.popUp,
      required this.message,
      required this.stage})
      : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> with TickerProviderStateMixin {
  late AnimationControllTools popUp;
  late bool popUpState = widget.popUp;
  late GETDATA success = widget.stage;
  @override
  void initState() {
    popUp = AnimationControllTools(
        controlHouse: this,
        duration: const Duration(milliseconds: 500),
        begin: 1,
        end: 0,
        curvesType: Curves.easeOutBack);

    super.initState();
  }

  @override
  void dispose() {
    popUp.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PopUp oldWidget) {
    if (oldWidget.popUp != widget.popUp) {
      if (widget.popUp) {
        popUp.animationUpdate(begin: 1, end: 0);
        setState(() {
          popUpState = true;
        });
      } else {
        popUp.animationUpdate(begin: 0, end: 1);
        setState(() {
          popUpState = false;
        });
      }
    }
    if (widget.stage != oldWidget.stage) {
      setState(() {
        success = widget.stage;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: popUp.control,
        builder: (context, child) {
          return Center(
            child: Transform.translate(
              offset: Offset(0, height * popUp.value),
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/background/dialog.png"),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: AnimatedBuilder(
                  animation: popUp.control,
                  builder: (context, child) {
                    return OverFlow(part: 3,
                      axis: Axis.horizontal,
                      height: 350,
                      index: success == GETDATA.PANDING
                          ? 1
                          : success == GETDATA.FAIL
                              ? 0
                              : 2,
                      width: 350,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 350,
                              width: 350,
                              color: Color.fromARGB(255, 221, 0, 0),
                            ),
                            Container(
                              height: 350,
                              width: 350,
                              child: Column(
                                children: [
                                  Container(
                                    height: 300,
                                    width: 300,
                                    child: Loading(
                                      loading: false,
                                      loop: popUpState == true &&
                                          success == GETDATA.PANDING,
                                      size: 200,
                                    ),
                                  ),
                                  Text(widget.message)
                                ],
                              ),
                            ),
                            Container(
                              height: 350,
                              width: 350,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

class PopUpBox extends StatelessWidget {
  const  PopUpBox({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [child, Builder(builder: (context) {
        final provider  = context.watch<AuthData>();
        
        return PopUp(stage: provider.stage,message: provider.message,popUp: provider.popup,);
      })],
    );
  }
}



enum GETDATA { PANDING, SUCCESS, FAIL }
