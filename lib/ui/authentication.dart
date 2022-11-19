// import 'package:flutter_application_1/plantui/provider_g_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:news/net/flutterfire.dart';
import 'package:flutter/material.dart';
// import 'package:news/nextttologin.dart';
// import 'package:news/provider_g_auth.dart';
// import 'package:news/ui/add_view.dart';
import 'package:provider/provider.dart';

import '../provider_g_auth.dart';

// import '../home_view.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
Icon(Icons.android,size: 100,color: Colors.white,),
SizedBox(height: 50,),
Text("data",style: GoogleFonts.bebasNeue(fontSize: 52),),

            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailField,
                decoration: InputDecoration(
                  hintText: "something@email.com",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Email",
                  labelStyle: GoogleFonts.bebasNeue(color: Colors.white,letterSpacing: 1.2)
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                
                style: TextStyle(color: Colors.white),
                controller: _passwordField,
                obscureText: true,
                decoration: InputDecoration(
                  
                  hintText: "Enter Password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                  labelStyle: GoogleFonts.bebasNeue(color: Colors.white,letterSpacing: 1.2)
                ),
              ),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height / 35),
            // Container(
            //   width: MediaQuery.of(context).size.width / 1.4,
            //   height: 45,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15.0),
            //     color: Colors.white,
            //   ),
            //   child: MaterialButton(
            //     onPressed: () async {
            //       bool shouldNavigate =
            //           await register(_emailField.text, _passwordField.text);
            //       if (shouldNavigate) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => AddView(),
            //           ),
            //         );
            //       }
            //       print(" in registered");
            //     },
            //     child: Text("Register",style: GoogleFonts.bebasNeue(color: Colors.black),),
            //   ),
            // ),
            // SizedBox(height: MediaQuery.of(context).size.height / 35),
            // Container(
            //   width: MediaQuery.of(context).size.width / 1.4,
            //   height: 45,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15.0),
            //     color: Colors.white,
            //   ),
            //   child: MaterialButton(
            //       onPressed: () async {
            //         bool shouldNavigate =
            //             await signIn(_emailField.text, _passwordField.text);
            //         if (shouldNavigate) {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => HomeView(),
            //             ),
            //           );
            //         }
            //       },
            //       child: Text("Login",style: GoogleFonts.bebasNeue(color: Colors.black),)),
            // ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),

              Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                
                  onPressed: ()  {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
                  // () async {
                  //   bool shouldNavigate =
                  //       await signIn(_emailField.text, _passwordField.text);
                  //   if (shouldNavigate) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => HomeView(),
                  //       ),
                  //     );
                  //   }
                  // },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.google,),
                      SizedBox(width: 20,),
                      Text("Sign in with Google",style: GoogleFonts.bebasNeue(color: Colors.black),),
                    ],
                  )),
            ),
            // ElevatedButton.icon(
            //   style: ElevatedButton.styleFrom(
            //       primary: Colors.white,
            //       onPrimary: Colors.black,
            //       minimumSize: Size(double.infinity, 50)),
            //   onPressed: () {
            //     final provider =
            //         Provider.of<GoogleSignInProvider>(context, listen: false);
            //     provider.googleLogin();
            //   },
            //   label: Text("Sign in With Google"),
            //   icon: FaIcon(FontAwesomeIcons.google),
            // )
          ],
        ),
      ),
    );
  }
}
