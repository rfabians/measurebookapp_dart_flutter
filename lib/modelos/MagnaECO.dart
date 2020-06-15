
class MagnaEco{
  int id;
  String nombre;
  double latitud, longitud;

  MagnaEco({this.id, this.nombre, this.latitud, this.longitud});

  factory MagnaEco.fromMap(Map<String, dynamic> json) => new MagnaEco(
      id: json["ID"],
      nombre: json["NOMBRE"],
      latitud: json["Lat"],
      longitud: json["Lon"],
  );
}