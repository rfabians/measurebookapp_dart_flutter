
class Estaciones{
  int id;
  String nombre;
  double latitud, longitud;

  Estaciones({this.id, this.nombre, this.latitud, this.longitud});

  factory Estaciones.fromMap(Map<String, dynamic> json) => new Estaciones(
      id: json["id"],
      nombre: json["nombre"],
      latitud: json["latitud"],
      longitud: json["longitud"],
  );
}