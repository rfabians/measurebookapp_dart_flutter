class DescripcionSistemCoor {
  String nombreProyeccion, imagen, descripcion;
DescripcionSistemCoor({this.nombreProyeccion, this.descripcion, this.imagen});

 factory DescripcionSistemCoor.fromMap(Map<String, dynamic> json) => new DescripcionSistemCoor(
    nombreProyeccion: json["nombreProyeccion"],
    imagen: json["imagen"],
    descripcion: json["descripcion"]
  );
  
}