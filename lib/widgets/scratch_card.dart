import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class ScratchCard extends StatefulWidget {
  const ScratchCard({Key? key}) : super(key: key);

  @override
  State<ScratchCard> createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  late ConfettiController _controller;
  bool _confettiPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up controller
    super.dispose();
  }

  void _playConfetti() {
    if (mounted && !_confettiPlayed) {
      _confettiPlayed = true;
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Reward! 🎁"),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Scratcher(
            brushSize: 50,
            threshold: 75,
            color: Colors.red,
            image: Image.asset(
              "assets/temp/lucky_scratch.jpg",
              fit: BoxFit.fill,
            ),
            onChange: (value) => print("Scratch progress: $value%"),
            onThreshold: () {
              if (mounted) {
                _playConfetti(); // Safe confetti trigger
              }
            },
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/temp/safety_bg.png",
                    fit: BoxFit.contain,
                    width: 250,
                    height: 250,
                  ),
                  if (mounted)
                    ConfettiWidget(
                      blastDirectionality: BlastDirectionality.explosive,
                      confettiController: _controller,
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 100,
                      gravity: 0.05,
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.red,
                        Colors.yellow,
                        Colors.blue,
                        Colors.purple,
                      ],
                    ),
                  const Text(
                    "You've won!\n10% OFF your next purchase",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
