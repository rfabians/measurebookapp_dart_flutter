class CoordenadasElipsoidales {
  double latitud, longitud, altitud;

  CoordenadasElipsoidales ({this.latitud, this.longitud, this.altitud});

  factory CoordenadasElipsoidales.fromMap(Map<String, dynamic> json) => new CoordenadasElipsoidales(
    latitud: json["latitud"],
    longitud: json["longitud"],
    altitud: json["altitud"]
  );

}

