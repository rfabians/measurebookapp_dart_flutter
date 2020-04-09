

class CoordenadasGauss {
  double norte, este, altura;
  String idPunto, tipoAltura;
  CoordenadasGauss ({ this.idPunto, this.norte, this.este, this.altura, this.tipoAltura});

  factory CoordenadasGauss.fromMap(Map<String, dynamic> json) => new CoordenadasGauss(
    idPunto: json['idPunto'],
    norte: json["norte"],
    este: json["este"],
    altura: json["altura"],
    tipoAltura: json["tipoAltura"],
  );

}

