class Obstaculos{
  double azimut, anguloVertical;

  Obstaculos({this.azimut, this.anguloVertical});

  factory Obstaculos.fromMap(Map<String, dynamic> json) => new Obstaculos(
      azimut: json["Azimut"],
      anguloVertical: json["Angulo Vertical"],
  );
}