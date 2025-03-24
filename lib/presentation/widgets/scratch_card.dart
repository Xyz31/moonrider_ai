import 'package:flutter/material.dart';

class ScratchCard extends StatefulWidget {
  final Function() onScratchComplete;
  const ScratchCard({
    super.key,
    required this.onScratchComplete,
  });

  @override
  State<ScratchCard> createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard>
    with SingleTickerProviderStateMixin {
  late double _scratchProgress;
  final List<Offset> _scratchPoints = [];
  bool _isRevealed = false;

  @override
  void initState() {
    super.initState();
    _scratchProgress = 0.0;
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_isRevealed) return;
    setState(() {
      _scratchPoints.add(details.localPosition);
      _scratchProgress = (_scratchPoints.length / 100).clamp(0.0, 1.0);
      if (_scratchProgress >= 0.85 && !_isRevealed) {
        _isRevealed = true;

        widget.onScratchComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onPanUpdate: _handlePanUpdate,
          child: Stack(
            children: [
              CustomPaint(
                painter: PatternPainter(),
                size: Size.infinite,
              ),
              CustomPaint(
                painter: ScratchPainter(
                  points: _scratchPoints,
                  scratchProgress: _scratchProgress,
                  gradientColors: const [
                    Color.fromARGB(255, 123, 31, 162),
                    Color.fromARGB(255, 74, 20, 140)
                  ],
                ),
                size: Size.infinite,
              ),
            ],
          ),
        ));
  }
}

class ScratchPainter extends CustomPainter {
  final List<Offset> points;
  final double scratchProgress;
  final List<Color> gradientColors;

  ScratchPainter({
    required this.points,
    required this.scratchProgress,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 60;

    // Create gradient for scratch layer
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: gradientColors,
    );

    // Draw the scratch-off layer with gradient
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = gradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    // Draw scratch paths
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(
          points[i], points[i + 1], paint..blendMode = BlendMode.clear);
    }

    // Draw centered "Scratch here!" text
    final textStyle = TextStyle(
      color: Colors.white.withOpacity(0.8),
      fontSize: 24,
      fontFamily: "SpaceGrotesk",
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: 'Scratch here!',
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout(
      minWidth: size.width,
      maxWidth: size.width,
    );

    textPainter.paint(
      canvas,
      Offset(0, (size.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(ScratchPainter oldDelegate) => true;
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2;

    for (var i = 0; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    for (var i = 0; i < size.height; i += 20) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(PatternPainter oldDelegate) => false;
}

String _formatTime(DateTime dateTime) {
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour;
  String minuteStr = minute < 10 ? '0$minute' : minute.toString();
  return '${hour.toString().padLeft(2, '0')}:${minuteStr.padLeft(2, '0')} $period';
}

class DataCard extends StatelessWidget {
  final int rewardAmount;
  final DateTime nextAvailableTime;

  const DataCard(
      {super.key, required this.rewardAmount, required this.nextAvailableTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$rewardAmount',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                const Text(
                  ' Coins',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Collected',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Next scratch available at:\n${_formatTime(nextAvailableTime)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
