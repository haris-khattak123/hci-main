import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController(text: 'operator@command.gov');
    final _passwordController = TextEditingController(text: '********');

    return Scaffold(
      body: Stack(
        children: [
          // Programmatic background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[900]!,
                  Colors.black,
                ],
              ),
            ),
            child: CustomPaint(
              painter: _TacticalBackgroundPainter(),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green[700]!),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Programmatic logo
                    const SizedBox(
                      width: 120,
                      height: 120,
                      child: CustomPaint(
                        painter: _MilitaryLogoPainter(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'SECURE ACCESS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLoginForm(context, _formKey, _emailController, _passwordController),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController,
      ) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'OPERATOR ID',
              labelStyle: TextStyle(color: Colors.green[700]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[700]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[700]!),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'ACCESS CODE',
              labelStyle: TextStyle(color: Colors.green[700]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[700]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[700]!),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Provider.of<AuthProvider>(context, listen: false).login(
                    emailController.text,
                    passwordController.text,
                  );
                  // Navigate to dashboard after successful login
                  Navigator.of(context).pushReplacementNamed('/dashboard');
                }
              },
              child: const Text(
                'AUTHENTICATE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MilitaryLogoPainter extends CustomPainter {
  const _MilitaryLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.8, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(size.width * 0.2, size.height * 0.7)
      ..lineTo(size.width * 0.2, size.height * 0.3)
      ..close();

    canvas.drawPath(path, paint..style = PaintingStyle.fill);
    canvas.drawPath(path, paint..style = PaintingStyle.stroke..color = Colors.green[400]!);

    canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.3),
        Offset(size.width * 0.5, size.height * 0.7),
        paint..strokeWidth = 2.0
    );

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
      Offset(size.width * 0.5 - textPainter.width * 0.5,
          size.height * 0.5 - textPainter.height * 0.5),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TacticalBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green[800]!.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (var i = 1; i <= 5; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.15),
        i * 40.0,
        paint,
      );
    }

    canvas.drawLine(
      Offset(size.width * 0.85, 0),
      Offset(size.width * 0.85, size.height * 0.3),
      paint..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}