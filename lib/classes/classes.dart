class Locations {
  List<Zilas> zilas;
  Locations(
    this.zilas,
  );
  factory Locations.fromJson(Map json) {
    return Locations(
      (json["zilas"] as List<dynamic>).map((e) => Zilas.fromJson(e)).toList(),
    );
  }
}

class Zilas {
  List<Districts> districts;
  String name;
  Zilas(
    this.districts,
    this.name,
  );
  factory Zilas.fromJson(Map json) {
    return Zilas(
      (json["districts"] as List<dynamic>)
          .map((e) => Districts.fromJson(e))
          .toList(),
      json["name"],
    );
  }
}

class Districts {
  List<Subdistricts> subdistricts;
  String name;
  Districts(
    this.subdistricts,
    this.name,
  );
  factory Districts.fromJson(Map json) {
    return Districts(
      (json["subdistricts"] as List<dynamic>)
          .map((e) => Subdistricts.fromJson(e))
          .toList(),
      json["name"],
    );
  }
}

class Subdistricts {
  String name;
  int lat;
  int long;
  Subdistricts(
    this.name,
    this.lat,
    this.long,
  );
  factory Subdistricts.fromJson(Map json) {
    return Subdistricts(
      json["name"],
      json["lat"],
      json["long"],
    );
  }
}
