import 'package:digital_school_assessment_app/Screens/Students/registation.dart';
import 'package:digital_school_assessment_app/Screens/Students/show.dart';
import 'package:digital_school_assessment_app/Template/temp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StuLogin extends StatelessWidget {
  const StuLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    Future<void> handleGoogleSignIn() async {
      UserCredential? userCredential = await signInWithGoogle();

      if (userCredential != null) {
        // Sign-in successful, show a success snackbar
        Get.snackbar('Success', 'Sign-in successful: ${userCredential.user}',
            backgroundColor: Colors.green);
      } else {
        // Sign-in failed or was canceled, show an error snackbar
        Get.snackbar('Error', 'Sign-in failed or was canceled',
            backgroundColor: Colors.red);
      }
    }

    bool validateEmail(String email) {
      return GetUtils.isEmail(email);
    }

    bool validatePassword(String password) {
      return password.length >= 6;
    }

    void login(String emailAddress, String password) async {
      // Validate email address
      if (!validateEmail(emailAddress)) {
        Get.snackbar(
          'Invalid Email',
          'Please enter a valid email address.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          duration: Duration(seconds: 2),
        );
        return;
      }

      if (!validatePassword(password)) {
        Get.snackbar(
          'Invalid Password',
          'Password must be at least 6 characters long.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          duration: Duration(seconds: 2),
        );
        return;
      }

      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );

        Get.snackbar(
          'Login Successful',
          'You have logged in successfully.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          duration: Duration(seconds: 2),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StuShowData()),
        );
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase authentication errors
        if (e.code == 'user-not-found') {
          Get.snackbar(
            'Login Failed',
            'No user found for that email.',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            duration: Duration(seconds: 2),
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            'Login Failed',
            'Wrong password provided for that user.',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            duration: Duration(seconds: 2),
          );
        } else if (e.code == 'user-disabled') {
          Get.snackbar(
            'Login Failed',
            'User account has been disabled.',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            duration: Duration(seconds: 2),
          );
        } else {
          Get.snackbar(
            'Login Failed',
            'An unexpected error occurred: ${e.message}',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            duration: Duration(seconds: 2),
          );
        }
      } catch (e) {
        // Handle any other errors
        Get.snackbar(
          'Login Failed',
          'An unexpected error occurred: $e',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          duration: Duration(seconds: 2),
        );
      }
    }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WELLCOME',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: const Color.fromRGBO(25, 7, 51, 1),
                      filled: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: const Color.fromRGBO(25, 7, 51, 1),
                      filled: true,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: null,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                        String email = emailController.text;
                        String password = passwordController.text;
                        login(email, password);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => stuRegistration()),
                      );
                    },
                    child: const Text("Create an account",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 10.0,
                        )),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 255, 255, 255),
                    thickness: 0.7,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    '    or continue with',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          handleGoogleSignIn();
                          print("hiiii");
                        },
                        child: Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: const Color.fromRGBO(59, 32, 99, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/google.png',
                                width: 24.0,
                                height: 24.0,
                              ),
                              const Text(
                                '  Google',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add your button functionality here
                        },
                        child: Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: const Color.fromRGBO(59, 32, 99, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/communication.png',
                                width: 24.0,
                                height: 24.0,
                              ),
                              const Text(
                                '  Facebook',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
