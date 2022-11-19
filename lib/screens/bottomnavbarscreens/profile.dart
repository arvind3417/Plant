// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'User_model.dart';
// import '';
import '../../models/user.dart';

class ProfilePage extends StatefulWidget {
  // const ProfilePage({required this.title});
  // final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int madd = 0;
  late Future<User?> user;
  Future<User> getUserdata() async {
    try {
      // List<User> result;
      String baseURL = "https://unnamed-plant.herokuapp.com/getprofile/sdds";
      var respons = await Dio().get(baseURL);
      // print(respons.data["data"][0]["email"]);
      // var p = respons.data["data"];
      print(respons.data);
      return User.fromJSON(respons.data);
    } catch (error) {
      print(error);
      return User();
    }
  }

  @override
  void initState() {
    super.initState();

    user = getUserdata();
  }

  @override
  Widget build(BuildContext context) {
    // user = getUserList();

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.white),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<User?>(
        future: user,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Container(child: Center(child: const CircularProgressIndicator()))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: Image.asset("images/avatar.jpg",
                                height: 170),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Name: ",
                                style: GoogleFonts.bebasNeue(
                                    textStyle: TextStyle(
                                  fontSize: 40,
                                )),
                              ),
                              Text(snapshot.data?.name ?? "null",
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                    fontSize: 24,
                                  )))
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Email: ",
                                style: GoogleFonts.bebasNeue(
                                    textStyle: TextStyle(
                                  fontSize: 40,
                                )),
                              ),
                              Expanded(
                                child: Text(
                                     snapshot.data?.email ?? "null",
                                  overflow: TextOverflow.ellipsis,

                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                    fontSize: 24,
                                  )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Profile Summary: ",
                                style: GoogleFonts.bebasNeue(
                                    textStyle: TextStyle(
                                  fontSize: 40,
                                )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                "Number of Trees :  ",
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                  fontSize: 24,
                                )),
                              ),
                              Text(
                                  snapshot.data?.no_of_plants.toString() ??
                                      "null",
                                  style: TextStyle(fontSize: 24))
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                "Hydrated Trees :  ",
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                  fontSize: 24,
                                )),
                              ),
                              Text(
                                  snapshot.data?.watered_plants.toString() ??
                                      "null",
                                  style: TextStyle(fontSize: 24))
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                "Dry Trees :  ",
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                  fontSize: 24,
                                )),
                              ),
                              Text(
                                snapshot.data?.dry_plants.toString() ?? "null",
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ]
                        //  List.generate(
                        //   snapshot.data!.length,
                        //   (index) {
                        //     return Row(
                        //       children: [
                        //         Text(snapshot.data?[index].name ?? "null"),
                        //       ],
                        //     );
                        //     // Text(snapshot.data?[index].name ?? "null");
                        //   },
                        // ),
                        ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 30, left: 30),
                      color: Colors.blueAccent,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black,
                          onTap: () {
                            print("donate now");
                          },
                          child: Container(
                            // color: Colors.blueAccent,
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Text(
                              "Donate A Tree",
                              style: GoogleFonts.bebasNeue(
                                  textStyle: const TextStyle(fontSize: 60)),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    ));
  }
}