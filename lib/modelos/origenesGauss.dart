
class origenesGauss{
  int PK_ORIGENES_GAUSS;
  String NOMBRE;
  double LATITUD;
  double LONGITUD;
  double NORTE;
  double ESTE;

  origenesGauss({this.PK_ORIGENES_GAUSS, this.NOMBRE, this.LATITUD, this.LONGITUD, this.NORTE, this.ESTE});

  factory origenesGauss.fromMap(Map<String, dynamic> json) => new origenesGauss(
    PK_ORIGENES_GAUSS: json["PK_ORIGENES_GAUSS"],
    NOMBRE: json["NOMBRE"],
    LATITUD: json["LATITUD"],
    LONGITUD: json["LONGITUD"],
    NORTE: json["NORTE"],
    ESTE: json["ESTE"],
  );
}