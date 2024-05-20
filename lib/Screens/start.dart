import 'package:digital_school_assessment_app/Screens/Admin/login.dart';
import 'package:digital_school_assessment_app/Screens/Students/login.dart';
import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/animation.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Template(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      theChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'assets/images/start.png',
                      width: 400,
                      height: 400,
                    ),
                  ),
                  Text(
                    'Select one of the following options to continue',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: screenHeight * 0.018,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(80, 23, 148, 1),
                          Color.fromRGBO(60, 112, 161, 1),
                        ],
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.to(
                          () => const AdminLogin(),
                          transition: Transition
                              .leftToRight, // Add this line for the transition animation
                          duration: Duration(
                              milliseconds:
                                  600), // Optional: specify the duration of the animation
                        );
                      },
                      child: const Text(
                        'As a Admin',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(80, 23, 148, 1),
                          Color.fromRGBO(60, 112, 161, 1),
                        ],
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.to(
                          () => const StuLogin(),
                          transition: Transition
                              .leftToRight, // Add this line for the transition animation
                          duration: Duration(milliseconds: 600),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => StuLogin()),
                        // );
                      },
                      child: const Text(
                        'As a Student',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
