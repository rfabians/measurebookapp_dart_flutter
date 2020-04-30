
class AltNiveladas{
  int fkPunto, fecha;
  String nomenclatura, municipio, departamento, estPunto;
  double latitud, longitud, altElipsoidal, x,y,z, vx,vy,vz,ondulacion, zNivelada;

  AltNiveladas({this.fkPunto, this.fecha, this.nomenclatura, this.municipio, this.departamento, this.estPunto, this.latitud,
                this.longitud, this.altElipsoidal, this.x, this.y, this.z, this.ondulacion, this.vx, this.vy, this.vz, this.zNivelada
                });

  factory AltNiveladas.fromMap(Map<String, dynamic> json) => new AltNiveladas(
      nomenclatura:       json["Nomenclatu"],
      municipio:          json["Municipio"],
      departamento:       json["Departamen"],
      estPunto:           json["Estado_pun"],
      fecha:              json["FECHA"],
      latitud:            json["Latitud"],
      longitud:           json["Longitud"],
      altElipsoidal:      json["Altura_eli"],
      x:                  json["X"],
      y:                  json["Y"],
      z:                  json["Z"],
      vx:                 json["Vx"],
      vy:                 json["Vy"],
      vz:                 json["Vz"],
      ondulacion:         json["Ondulacion"],
      zNivelada:          json["Z_Nivelada"],
      fkPunto:            json["FK_Punto"],
  );
}