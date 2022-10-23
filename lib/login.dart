import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zoom_clone_tutorial/homepage.dart';

import 'dart:developer' as devtools show log;

import 'package:zoom_clone_tutorial/register.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occurred '),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}

class LoginView extends StatefulWidget {
  // const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://imageio.forbes.com/specials-images/imageserve/5f85be4ed0acaafe77436710/0x0.jpg?format=jpg&width=1200'),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.class_rounded,
              size: 100,
              color: Color.fromARGB(255, 33, 33, 243),
            ),
            SizedBox(height: 5.0),
            Text(
              'YoClass',
              style: GoogleFonts.bebasNeue(
                fontSize: 52,
                color: Color.fromARGB(255, 72, 33, 243),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: true,
                decoration: InputDecoration(
                  hintText: 'Enter your email here',
                  fillColor: Colors.lightBlue,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  fillColor: Colors.lightBlue,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: (() async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                  final user = await FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    if (user?.emailVerified ?? false == true) {
                        Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => HOMEUI()), (r) => false);
                    } else {
                      final shouldLogout = await dialoglogin(context);
                      if (shouldLogout == true) {
                        await user.sendEmailVerification();
                        Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => LoginView()), (r) => false);
                      }
                    }
                  } else {
                    return showErrorDialog(
                        context, 'No user is currently logged in');
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    await showErrorDialog(
                      context,
                      'User not found',
                    );
                  } else if (e.code == 'wrong-password') {
                    await showErrorDialog(
                        context, 'You have entered a wrong password');
                  } else
                    showErrorDialog(context, 'Error: ${e.code}');
                } catch (e) {
                  await showErrorDialog(context, e.toString());
                }
              }),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                      (r) => false);
                },
                child: const Text("Not yet registered? Register Here")),
          ],
        ),
      ),
    );
  }
}

Future<bool> dialoglogin(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Verify Email'),
        content: const Text('Resend email verification'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Ok'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'))
        ],
      );
    },
  ).then((value) => value ?? false);
}
