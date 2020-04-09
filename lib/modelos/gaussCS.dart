
class GaussCS {
   int PK_ORIGENES_GAUSS;
   double LATITUD, LONGITUD, NORTE, ESTE, N0;
   GaussCS({ this.PK_ORIGENES_GAUSS, this.LATITUD, this.LONGITUD, this.NORTE, this.ESTE, this.N0});
   
   factory GaussCS.fromMap(Map<String, dynamic> json) => new GaussCS(
    PK_ORIGENES_GAUSS: json["PK_ORIGENES_GAUSS"],
    LATITUD: json['LATITUD'],
    LONGITUD: json['LONGITUD'],
    NORTE: json['NORTE'],
    ESTE: json['ESTE'],
    N0: json['N0']
   );
 }