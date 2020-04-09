class CoordenadasGeocentricas {
  double x,y,z;

  CoordenadasGeocentricas ({this.x, this.y, this.z});

    factory CoordenadasGeocentricas.fromMap(Map<String, dynamic> json) => new CoordenadasGeocentricas(
    x: json["x"],
    y: json["y"],
    z: json["z"]
  );
}