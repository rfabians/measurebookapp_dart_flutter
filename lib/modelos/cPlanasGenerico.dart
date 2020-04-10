class CPlanasGenerico {
  String nombrePunto;
  bool tipoAltura;
  double norte,este,altura;

  CPlanasGenerico({this.nombrePunto, this.norte, this.este, this.altura, this.tipoAltura});
  factory CPlanasGenerico.fromMap(Map<String, dynamic> json) => new CPlanasGenerico(
    nombrePunto: json["nombrePunto"],
    norte: json["norte"],
    este: json["este"],
    altura: json["altura"],
    tipoAltura: json["tipoAltura"]
  );
}