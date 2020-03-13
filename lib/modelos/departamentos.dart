class departamentos {
  int PK_DEPARTAMENTO;
  String NOMBRE;

  departamentos({this.PK_DEPARTAMENTO, this.NOMBRE});

  // pasando los Datos a JSON
  factory departamentos.fromMap(Map<String, dynamic> json) => new departamentos(
    PK_DEPARTAMENTO: json["PK_DEPARTAMENTOS"],
    NOMBRE: json["NOMBRE"]

  );

}