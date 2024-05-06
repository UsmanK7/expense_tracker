import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
 
  FloatingButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.icon,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,shape: BoxShape.circle
      ),
      width: width,
      height: height,
      child: Icon(Icons.add),
    );
  }
}
