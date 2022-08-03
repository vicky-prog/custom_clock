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
      color: Colors.blueGrey,
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
      ..strokeCap = StrokeCap.round
      ..color = Colors.white;

    /// Clock Minutes Hand Paint
    var outerLine = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = Colors.purple;

    /// Small Circle
    var smallCircle = Paint()..color = Colors.white;

    /// Draw Clock Circle
    canvas.drawCircle(centerPoint, radius - size.width * 0.10, brush);

    /// Draw Small Circle
    canvas.drawCircle(centerPoint, 5, smallCircle);

    /// Draw Seconds Hand
    var secHandX = centerX + 70 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 70 * sin(dateTime.second * 6 * pi / 180);
    print(secHandX);
    print(secHandY);
    canvas.drawLine(centerPoint, Offset(secHandX, secHandY), secondHand);

    /// Draw Minutes Hand
    var minHandX = centerX + 45 * cos(dateTime.minute * 8 * pi / 180);
    var minHandY = centerX + 45 * sin(dateTime.minute * 8 * pi / 180);

    _drawOuterLine(canvas, outerLine, size);

    // canvas.drawLine(centerPoint, Offset(minHandX, minHandY), minuteHand);
  }

  _drawOuterLine(Canvas canvas, Paint outerLine, Size size) {
    /// Top Line
    canvas.drawLine(Offset(size.width, size.height - size.height * 0.05),
        Offset(size.height, size.width - size.width * 0.95), outerLine);

    /// Left Line
    canvas.drawLine(const Offset(10, 0), Offset(190, 0), outerLine);

    /// Right Line
    canvas.drawLine(const Offset(10, 200), Offset(190, 200), outerLine);

    /// Bottom Line
    canvas.drawLine(const Offset(0, 10), Offset(0, 190), outerLine);
  }

  getRadians(double angle) {
    return angle * pi / 180;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
