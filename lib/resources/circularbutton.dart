import 'package:flutter/material.dart';

class CircularTransformButton extends StatelessWidget {
  const CircularTransformButton({
    required this.color,
    required this.width,
    required this.height,
    required this.icon,
    required this.rotationAnimation,
    required this.onClick,
    this.direction,
    this.translationAnimation,
    super.key,
  });

  final Color color;
  final double width;
  final double height;
  final Icon icon;
  final Animation rotationAnimation;
  final VoidCallback onClick;

  final double? direction;
  final Animation? translationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  Widget build(BuildContext context) {
    return direction != null
        ? Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(direction!),
                translationAnimation!.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegree(rotationAnimation.value))
                ..scale(translationAnimation!.value),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                width: width,
                height: height,
                child: IconButton(
                    icon: icon, enableFeedback: true, onPressed: onClick),
              ),
            ),
          )
        : Transform(
            transform: Matrix4.rotationZ(
                getRadiansFromDegree(rotationAnimation.value)),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              width: width,
              height: height,
              child: IconButton(
                  icon: icon, enableFeedback: true, onPressed: onClick),
            ),
          );
  }
}
