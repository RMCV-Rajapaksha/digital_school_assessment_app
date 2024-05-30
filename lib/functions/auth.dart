import 'package:digital_school_assessment_app/Screens/Admin/adminMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:digital_school_assessment_app/Screens/Students/show.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
// Initialize the GoogleSignIn instance with your client ID
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '523115666456-evgucq06h98qn18drl4bcqe2ngetifth.apps.googleusercontent.com',
  );

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Return null if the user cancels the sign-in process
      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle any errors that occur during sign-in
      print('Google sign-in error: $e');
      return null;
    }
  }

// Function to handle the post-sign-in logic
  Future<void> handleGoogleSignIn(String category) async {
    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential != null) {
      // Show success snackbar
      Get.snackbar(
        'Success',
        'Sign-in successful: ${userCredential.user?.displayName}',
        backgroundColor: Colors.green,
      );

      // Navigate to the appropriate screen based on the category
      if (category == 'student') {
        Get.to(
          () => const StuShowData(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 600),
        );
      } else if (category == 'admin') {
        Get.to(
          () => const AdminMain(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 600),
        );
      }
    } else {
      // Show error snackbar
      Get.snackbar(
        'Error',
        'Sign-in failed or was canceled',
        backgroundColor: Colors.red,
      );
    }
  }

  bool validateEmail(String email) {
    return GetUtils.isEmail(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }

  void login(String emailAddress, String password, String category) async {
    // Validate email address
    if (!validateEmail(emailAddress)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (!validatePassword(password)) {
      Get.snackbar(
        'Invalid Password',
        'Password must be at least 6 characters long.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      Get.snackbar(
        'Login Successful',
        'You have logged in successfully.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        duration: Duration(seconds: 2),
      );

      if (category == 'student') {
        print('studdent');
        Get.to(
          () => const StuShowData(),
          transition: Transition
              .leftToRight, // Add this line for the transition animation
          duration: const Duration(milliseconds: 600),
        );
      } else if (category == 'admin') {
        Get.to(
          () => const AdminMain(),
          transition: Transition
              .leftToRight, // Add this line for the transition animation
          duration: const Duration(milliseconds: 600),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Login Failed',
          'No user found for that email.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          duration: const Duration(seconds: 2),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Login Failed',
          'Wrong password provided for that user.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          duration: const Duration(seconds: 2),
        );
      } else if (e.code == 'user-disabled') {
        Get.snackbar(
          'Login Failed',
          'User account has been disabled.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Login Failed',
          'An unexpected error occurred: ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          duration: const Duration(seconds: 2),
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
        duration: const Duration(seconds: 2),
      );
    }
  }

  void register(String emailAddress, String password) async {
    if (!validateEmail(emailAddress)) {
      Get.snackbar(
          'Invalid email address', 'Please enter a valid email address',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          duration: const Duration(seconds: 2));
      return;
    }

    if (!validatePassword(password)) {
      Get.snackbar(
          'Invalid password', 'Password must be at least 6 characters long',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          duration: Duration(seconds: 2));
      return;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Get.snackbar('Success', 'User registered successfully',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          duration: const Duration(seconds: 2));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            borderRadius: 10,
            duration: const Duration(seconds: 2));
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
