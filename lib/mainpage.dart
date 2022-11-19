// import 'package:firebase_auth/firebase_auth.dart';




import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/bottomnavbar.dart';
import 'package:news/screens/bottomnavbarscreens/plants_add.dart';
// import 'package:news/singnandlogin.dart';
import 'package:news/ui/authentication.dart';
// import 'bottomnavbar.dart';
// import 'authentication.dart';

class MyWidget extends StatelessWidget {
  // const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){

            return Center(
            child: CircularProgressIndicator(),
          );
        }
        
        else if (snapshot.hasData) {
          return MyStatefulWidget();
        } else if (snapshot.hasError) 
        {   return Center(child: Text("Something Went Wrong"),);
        } else {
          return Authentication();
        }

        // return 
        // return Scaffold(body: Container());
      },
    );
  }
}
