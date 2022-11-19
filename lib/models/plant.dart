class Plant {
  String? UID;
  String? name;
  String? plantID;
  Map<String, String>? location = {"longitude": "", "latitude": ""};
  String? date_of_birth;
  String? last_watered_on;
  String? last_manured_on;
  int? water_req;
  bool? dry;
  Plant.fromJSON(Map<String, dynamic> json) {
    UID = json["user_id"];
    name = json["plant_name"];
    plantID = json["_id"];
    UID = json["user_id"];
    date_of_birth = json["date_of_plant"];
    last_watered_on = json["water_date"];
    last_manured_on = json["manure_date"];
    water_req = int.parse(json["water_req"]);
    location?["longitude"] = json["location"]["longitude"];
    location?["latitude"] = json["location"]["latitude"];
    dry = json["dry"];
    print(json["dry"].runtimeType);
    // no_of_plants=
  }
}