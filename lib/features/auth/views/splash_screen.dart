import 'package:flutter/material.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _verticalAnimation;
  late Animation<double> _horizontalAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _verticalAnimation = Tween<double>(begin: -20, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _horizontalAnimation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    Navigator.pushNamed(context, SignIn.routeName); // غيّر '/home' باللي انت عاوزه
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _navigateToNextScreen,
        child: Container(
          color: const Color(0xff3DA5FA),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_horizontalAnimation.value, _verticalAnimation.value),
                child: Image.asset(
                  'assets/images/START.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
