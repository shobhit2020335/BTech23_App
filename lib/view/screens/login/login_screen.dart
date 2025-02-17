import 'package:btech_induction_2023/extensions/navigation.dart';
import 'package:btech_induction_2023/service/firebase.dart';
import 'package:btech_induction_2023/view/screens/home/home_screen.dart';
import 'package:btech_induction_2023/view/screens/profile/create_profile_screen.dart';
import 'package:btech_induction_2023/view/theme/colors.dart';
import 'package:btech_induction_2023/view/widgets/texture_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Provider.of<FirebaseFirestoreService>(context, listen: false)
            .getUserData()
            .then((value) {
          if (value == null) {
            if (mounted) {
              context.pushAndRemoveUntil(const CreateProfileScreen());
            }
          } else {
            if (mounted) {
              context.pushReplacement(const InductionAppHomePage());
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: Image.asset("images/iiitd.png", height: 200),
        ),
        centerTitle: true,
        leading: const SizedBox(
          width: 50,
        ),
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          const TextureBackground(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FractionallySizedBox(
                    child: Image.asset("images/logo.png"),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                      color: InductionAppColor.yellow,
                      onPressed: () {
                        Provider.of<FirebaseAuthService>(context, listen: false)
                            .signUpWithGoogle();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Sign in with Google"),
                          SizedBox(width: 10),
                          Icon(Icons.login)
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
