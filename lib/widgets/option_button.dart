import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class OptionButton extends StatefulWidget {
  final VoidCallback onButtonPressed;
  final String label;
  final bool isCorrect;

  const OptionButton({super.key, required this.onButtonPressed, required this.label, required, required this.isCorrect});

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  // Blast animation on correct answer
  final ConfettiController controllerCenter = ConfettiController(
      duration: Duration(
    milliseconds: 500,
  ));

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton(
          onPressed: widget.isCorrect
              ? () async {
                  controllerCenter.play();
                  await Future.delayed(Duration(seconds: 1), widget.onButtonPressed);
                }
              : widget.onButtonPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(1000, 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(widget.label),
        ),
        ConfettiWidget(
          confettiController: controllerCenter,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple,
          ],
          createParticlePath: drawStar,
        ),
      ],
    );
  }
}
