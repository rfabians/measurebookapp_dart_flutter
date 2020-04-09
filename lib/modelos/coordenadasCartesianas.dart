class CoordenadasCartesianas {
  double norte, este, altura;
  String idPunto, tipoAltura;
  CoordenadasCartesianas ({ this.idPunto, this.norte, this.este, this.altura, this.tipoAltura});

  factory CoordenadasCartesianas.fromMap(Map<String, dynamic> json) => new CoordenadasCartesianas(
    idPunto: json['idPunto'],
    norte: json["norte"],
    este: json["este"],
    altura: json["altura"],
    tipoAltura: json["tipoAltura"],
  );

}

