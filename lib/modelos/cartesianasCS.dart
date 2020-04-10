class CartesianasCS {
   String NOMBRE;
   double LATITUD, LONGITUD, NORTE, ESTE, PLANO_PROY;
   CartesianasCS({ this.NOMBRE, this.LATITUD, this.LONGITUD, this.NORTE, this.ESTE, this.PLANO_PROY});
   
   factory CartesianasCS.fromMap(Map<String, dynamic> json) => new CartesianasCS(
    NOMBRE: json["NOMBRE"],
    LATITUD: json['LATITUD'],
    LONGITUD: json['LONGITUD'],
    NORTE: json['NORTE'],
    ESTE: json['ESTE'],
    PLANO_PROY: json['PLANO_PROY']
   );
 }