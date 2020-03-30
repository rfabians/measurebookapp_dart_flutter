class obtenerNombreProyeccionGauss {
  dynamic nombre;
  obtenerNombreProyeccionGauss({this.nombre});
  factory obtenerNombreProyeccionGauss.fromMap(Map<String, String> json) => new obtenerNombreProyeccionGauss(
    nombre: json["NOMBRE"]
  );

}
