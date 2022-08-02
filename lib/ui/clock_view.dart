import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      // color: HexColor("#8080cc"),
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;

    /// Center Point
    var centerPoint = Offset(centerX, centerY);

    /// Radius
    var radius = min(centerX, centerY);

    /// Clock Circle Paint
    var brush = Paint()..color = HexColor("#8080cc");

    /// Clock Seconds Hand Paint
    var secondHand = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    /// Small Circle
    var smallCircle = Paint()..color = Colors.white;

    /// Draw Clock Circle
    canvas.drawCircle(centerPoint, radius, brush);

    /// Draw Small Circle
    canvas.drawCircle(centerPoint, 5, smallCircle);

    /// Draw Seconds Hand
    var secHandX = centerX + 70 * cos(dateTime.second * 6 * pi / 360);
    var secHandY = centerX + 70 * sin(dateTime.second * 6 * pi / 360);
    print(secHandX);
    print(secHandY);
    canvas.drawLine(centerPoint, Offset(secHandX, secHandY), secondHand);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
