import 'dart:async';

import 'package:flutter/material.dart';
import 'package:megawallet/controller/animation/controller.dart';

class Loading extends StatefulWidget {
  late bool loading = false;
  late bool ? loop = false;
  late double size;
   

  Loading({Key? key, required this.loading, required this.size, this.loop})
      : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationControllTools loading;
  late double? _animatedValue = 0;
  late bool animationUseInit = false;
  late Timer animationLoopTrack;
  late double size = widget.size;
  @override
  void initState() {
    loading = AnimationControllTools(
        controlHouse: this,
        duration: const Duration(seconds: 1),
        tweenSequence: true,
        animationSequence: [4, 3, 2, 1, 0],
        animationWeight: [10, 10, 10, 10]);
    if (widget.loading) {
      loading.start();
      animationUseInit = true;
    } else if (widget.loop!) {
      animationLoop();
    }
    super.initState();
  }

  @override
  void dispose() {
    loopClose();
    loading.close();
    super.dispose();
  }

  void animationLoop() {
    animationLoopTrack = Timer.periodic(const Duration(seconds: 1), (timer) {
      loading.animationReuse();
    });
  }

  void loopClose() {
    animationLoopTrack.cancel();
  }

  @override
  void didUpdateWidget(covariant Loading oldWidget) {
    if (oldWidget.loading != widget.loading && widget.loading) {
      if (widget.loading && animationUseInit == false) {
        loading.start();
      } else {
        loading.animationReuse();
      }
    }
    if (oldWidget.loop != widget.loop) {
      if (widget.loop == true) {
        animationLoop();
      } else {
        loopClose();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: loading.control,
        builder: (context, child) {
          if (loading.value.toInt() == 3) {
            _animatedValue = 4 - loading.value;
          } else if (loading.value.toInt() == 2) {
            _animatedValue = loading.value - 2;
          } else if (loading.value.toInt() == 1) {
            _animatedValue = 2 - loading.value;
          } else if (loading.value.toInt() == 0) {
            _animatedValue = loading.value - 0;
          }
          return Stack(
            children: [
              Transform.rotate(
                angle: ((3.1416*2)/4)*loading.value,
                child: Center(
                  child: Image(
                    image: const AssetImage(
                      "assets/circle.png",
                    ),
                    height: size,
                    width: size,
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset(((size / 2)*_animatedValue!) * .952, 0),
                  child: Image(
                    image: const AssetImage("assets/bit.png"),
                    height: size * .40,
                    width: size * .40,
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset((-(size / 2) * _animatedValue!) * .952, 0),
                  child: Image(
                    image: const AssetImage("assets/doller.png"),
                    height: size * .38,
                    width: size * .38,
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset(0, ((size / 2) * 1) * _animatedValue!),
                  child: Image(
                    image: const AssetImage("assets/eth.png"),
                    height: size * .45,
                    width: size * .45,
                  ),
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: Offset(0, (-(size / 2) * .952) *_animatedValue!),
                  child: Image(
                    image: const AssetImage("assets/lit.png"),
                    height: size * .45,
                    width: size * .45,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
