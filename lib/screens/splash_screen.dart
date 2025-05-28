import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  int _loadingProgress = 0;
  Timer? _loadingTimer;
  Timer? _pulseTimer;
  double _pulseValue = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // Simulate loading progress
    _loadingTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_loadingProgress < 100) {
        setState(() {
          _loadingProgress += 1;
        });
      } else {
        timer.cancel();
        // Navigate to login screen after loading
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacementNamed('/login');
        });
      }
    });

    // Pulse animation for the secure connection indicator
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _pulseValue = _pulseValue == 1.0 ? 0.7 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _loadingTimer?.cancel();
    _pulseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background grid
          CustomPaint(
            painter: _GridPainter(),
            size: Size.infinite,
          ),
          // Main content
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.green[900]!.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green[700]!,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: CustomPaint(
                                painter: _MilitaryLogoPainter(),
                                size: const Size(80, 80),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Title
                          Text(
                            'TACTICAL COMMS',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'SECURE COMMUNICATIONS SYSTEM',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Loading indicator
                          Container(
                            width: 200,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Stack(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: _loadingProgress / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[700],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Loading text
                          Text(
                            'INITIALIZING SECURE CHANNEL...',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Secure connection indicator
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _pulseValue,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.radio_button_checked,
                                  color: Colors.green[700],
                                  size: 12,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'ESTABLISHING ENCRYPTED CONNECTION',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 12,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green[800]!.withOpacity(0.1)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const step = 20.0;
    for (double i = 0.0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0.0), Offset(i, size.height), paint);
    }
    for (double i = 0.0; i < size.height; i += step) {
      canvas.drawLine(Offset(0.0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MilitaryLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw hexagon
    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.8, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(size.width * 0.2, size.height * 0.7)
      ..lineTo(size.width * 0.2, size.height * 0.3)
      ..close();

    // Draw filled hexagon
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
    
    // Draw hexagon outline
    canvas.drawPath(path, paint..style = PaintingStyle.stroke..color = Colors.green[400]!);

    // Draw vertical line
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.7),
      paint..strokeWidth = 2.0,
    );

    // Draw alpha symbol
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'α',
        style: TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        size.width * 0.5 - textPainter.width * 0.5,
        size.height * 0.5 - textPainter.height * 0.5,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 