class CartesianasCS {
   int PK_ORIGENES_CART;
   double LATITUD, LONGITUD, NORTE, ESTE, PLANO_PROY;
   CartesianasCS({ this.PK_ORIGENES_CART, this.LATITUD, this.LONGITUD, this.NORTE, this.ESTE, this.PLANO_PROY});
   
   factory CartesianasCS.fromMap(Map<String, dynamic> json) => new CartesianasCS(
    PK_ORIGENES_CART: json["PK_ORIGENES_GAUSS"],
    LATITUD: json['LATITUD'],
    LONGITUD: json['LONGITUD'],
    NORTE: json['NORTE'],
    ESTE: json['ESTE'],
    PLANO_PROY: json['PLANO_PROY']
   );
 }