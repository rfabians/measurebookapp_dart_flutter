
class origenesCartesianos{
  int PK_ORIGENES_CART;
  int FK_MUNICIPIOS;
  String NOMBRE;
  double LATITUD;
  double LONGITUD;
  double NORTE;
  double ESTE;
  double PLANO_PROY;
  String DESCRIPCION;

  origenesCartesianos({this.PK_ORIGENES_CART, this.FK_MUNICIPIOS, this.NOMBRE, this.LATITUD, this.LONGITUD, this.NORTE, this.ESTE, this.PLANO_PROY, this.DESCRIPCION});

  factory origenesCartesianos.fromMap(Map<String, dynamic> json) => new origenesCartesianos(
    PK_ORIGENES_CART: json["PK_ORIGENES_CART"],
    FK_MUNICIPIOS: json["FK_MUNICIPIOS"],
    NOMBRE: json["NOMBRE"],
    LATITUD: json["LATITUD"],
    LONGITUD: json["LONGITUD"],
    NORTE: json["NORTE"],
    ESTE: json["ESTE"],
    PLANO_PROY: json["PLANO_PROY"],
    DESCRIPCION: json["DESCRIPCION"],
  );
}