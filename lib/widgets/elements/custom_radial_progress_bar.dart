

import 'dart:math';

import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red)
        ),
        child: const RadialPercentWidget(
        fillColor: Colors.blue,
        freeColor: Colors.yellow,
        lineColor: Colors.red,
        lineWidth: 5,
        percent: 0.56,
        child: Text('56%', style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}

class RadialPercentWidget extends StatelessWidget {
  final Widget? child;
  final double? percent;
  final Color? fillColor;
  final Color? lineColor;
  final Color? freeColor;
  final double? lineWidth;
  const RadialPercentWidget({
    super.key, 
    required this.child, 
    required this.percent, 
    required this.fillColor, 
    required this.lineColor, 
    required this.freeColor, 
    required this.lineWidth});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: MyPainter(
          child: child, 
          fillColor: fillColor, 
          freeColor: freeColor, 
          lineColor: lineColor, 
          lineWidth: lineWidth, 
          percent: percent),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: child,),
        )
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final Widget? child;
  final double? percent;
  final Color? fillColor;
  final Color? lineColor;
  final Color? freeColor;
  final double? lineWidth;

  MyPainter({
    required this.child, 
    required this.percent, 
    required this.fillColor, 
    required this.lineColor, 
    required this.freeColor, 
    required this.lineWidth});
  @override
  void paint(Canvas canvas, Size size) {
    Rect arcRect = calculateArcsRect(size);
    drawBackground(canvas, size);

    drowFreeArc(canvas, arcRect);

    drawFiledArc(canvas, arcRect);
  }

  void drawFiledArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint.color = lineColor!;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth!;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(
      arcRect, 
      -pi / 2, 
      pi * 2 * percent!, 
      false, 
      paint,
    );
  }

  void drowFreeArc(Canvas canvas, Rect arcRect) {
     final paint = Paint();
    paint.color = freeColor!;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth!;
    canvas.drawArc(
      arcRect, 
      pi * 2 * percent! - (pi / 2), 
      pi * 2 * (1.0 - percent!), 
      false, 
      paint);
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = fillColor!;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    const linesMargin = 3;
    final offset = lineWidth! / 2 + linesMargin;
    final arcRect = Offset(offset, offset) & 
        Size(size.width - offset * 2, size.height - offset * 2 );
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }

}