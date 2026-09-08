import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spendly/core/theme/app-theme.dart';
import 'package:spendly/screens/onboarding/onboarding_screen.dart';

// import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 2800), _navigateToOnboarding);
  }

  void _navigateToOnboarding() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const OnboardingScreen();
        },

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },

        transitionDuration: const Duration(
          milliseconds: 500,
        )
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkScreen,
      body: Stack(
        children: [
          // Background decorations
          const Positioned.fill(child: _SplashBackground()),

          // Main content
          SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: child,
                    ),
                  );
                },
                child: const _SplashContent(),
              ),
            ),
          ),

          // Page indicators
          const Positioned(
            left: 0,
            right: 0,
            bottom: 45,
            child: _PageIndicators(),
          ),
        ],
      ),
    );
  }
}

///
/// Splash content
///

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Wallet logo
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            size: 52,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 28),

        // Spendly
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Spend',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.5,
                ),
              ),
              TextSpan(
                text: 'ly',
                style: TextStyle(
                  color: Color(0xFF39D98A),
                  fontSize: 44,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Tagline
        const Text(
          'Track. Understand. Grow.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

///
/// Background waves
///

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 40,
          left: -100,
          child: CustomPaint(
            size: const Size(350, 180),
            painter: _WavePainter(),
          ),
        ),

        Positioned(
          top: 250,
          right: -120,
          child: CustomPaint(
            size: const Size(380, 180),
            painter: _WavePainter(),
          ),
        ),

        Positioned(
          bottom: 120,
          left: -100,
          child: CustomPaint(
            size: const Size(400, 180),
            painter: _WavePainter(),
          ),
        ),

        Positioned(
          bottom: -20,
          right: -120,
          child: CustomPaint(
            size: const Size(380, 180),
            painter: _WavePainter(),
          ),
        ),
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    path.moveTo(0, size.height * 0.5);

    path.cubicTo(
      size.width * 0.20,
      size.height * 0.05,
      size.width * 0.38,
      size.height * 0.95,
      size.width * 0.60,
      size.height * 0.50,
    );

    path.cubicTo(
      size.width * 0.78,
      size.height * 0.18,
      size.width * 0.90,
      size.height * 0.25,
      size.width,
      size.height * 0.55,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

///
/// Bottom page indicators
///

class _PageIndicators extends StatelessWidget {
  const _PageIndicators();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _indicator(active: true),
        const SizedBox(width: 8),
        _indicator(),
        const SizedBox(width: 8),
        _indicator(),
      ],
    );
  }

  Widget _indicator({bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active ? 22 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF39D98A)
            : Colors.white.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
