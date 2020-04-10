
class GaussCS {
    String NOMBRE;
   double LATITUD, LONGITUD, NORTE, ESTE, N0;
   GaussCS({ this.NOMBRE, this.LATITUD, this.LONGITUD, this.NORTE, this.ESTE, this.N0});
   
   factory GaussCS.fromMap(Map<String, dynamic> json) => new GaussCS(
    NOMBRE: json["NOMBRE"],
    LATITUD: json['LATITUD'],
    LONGITUD: json['LONGITUD'],
    NORTE: json['NORTE'],
    ESTE: json['ESTE'],
    N0: json['N0']
   );
 }