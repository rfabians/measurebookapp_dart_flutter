

class municipios {
  int PK_MUNICIPIOS;
  int FK_DEPARTAMENTOS;
  String NOMBRE;

  municipios({this.PK_MUNICIPIOS, this.FK_DEPARTAMENTOS, this.NOMBRE});

  factory municipios.fromMap(Map<String, dynamic> json) => new municipios(
    PK_MUNICIPIOS: json["PK_MUNICIPIOS"],
    FK_DEPARTAMENTOS: json["FK_DEPARTAMENTOS"],
    NOMBRE: json["NOMBRE"]
  );
}