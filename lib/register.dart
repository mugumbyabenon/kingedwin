import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class RegisterView extends StatefulWidget {
  // const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmpassword;
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;
  late final TextEditingController _phonenumber;
  late final TextEditingController _companyname;
  late final TextEditingController _location;

  @override
  void initState() {
    _email = TextEditingController();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _phonenumber = TextEditingController();
    _companyname = TextEditingController();
    _location = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _companyname.dispose();
    _confirmpassword.dispose();
    _firstname.dispose();
    _lastname.dispose();
    _location.dispose();
    _phonenumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://media.istockphoto.com/photos/visiting-car-dealership-afro-couple-showing-car-key-picture-id1167502071?b=1&k=20&m=1167502071&s=170667a&w=0&h=7khaGIzW3VxEayIR5EQELMtzHjxogHXkizJTE8e7fNk='),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black.withOpacity(0.5),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return ListTile(
            title: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Icon(
                    Icons.car_rental_rounded,
                    color: Colors.greenAccent,
                    size: 40,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Car_Free',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Colors.greenAccent,
                    ),
                  ),
                  SizedBox(height: 1.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your email here',
                        fillColor: Color.fromARGB(255, 221, 29, 29),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: _firstname,
                      obscureText: false,
                      autocorrect: true,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        fillColor: Color.fromARGB(255, 205, 30, 30),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: _lastname,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        fillColor: Color.fromARGB(255, 230, 29, 29),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: _companyname,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: 'Company Name or Username   ',
                        fillColor: Color.fromARGB(255, 215, 29, 29),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: _password,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      obscureText: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Color.fromARGB(255, 227, 23, 23),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: _phonenumber,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        fillColor: Color.fromARGB(255, 193, 35, 35),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text('Register'),
                    onPressed: (() async {
                      final email = _email.text;
                      final password = _password.text;
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password);

                      CollectionReference users =
                          FirebaseFirestore.instance.collection('users');
                      User? user = FirebaseAuth.instance.currentUser;
                      log('$user');
                      // Check if the user is signed in
                      if (user != null) {
                        await user
                            .updateDisplayName('${_firstname.text.trim()}');
                        Future addUserDetail(
                            String first_name,
                            int phone_number,
                            String email,
                            String companyname,
                            String lastname) async {
                          await user
                              .updateDisplayName('${_firstname.text.trim()}');
                          String uid = user.uid; // <-- User ID
                          String? emails = user.email;

                          log('$user');
                          // <-- Their email
                          return users
                              // existing document in 'users' collection: "ABC123"
                              .doc('$uid')
                              .set(
                                {
                                  'first_name': first_name,
                                  'company name': companyname,
                                  'last name': lastname,
                                  'phone_number': phone_number.toString(),
                                  'email': email,
                                  'image':
                                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                                  'user': uid,
                                  'username': _firstname.text.trim(),
                                  'uid': user.uid,
                                  'profilePhoto':
                                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                                },
                                SetOptions(merge: true),
                              )
                              .then((value) => log("SuccessFul Registration"))
                              .catchError(
                                  (error) => log("Failed to register: $error"));
                        }

                        ;

                        try {
                          addUserDetail(
                            _firstname.text.trim(),
                            int.parse(_phonenumber.text.trim()),
                            _email.text.trim(),
                            _companyname.text.trim(),
                            _lastname.text.trim(),
                          );

                          user.sendEmailVerification();
                          Navigator.of(context).pushNamed('/login');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'An email verification has been sent to your email to confirm your account')));
                        } catch (e) {
                          await showErrorDialog(context, e.toString());
                        }
                      } else {
                        return showErrorDialog(
                            context, 'No user is currently logged in');
                      }
                    }),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      },
                      child: Text('Already Registered? Login'))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
