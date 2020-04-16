

class puntosReferencia{
  int ID_Punto;
  String ID_Usuario;
  String Proyecto;
  String Nombre_Punto;
  double Norte;
  double Este;
  double Altura;
  double latitud;
  double longitud;
  String Tipo_Altura;
  String Descripcion;
  // Revisar almacensamiento de BLOB
  String Foto_Placa;
  String Foto_Norte;
  String Foto_Este;
  String Foto_Sur;
  String Foto_Oeste;

  puntosReferencia({this.ID_Punto, this.ID_Usuario, this.Proyecto, this.Nombre_Punto, this.Norte, this.Este, this.Altura, this.Tipo_Altura,this.latitud, this.longitud ,this.Descripcion, this.Foto_Placa, this.Foto_Norte, this.Foto_Este, this.Foto_Sur, this.Foto_Oeste});

  factory puntosReferencia.fromMap(Map<String, dynamic> json) => new puntosReferencia(
      ID_Punto: json["ID_Punto"],
      ID_Usuario: json["ID_Usuario"],
      Proyecto: json["Proyecto"],
      Nombre_Punto: json["Nombre_Punto"],
      Norte: json["Norte"],
      Este: json["Este"],
      Altura: json["Altura"],
      Tipo_Altura: json["Tipo_Altura"],
      Descripcion: json["Descripcion"],
      Foto_Placa: json["Foto_Placa"],
      Foto_Este: json["Foto_Este"],
      Foto_Norte: json["Foto_Norte"],
      Foto_Oeste: json["Foto_Oeste"],
      Foto_Sur: json["Foto_Sur"]
  );
}