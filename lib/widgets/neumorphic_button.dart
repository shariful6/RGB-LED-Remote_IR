import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.padding = const EdgeInsets.all(15),
    required this.backgroundColor,
    this.borderRadius = 10.0,
    this.boxShape = BoxShape.rectangle,
    required this.bottomRightShadowColor,
    required this.topLeftShadowColor,
    this.bottomRightShadowBlurRadius = 3.0,
    this.bottomRightShadowSpreadRadius = 1.0,
    this.topLeftShadowBlurRadius = 3.0,
    this.topLeftShadowSpreadRadius = 1.0,
    required this.onTap,
    this.borderWidth = 1.0,
    this.borderColor,
    this.topLeftOffset = const Offset(-2, -2),
    this.bottomRightOffset = const Offset(2, 2),
  });

  final Widget child;
  final double width;
  final double height;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double borderRadius;
  final BoxShape boxShape;
  final Color bottomRightShadowColor;
  final Color topLeftShadowColor;
  final double bottomRightShadowBlurRadius;
  final double bottomRightShadowSpreadRadius;
  final double topLeftShadowBlurRadius;
  final double topLeftShadowSpreadRadius;
  final VoidCallback onTap;
  final Offset topLeftOffset;
  final Offset bottomRightOffset;
  final double borderWidth;
  final Color? borderColor;

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  BorderRadius? get _borderRadius =>
      widget.boxShape == BoxShape.circle ? null : BorderRadius.circular(widget.borderRadius);

  List<BoxShadow> get _boxShadows => [
    BoxShadow(
      color: widget.bottomRightShadowColor,
      offset: widget.bottomRightOffset,
      blurRadius: widget.bottomRightShadowBlurRadius,
      spreadRadius: widget.bottomRightShadowSpreadRadius,
    ),
    BoxShadow(
      color: widget.topLeftShadowColor,
      offset: widget.topLeftOffset,
      blurRadius: widget.topLeftShadowBlurRadius,
      spreadRadius: widget.topLeftShadowSpreadRadius,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      customBorder: widget.boxShape == BoxShape.circle ? const CircleBorder() : null,
      borderRadius: _borderRadius,
      child: Ink(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: _borderRadius,
          shape: widget.boxShape,
          border: Border.all(
            width: widget.borderWidth,
            color: widget.borderColor ?? widget.backgroundColor,
          ),
          boxShadow: _boxShadows,
        ),
        child: widget.child,
      ),
    );
  }
}