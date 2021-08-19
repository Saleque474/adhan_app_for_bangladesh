class Location {
  List<Districts> districts;
  Location(
    this.districts,
  );
  factory Location.fromJson(Map json) {
    return Location(
      (json["districts"] as List<dynamic>)
          .map((e) => Districts.fromJson(e))
          .toList(),
    );
  }
}

class Districts {
  List<Zilas> zilas;
  String name;
  Districts(
    this.zilas,
    this.name,
  );
  factory Districts.fromJson(Map json) {
    return Districts(
      (json["zilas"] as List<dynamic>).map((e) => Zilas.fromJson(e)).toList(),
      json["name"],
    );
  }
}

class Zilas {
  List<Upazilas> upazilas;
  String name;
  Zilas(
    this.upazilas,
    this.name,
  );
  factory Zilas.fromJson(Map json) {
    return Zilas(
      (json["upazilas"] as List<dynamic>)
          .map((e) => Upazilas.fromJson(e))
          .toList(),
      json["name"],
    );
  }
}

class Upazilas {
  String name;
  double lat;
  double long;
  Upazilas(
    this.name,
    this.lat,
    this.long,
  );
  factory Upazilas.fromJson(Map json) {
    return Upazilas(
      json["name"],
      json["lat"],
      json["long"],
    );
  }
}
