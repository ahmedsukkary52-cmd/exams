import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme_app.dart';

class ScoreCardWidget extends StatelessWidget {
  final int correctCount;
  final int incorrectCount;
  final double percentage;

  const ScoreCardWidget({
    super.key,
    required this.correctCount,
    required this.incorrectCount,
    required this.percentage,
  });

  static Color blueColor = ThemeApp.colors.primary;
  static Color redColor = ThemeApp.colors.errorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your score',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 132,
                height: 132,
                child: CustomPaint(
                  painter: ScoreDonutPainter(percentage: percentage),
                  child: Center(
                    child: Text(
                      '${(percentage * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(
                    label: 'Correct',
                    count: correctCount,
                    color: blueColor,
                  ),
                  const SizedBox(height: 16),
                  _buildLegendItem(
                    label: 'Incorrect',
                    count: incorrectCount,
                    color: redColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required String label,
    required int count,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),

        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}

class ScoreDonutPainter extends CustomPainter {
  final double percentage;

  ScoreDonutPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 8.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final bluePaint = Paint()
      ..color = const Color(0xFF0033A0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final redPaint = Paint()
      ..color = const Color(0xFFD31118)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const double gapAngle = 0.25;

    final double availableAngle = (2 * pi) - (2 * gapAngle);

    final double sweepAngleBlue = availableAngle * percentage;
    final double sweepAngleRed = availableAngle * (1 - percentage);

    const double startAngle = -pi / 2;

    final double blueStartAngle = startAngle + (gapAngle / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      blueStartAngle,
      sweepAngleBlue,
      false,
      bluePaint,
    );

    final double redStartAngle = blueStartAngle + sweepAngleBlue + gapAngle;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      redStartAngle,
      sweepAngleRed,
      false,
      redPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}