import 'dart:io';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';

class formscreen extends StatefulWidget {
  String name;
  formscreen(this.name);

  @override
  State<formscreen> createState() => _formscreenState();
}

class _formscreenState extends State<formscreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController manure = TextEditingController();
  TextEditingController watering = TextEditingController();
  @override
  void dispose() {
    namecontroller.dispose();
    dob.dispose();
    manure.dispose();
    watering.dispose();

    super.dispose();
  }

  Future addPlant() async {
    try {
      // List<User> result;
      String baseURL = 'https://unnamed-plant.herokuapp.com/addplant';
      print(baseURL);
      // Dio();
      var respons = await Dio().post(baseURL,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {
            "plant_name": namecontroller.text,
            "date_of_plant": dob.text,
            "manure_date": manure.text,
            "water_date": watering.text,
            "water_req": Random().nextInt(5) + 2,
            "user_id": "oks",
            "user_name": username,
            "location": {"latitude": "13.590820", "longitude": "80.031850"}
          });
      // print(respons.data["data"][0]["email"]);
      // var p = respons.data["data"];
      print(respons.data);
    } catch (error) {
      print(error);
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // var dateInput;
    namecontroller.text = widget.name;
    dob.text = ""; //set the initial value of text field
    manure.text = ""; //set the initial value of text field
    watering.text = ""; //set the initial value of text field
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.blueAccent),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Text(
                        "Plant Details",
                        style: GoogleFonts.bebasNeue(
                            color: Colors.white, fontSize: 50),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: namecontroller,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: "Plant Name",
                            labelStyle: TextStyle(color: Colors.white)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                        padding: EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.width / 3,
                        child: Center(
                            child: TextField(
                          controller: dob,
                          //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Planted On",
                              labelStyle: TextStyle(
                                  color: Colors.white) //label text of field
                              // hintText: "Enter Date"
                              ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dob.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ))),
                    Container(
                        padding: EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.width / 3,
                        child: Center(
                            child: TextField(
                          controller: manure,
                          //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Date of Manure",
                              labelStyle: TextStyle(
                                  color: Colors.white) //label text of field
                              // hintText: "Enter Date"
                              ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                manure.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ))),
                    Container(
                        padding: EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.width / 3,
                        child: Center(
                            child: TextField(
                          controller: watering,
                          //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Date of Watering",
                              labelStyle: TextStyle(
                                  color: Colors.white) //label text of field
                              // hintText: "Enter Date"
                              ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                watering.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ))),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addPlant();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                          "Add your plant",
                          style: GoogleFonts.bebasNeue(
                              color: Colors.blueAccent, letterSpacing: 1.2),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 
            



// int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white);
//   static const List<Widget> pages = <Widget>[
//     mainpage(),
//     mainpage2(),    mainpage3(),    mainpage4()
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF3B3D58),
//         centerTitle: true,
//         title: const Text('HealthCare'),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> A()));
//       },child:Icon(Icons.calendar_view_day)),
//       body: Container(
//         color: Colors.black,
//         child: Center(
          
//           child: pages.elementAt(_selectedIndex),
//         ),
//       ),
      
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(
//               canvasColor: Color(0xFF3B3D58),
//               primaryColor: Colors.white,
//               textTheme: Theme.of(context).textTheme.copyWith(
//                 caption: TextStyle(color: Colors.grey)
//               )
//             ),
//         child: BottomNavigationBar(
//           backgroundColor: Colors.red,
//           showSelectedLabels: false,
//           unselectedItemColor: Colors.white,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "",
//               // backgroundColor: Colors.red,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.people),
//               label: 'Business',
//               // backgroundColor: Colors.green,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat),
//               label: 'School',
//               // backgroundColor: Colors.purple,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
              
//               label: 'Settings',
//               // backgroundColor: Colors.pink,
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }