class CoordenadasON {
  double norte, este, altura;
  String idPunto;
  CoordenadasON ({ this.idPunto, this.norte, this.este, this.altura});

  factory CoordenadasON.fromMap(Map<String, dynamic> json) => new CoordenadasON(
    idPunto: json['idPunto'],
    norte: json["norte"],
    este: json["este"],
    altura: json["altura"],
  );

}

