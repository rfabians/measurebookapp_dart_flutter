
class GeoRED{
  int id;
  String nombre;
  double latitud, longitud;

  GeoRED({this.id, this.nombre, this.latitud, this.longitud});

  factory GeoRED.fromMap(Map<String, dynamic> json) => new GeoRED(
      id: json["ID"],
      nombre: json["NOMBRE"],
      latitud: json["LATITUD"],
      longitud: json["LONGITUD"],
  );
}