import "package:flutter/material.dart";

class OverFlow extends StatelessWidget {
  final double height;
  final double width;
  final List<Widget> children;
  final Axis axis;
  final int part;
  late double? index = 0;
  OverFlow(
      {Key? key,
      required this.height,
      required this.width,
      required this.children,
      required this.axis,
      required this.part,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Transform.translate(
            offset: Offset(
                -(width / part) * (Axis.horizontal == axis ? index! : 0),
                -height * (Axis.vertical == axis ? index! : 0)),
            child: SizedBox(
              height: height   * (axis==Axis.vertical? part:1) ,
              width: width     * (axis==Axis.horizontal? part:1)     ,
              child: axis == Axis.horizontal
                  ? Row(
                      children: children,
                    )
                  : Column(
                      children: children,
                    ),
            ),
          ),
        ));
  }
}
