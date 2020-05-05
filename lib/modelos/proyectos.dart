
class proyectos{
  int ID_PROYECTO;
  String ID_USUARIO;
  String Nombre_Proyecto;
  String Tipo_Proyeccion;
  String ID_Proyeccion;
  String Ubicacion;
  String Empresa;
  String Cliente;
  String Descripcion;
  
  proyectos({this.ID_PROYECTO, this.ID_USUARIO, this.Nombre_Proyecto, this.Tipo_Proyeccion, this.ID_Proyeccion, this.Ubicacion, this.Empresa, this.Cliente, this.Descripcion});

  factory proyectos.fromMap(Map<String, dynamic> json) => new proyectos(
    ID_PROYECTO:        json["ID_PROYECTO"],
    ID_USUARIO:         json["ID_USUARIO"],
    Nombre_Proyecto:    json["Nombre_Proyecto"],
    Tipo_Proyeccion:    json["Tipo_Proyeccion"],
    ID_Proyeccion:      json["ID_Proyeccion"],
    Ubicacion:          json["Ubicacion"],
    Empresa:            json["Empresa"],
    Cliente:            json["Cliente"],
    Descripcion:        json["Descripcion"]
  );
}