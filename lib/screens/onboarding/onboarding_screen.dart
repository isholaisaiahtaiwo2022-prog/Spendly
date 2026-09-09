import 'package:flutter/material.dart';
import 'package:spendly/core/theme/App-Theme.dart';
import 'package:spendly/screens/splash/splash_screen.dart';
import 'package:spendly/screens/setup/name_setup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isPressed = false;

  void _getStarted() {

    setState(() {
      _isPressed = true;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;

      setState(() {
        _isPressed = false;
      });

      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const NameSetupScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },

          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Column(
            children: [
              const Expanded(child: _onboardingIllustration()),

              const SizedBox(height: 20),

              const Text(
                'Welcome to\nSpendly 👋',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                  letterSpacing: -0.8,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Your Personal Spending Tracker\n'
                'that helps you stay in control\n'
                'of your money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF666666),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 54,

                child: AnimatedScale(
                  scale: _isPressed ? 0.97 : 1.0,
                  duration: const Duration(milliseconds: 100),

                  child: ElevatedButton(
                    onPressed: _getStarted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const _PageIndicator(),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

//OnboardingIllustration

class _onboardingIllustration extends StatelessWidget {
  const _onboardingIllustration();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280,
        height: 300,

        child: Stack(
          alignment: Alignment.center,
          children: [
            _circle(
              size: 170,
              color: AppTheme.primaryGreen.withValues(alpha: 0.10),
            ),

            _circle(
              size: 120,
              color: AppTheme.primaryGreen.withValues(alpha: 0.08),
            ),

            //Decorative finance icons
            const Positioned(
              top: 32,
              left: 22,
              child: _FloatingIcon(
                icon: Icons.bar_chart_rounded,
                color: Color(0xFF159447),
              ),
            ),

            const Positioned(
              top: 18,
              left: 58,
              child: _FloatingIcon(
                icon: Icons.monetization_on_rounded,
                color: Color(0xFFE6B93C),
              ),
            ),

            const Positioned(
              top: 90,
              left: 20,
              child: _FloatingIcon(
                icon: Icons.account_balance_wallet_outlined,
                color: Color(0xFF159447),
              ),
            ),

            const Positioned(
              top: 25,
              left: 112,
              child: _FloatingIcon(
                icon: Icons.savings_rounded,
                color: Color(0xFF159447),
              ),
            ),

            //wallet
            Container(
              width: 155,
              height: 115,

              decoration: BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.18),

                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),

              child: Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 70,
              ),
            ),

            Stack(
              children: [
                Positioned(
                  right: 12,
                  bottom: 10,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.darkScreen.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // const Center(
                //   child: Icon(
                //     Icons.account_balance_wallet_rounded,
                //     color: Colors.white,
                //     size: 70,
                //   ),
                // ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 35,
                    height: 25,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        173,
                        22,
                        22,
                      ).withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _circle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _FloatingIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Icon(icon, color: color, size: 26),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        _indicator(width: 22, active: true),

        const SizedBox(width: 8),

        _indicator(),

        const SizedBox(width: 8),

        _indicator(),
      ],
    );
  }

  Widget _indicator({double width = 10, bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),

      width: width,
      height: 10,

      decoration: BoxDecoration(
        color: active ? AppTheme.primaryGreen : const Color(0xFFD5DAD7),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
