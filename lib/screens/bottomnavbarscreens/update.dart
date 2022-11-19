import 'dart:convert';
import 'dart:io';

import '../../models/plant.dart';
// import 'plants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// import 'constants.dart';

class UpdateScreen extends StatefulWidget {
  // const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // vo
  List<Plant> fromJSONlist(List json) {
    List<Plant> listy = [];
    json.forEach((element) {
      listy.add(Plant.fromJSON(element));
    });
    print(json);
    return listy;
  }

  late Future<List<Plant>?> plants_of_user;
  Future<List<Plant>?> getUserPLants() async {
    try {
      // List<User> result;
      String baseURL = "https://unnamed-plant.herokuapp.com/getplants/sdds";
      // Dio();
      var respons = await Dio().get(baseURL);
      // print(respons.data["data"][0]["email"]);
      // var p = respons.data["data"];
      print(respons.data);
      return fromJSONlist(respons.data);
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<Plant>?> updateUserPlants(String ids) async {
    try {
      // List<User> result;
      String baseURL = 'https://unnamed-plant.herokuapp.com/updateplant/$ids';
      print(baseURL);
      // Dio();
      var respons = await Dio().post(baseURL,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: {
            "water_date": wateredDate.text,
            "manure_date": manureDate.text
          });
      // print(respons.data["data"][0]["email"]);
      // var p = respons.data["data"];
      print(respons.data);
      return fromJSONlist(respons.data);
    } catch (error) {
      print(error);
      return [];
    }
  }

  TextEditingController wateredDate = TextEditingController();
  TextEditingController manureDate = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wateredDate.text = "";
    manureDate.text = "";
    plants_of_user = getUserPLants();
  }

  void showbottom(String plantID) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.width / 3,
                    child: Center(
                        child: TextField(
                      controller: wateredDate,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Last Watered Date" //label text of field
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
                            wateredDate.text =
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
                      controller: manureDate,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Last Manured Date" //label text of field
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
                            manureDate.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ))),
                ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () async {
                    await updateUserPlants(plantID);
                    Navigator.pop(context);
                    setState(() {
                      plants_of_user = getUserPLants();
                    });
                    // getUserPLants();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Listtile(bool dry, String plantID, String plantName, String watered_on,
      String plantedON) {
    print(dry);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          // style: ListTileStyle,
          trailing: Text("Last watered:\n $watered_on"),
          subtitle: Text("Planted on: $plantedON"),
          title: Text("$plantName"),
          tileColor: Colors.blue,
          leading: dry
              ? Image.asset("images/dry-tree2.png", height: 60)
              : Image.asset("images/watered-tree2.png", height: 60),

          onTap: () {
            showbottom(plantID);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          Container(
            // color: Colors.blueAccent,
            // height: 100,
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
              "YOUR CURRENT\n TREE STATUS",
              style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(fontSize: 60)),
            )),
          ),
          FutureBuilder<List<Plant>?>(
              future: plants_of_user,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : Column(
                        children: List.generate(
                          snapshot.data!.length,
                          (index) {
                            return Listtile(
                              snapshot.data![index].dry ?? false,
                              snapshot.data![index].plantID ?? "null",
                              snapshot.data![index].name ?? "null",
                              snapshot.data![index].last_watered_on ?? "null",
                              snapshot.data![index].date_of_birth ?? "null",
                            );

                            // Text(snapshot.data?[index].name ?? "null");
                          },
                        ),
                      );
              })
          // Listtile(true, UID),
          // Listtile(false, UID),
        ]),
      ),
    );
  }
}
