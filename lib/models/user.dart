

import 'plant.dart';
import 'package:news/constants/constants.dart';

class User {
  String? name;
  String? email;
  int? no_of_plants;
  int? dry_plants;
  int? watered_plants;
  List<Plant>? plants_list;
  User({this.email, this.name});
  User.fromJSON(Map<String, dynamic> json) {
    no_of_plants = json["no_plants"];
    watered_plants = json["no_watered"];
    dry_plants = json["no_dry"];
    email = User_email;
    name = username;
    // no_of_plants=
  }
  void printUser() {
    print(name);
  }
}