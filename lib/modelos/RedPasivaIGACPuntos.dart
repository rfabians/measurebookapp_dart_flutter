
class redPIGACPuntos{
  int FID;
  dynamic FECHA;
  String Nomenclatu, Municipio, Departamen,Estado_pun;
  double Latitud, Longitud, Altura_eli, X, Y, Z, Vx, Vy, Vz,Ondulacion;

  redPIGACPuntos({this.FID, this.Nomenclatu, this.Municipio, this.Departamen, this.Estado_pun, this.FECHA, this.Latitud, this.Longitud, this.Altura_eli, this.X, this.Y, this.Z, this.Vx, this.Vy, this.Vz, this.Ondulacion});

  factory redPIGACPuntos.fromMap(Map<String, dynamic> json) => new redPIGACPuntos(
      FID: json["FID"],
      Nomenclatu: json["Nomenclatu"],
      Municipio: json["Municipio"],
      Departamen: json["Departamen"],
      Estado_pun: json["Estado_pun"],
      FECHA: json["FECHA"],
      Latitud: json["Latitud"],
      Longitud: json["Longitud"],
      Altura_eli: json["Altura_eli"],
      X: json["X"],
      Y: json["Y"],
      Z: json["Z"],
      Vx: json["Vx"],
      Vy: json["Vy"],
      Vz: json["Vz"],
      Ondulacion: json["Ondulacion"]
  );
}