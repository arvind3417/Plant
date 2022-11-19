import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:news/gfgmap.dart';
import 'package:news/mainpage.dart';
import 'package:news/provider_g_auth.dart';
import 'package:news/screens/bottomnavbar.dart';
import 'package:provider/provider.dart';
import 'ui/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.dark().copyWith(accentColor: Colors.indigo),
          home: AnimatedSplashScreen(splash: Image.asset("images/tree.png"), nextScreen: MyWidget(),splashTransition: SplashTransition.scaleTransition,backgroundColor: Colors.blueAccent,)
          // MyWidget(),
        ),
      );
}
//   Widget build(BuildContext context) => ChangeNotifierProvider(create: (context)) =>
//     child: MaterialApp(
//       title: 'Crypto Wallet',
//       home: Authentication(),
//     );
  
// }
