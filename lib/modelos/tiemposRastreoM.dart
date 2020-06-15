
class TiemposRastreoM{
  String nombre, tiempoRastreo, entidadRespondable;
  double distancia, latitud, longitud;
  

  TiemposRastreoM({this.nombre, this.tiempoRastreo, this.entidadRespondable, this.distancia, this.latitud, this.longitud});

  factory TiemposRastreoM.fromMap(Map<String, dynamic> json) => new TiemposRastreoM(
      nombre: json["nombre"],
      tiempoRastreo: json["tiempoRastreo"],
      entidadRespondable: json["entidadRespondable"],
      distancia: json["distancia"],
      latitud: json["latitud"],
      longitud: json["longitud"],
  );
}