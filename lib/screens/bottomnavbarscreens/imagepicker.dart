import 'dart:io' as io;
import 'dart:convert';
import 'dart:io';
// import 'package:back_dead/bottomnavscreens/plantsform.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/screens/bottomnavbarscreens/plants_add.dart';

class helper {
  bool? isplant;
  String? plantname;
  helper(this.isplant, this.plantname);
}

class imagePickerScreen extends StatefulWidget {
  imagePickerScreen();
  @override
  State<imagePickerScreen> createState() => _imagePickerScreenState();
}

class _imagePickerScreenState extends State<imagePickerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var tst = null;
  Dio dio = Dio();
  @override
  io.File? image;

  void reselect() {
    setState(() {
      image = null;
      tst = null;
    });
  }

  Future<helper?> getHelp() async {}
  Future getimage(BuildContext ctx) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imagetemproray = io.File(image.path);
    print(image.path);
    setState(() {
      this.image = imagetemproray;
    });
    tst = "Loading...";
    checkPLant();
  }

  String load = "Loading";
  bool resel = false;

  void checkPLant() async {
    final bytes = io.File(image!.path).readAsBytesSync();
    // print(bytes);
    String base64Image = base64Encode(bytes);
    List<String> lsl = [base64Image];
    Map<String, dynamic> data = {
      "api_key": "klnIJqmbwst2U3F0NZXVSuemVBsLcaGqJ2Y6ITYnEWBrqsSFi3",
      "images": lsl,
      "plant_language": "en",
    };
    var response = await dio.post(
      "https://api.plant.id/v2/identify",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(data),
    );
    String name = response.data["suggestions"][0]["plant_name"];
    print(response.data["is_plant"]);
    setState(() {
      if (!response.data["is_plant"]) {
        resel = true;
        tst = "Selected image is not a plant";
      } else {
        nme = name;
        resel = false;
        tst = "Selected image is a plant\nPredicted Plant Name = $name";
      }
    });
    // if (response.data["is_plant"])
  }

  String nme = "";
  void pushing() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => formscreen(nme)),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.blueAccent,
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Container(
            child: image == null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Select image\n     of tree",
                          style: GoogleFonts.bebasNeue(fontSize: 30,color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            getimage(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 300,
                            width: 300,
                            child: Icon(
                              Icons.add,
                              size: 32,
                            ),
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(25),
                                color: Colors.grey.withOpacity(0.7),
                                border: Border.all(color: Colors.grey, width: 3)),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Select image\n     of tree",
                          style: GoogleFonts.bebasNeue(fontSize: 30,color: Colors.white),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 300,
                          width: 300,
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(color: Colors.grey, width: 3)),
                        ),)

                        // FutureBuilder(
                        //   future: ,
                        //   builder: (ctx) {})
                      ],
                    ),
                  ),
          ),
          Center(
            child: Container(
              child: tst == null
                  ? Text(
                      "",
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "$tst",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 16,
                          ),
                        ),
                        nme == ""
                            ? resel
                                ? ElevatedButton(
                                    onPressed: reselect, child: Text("Re-Select",style: GoogleFonts.bebasNeue(fontSize: 15,color: Colors.white),))
                                : Text("")
                            : ElevatedButton(
                                onPressed: pushing, child: Text("Proceed",style: GoogleFonts.bebasNeue(fontSize: 15,color: Colors.white)))
                      ],
                    ),
            ),
          ),
      ],
    ),
        ));
  }
}