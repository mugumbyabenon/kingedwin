import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'main.dart';


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

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
      User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
       String? username = user.displayName; // <-- User ID
      String? emails = user.email;
      log('$user');
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi ${username}'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: ElevatedButton(onPressed: ()async{
         await downloadFile(context);
      }, child: Text('Download')),
    );}else{
      return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcome')),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
       body: ElevatedButton(onPressed: ()async{
         await downloadFile(context);
      }, child: Text('Download')),
    );
    }
  }
}



class UserInformations extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformations> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Adverts').snapshots();
  late final TextEditingController _search;

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('Adverts')
        .snapshots(includeMetadataChanges: true);
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        try {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 1.5,
            child: ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return SizedBox(
                      child: ListTile(
                        title: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 220, 220),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color.fromARGB(255, 136, 134, 134),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                               
                                },
                                child: SizedBox(
                                  height: 250,
                                  child: Image.network(data?['imageUrl'] ?? "",
                                      width:200,
                                      height: 250,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?['Car Name'] ?? "",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),



                            ],
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        // subtitle: Text(data?['Car Model']??''),
                      ),
                    );
                  })
                  .toList()
                  .cast(),
            ),
          );
        } catch (e) {
          throw showErrorDialog(context, '$e');
        }
      },
    );
  }
}