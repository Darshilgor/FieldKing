import 'package:field_king/Pages/singup_page.dart';
import 'package:field_king/services/navigator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward().whenComplete(
      () {
        callnextscreen(
          context,
          SignUpPage(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Text(
                  "Welcome to Field King",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
