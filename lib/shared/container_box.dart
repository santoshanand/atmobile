import 'package:flutter/material.dart';

class ContainerBox extends StatelessWidget {
  const ContainerBox({
    Key? key,
    required this.color,
    required this.child,
    this.padding,
    this.margin,
    this.height,
  }) : super(key: key);
  final Color color;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: padding,
      margin: margin,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        color: color,
      ),
    );
  }
}
