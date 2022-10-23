import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_clone_tutorial/login.dart';
import 'package:zoom_clone_tutorial/resources/auth_methods.dart';
import 'package:zoom_clone_tutorial/screens/history_meeting_screen.dart';
import 'package:zoom_clone_tutorial/screens/home_screen.dart';
import 'package:zoom_clone_tutorial/screens/meeting_screen.dart';
import 'package:zoom_clone_tutorial/userprofile.dart';
import 'package:zoom_clone_tutorial/utils/colors.dart';
import 'package:zoom_clone_tutorial/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zoom_clone_tutorial/login.dart';
import 'package:zoom_clone_tutorial/resources/auth_methods.dart';
import 'package:zoom_clone_tutorial/screens/history_meeting_screen.dart';
import 'package:zoom_clone_tutorial/screens/home_screen.dart';
import 'package:zoom_clone_tutorial/screens/meeting_screen.dart';
import 'package:zoom_clone_tutorial/userprofile.dart';
import 'package:zoom_clone_tutorial/utils/colors.dart';
import 'package:zoom_clone_tutorial/widgets/custom_button.dart';

import 'homeui.dart';

import 'homeui.dart';


import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone_tutorial/main.dart';

import 'dart:developer';

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _NinjaCardState();
}

class _NinjaCardState extends State<UserProfile> {
  int ninjaLevel=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Colors.white,
      body:Pof(),

    );
  }
}




 class Pof extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<Pof> {
 
     
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
    String? emails = user.email;
    String? uid = user.uid;
    final Stream<QuerySnapshot> _bmStreams = FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: "$emails")
        .snapshots(includeMetadataChanges: true);
        
    return StreamBuilder<QuerySnapshot>(
      stream: _bmStreams,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
          User? user = FirebaseAuth.instance.currentUser;
           if (user != null) {
                          String uid = user.uid; // <-- User ID
                          String? emails = user.email;
                          log(uid); 
        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(radius: 80,
                            backgroundImage: NetworkImage('${data?['image']??""}'),
                            child: GestureDetector(onDoubleTap: ()  async {
                               File? _image;
                               String imageUrl = '';
                               final image = await ImagePicker().pickImage(source: ImageSource.gallery) ;
                               if(image == null) {
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('No file has been selected')));
                               log('failed to upload');
                             return null;
                   };            
                            final upload = await FirebaseStorage.instance.ref().child('mages').
                            child(DateTime.now().toString()+'.jpg');
                            final path = image.path;
                            File file = File(path);
                            await upload.putFile(file) ;
                              FirebaseFirestore.instance.collection('users').doc('$emails').update({'image': '${await upload.getDownloadURL()}'});
                               final FirebaseAuth _auth = FirebaseAuth.instance;
                               await _auth.currentUser!.updatePhotoURL('${await upload.getDownloadURL()}');
                               log('${user}');
                            },)
                          ),
            Divider(
              height: MediaQuery.of(context).size.height * 0.02,
              color: Colors.grey[850],
            ),
            Text(
              'Username',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['company name']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ), SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Text(
              'First Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['first_name']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
             Text(
              'Last Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['last name']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Text(
              'Phone Number',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(
              '${data?['phone_number']??""}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.2,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),  
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  '${data?['email']??""}',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13.0,
                      letterSpacing: 1.0,
                  ),
                )
              ],
            ),
                        ],
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                 // subtitle: Text(data?['Car Model']??''),
                );
              })
              .toList()
              .cast(),
        );} throw FirebaseAuthException(code: 'An Error Occurred');
        
      },


    ); 
    
    
    } return AlertDialog(
        title:  const Text('Join our Family Today '),
          content: Text('Reach Out to thousands of customers or obtain unsecured loans'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
            }
            , child: const Text('Login/SignUp'))
          ],
    );


  }
}


Future<bool> showLogOutDialog(BuildContext context){
 return showDialog<bool>(
    context: context, 
    builder: (context){
       return AlertDialog(title: const Text('Sign Out'),
       content: const Text('Are you sure you want to log out'),
       actions: [TextButton(
        onPressed: (){
          Navigator.of(context).pop(true);
        },
        child:const Text('Logout'),),
        TextButton(onPressed: (){
           Navigator.of(context).pop(false);
        }, 
        child: const Text('Cancel'))
        ],
       );   
    },
    ).then((value) => value ?? false);
}

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
        actions: [ElevatedButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => LoginView()), (r) => false);
             ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content:Text('You have successfully logged out')));
        }, child: Text('Logout'))],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
              Column(
                         children: [
                           Image.network('https://image.shutterstock.com/image-vector/artificial-intelligence-humanoid-head-neural-260nw-1384554629.jpg',
                                        width:MediaQuery.of(context).size.width,
                                        height: 250,
                                        fit: BoxFit.cover),
                                         TextButton(onPressed: _launchUrl, child: Text('Artificial Intelligence',style: TextStyle(fontSize: 30),)),
                         ],
                       ),
            Column(
              children: [
                Image.network('https://sbs.ac.in/wp-content/uploads/2021/10/1e8cbf66-5dff-4541-a9ab-cdac7147f816.png',
                                        width:MediaQuery.of(context).size.width,
                                        height: 250,
                                        fit: BoxFit.cover),
                                   TextButton(onPressed: _launchUrl, child: Text('Computer Networks',style: TextStyle(fontSize: 30),)),
              ],
            ),
                       Column(
                         children: [
                           Image.network('https://image.shutterstock.com/image-vector/artificial-intelligence-humanoid-head-neural-260nw-1384554629.jpg',
                                        width:MediaQuery.of(context).size.width,
                                        height: 250,
                                        fit: BoxFit.cover),
                                         TextButton(onPressed: _launchUrl, child: Text('Artificial Intelligence',style: TextStyle(fontSize: 30),)),
                         ],
                       ),
                                    
                                    Column(
                                      children: [
                                        Image.network('https://static1.shine.com/l/m/images/blog/Embedded_System_Intro_Types_Applications_Architecture_and_Examples.jpg',
                                        width:MediaQuery.of(context).size.width,
                                        height: 250,
                                        fit: BoxFit.cover),
                                         TextButton(onPressed: _launchUrl, child: Text('Emdedded Systems',style: TextStyle(fontSize: 30),)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.network('https://www.mycslab.in/wp-content/uploads/2020/01/database-management-system.jpg',
                                        width:MediaQuery.of(context).size.width,
                                        height: 250,
                                        fit: BoxFit.cover),
                                         TextButton(onPressed: _launchUrl, child: Text('Database Management',style: TextStyle(fontSize: 30),)),
                                      ],
                                    ),
          ],
        ),
      ),
    );}else{
      return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcome')),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
       body: LoginView()
    );
    }
  }
}








class HOMEUI extends StatefulWidget {
  const HOMEUI({Key? key}) : super(key: key);

  @override
  State<HOMEUI> createState() => _HOMEUIState();
}

class _HOMEUIState extends State<HOMEUI> {
   int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
     List<Widget> pages = [
    FirstPage(),
    HomeScreen(),
     const HistoryMeetingScreen(),
     UserProfile(),
    
  ];

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.comment_bank,
            ),
            label: 'Home',
          ), BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
            ),
            label: 'Discussions',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
            ),
            label: 'Meetings History',
          ), BottomNavigationBarItem(
            icon: Icon(
              Icons.lock_clock,
            ),
            label: 'Profile',
          ),
         
        ],
      ),
    );
  }
}


  
         
     Future<void> _launchUrl() async {
       final Uri _url = Uri.parse('https://www.pdfdrive.com/artificial-intelligence-e11895991.html');
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }}

   Future<void> _datbase() async {
       final Uri _url = Uri.parse('https://books.google.co.ug/books?id=nUJdAAAAQBAJ&printsec=frontcover&dq=ai+pdfs&hl=en&sa=X&ved=2ahUKEwjrg5XSyPP6AhV0SvEDHUHUCrEQ6AF6BAgFEAI#v=onepage&q=ai%20pdfs&f=false');
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }}
  
   Future<void> _comp() async {
       final Uri _url = Uri.parse('https://books.google.co.ug/books?id=nUJdAAAAQBAJ&printsec=frontcover&dq=ai+pdfs&hl=en&sa=X&ved=2ahUKEwjrg5XSyPP6AhV0SvEDHUHUCrEQ6AF6BAgFEAI#v=onepage&q=ai%20pdfs&f=false');
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }}
   Future<void> _emded() async {
       final Uri _url = Uri.parse('https://books.google.co.ug/books?id=nUJdAAAAQBAJ&printsec=frontcover&dq=ai+pdfs&hl=en&sa=X&ved=2ahUKEwjrg5XSyPP6AhV0SvEDHUHUCrEQ6AF6BAgFEAI#v=onepage&q=ai%20pdfs&f=false');
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }}
  
