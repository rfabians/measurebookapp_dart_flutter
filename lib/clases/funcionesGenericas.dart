import 'dart:math' as m;
class FuncionesGenericas {


  static final FuncionesGenericas mb = FuncionesGenericas();


  double redondearDouble(double value, int places){ 
   double mod = m.pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}

String decimal2Hexadecimal(double decimal){
  if (decimal <0){
   decimal = decimal *-1;
   int grados = decimal.toInt();
   int minutos = ((decimal - grados)*60).toInt();
   double segundos = FuncionesGenericas.mb.redondearDouble((decimal -grados - minutos/60)*3600,4);
   String hexadecimal = "-${grados}° ${minutos}' ${segundos}''";
   return hexadecimal;
  }else{
   int grados = decimal.toInt();
   int minutos = ((decimal - grados)*60).toInt();
   double segundos = FuncionesGenericas.mb.redondearDouble((decimal -grados - minutos/60)*3600,4);
   String hexadecimal = "${grados}° ${minutos}' ${segundos}''";
   return hexadecimal;
  }
   
 }

 String tiempoRastreo (double distancia, String norma){
   if (norma == 'IGAC RES 643 30/05/2018'){
     double tiempo = 25+5*(distancia/1000);
     int hora = (tiempo/60).toInt();
     int minutos = (tiempo-hora*60).toInt();
     String tiempoRastreo = '${hora} Horas ${minutos} minutos';
     return tiempoRastreo;
   }else if(norma == 'IDU Elab. Estudios Top.'){
     double tiempo = 25+5*(distancia/1000);
     int hora = (tiempo/60).toInt();
     int minutos = (tiempo-hora*60).toInt();
     String tiempoRastreo = '${hora} Horas ${minutos} minutos';
     return tiempoRastreo;
   }else if(norma == 'EAB NS-030'){
     double tiempo = 20+5*(distancia/1000);
     int hora = (tiempo/60).toInt();
     int minutos = (tiempo-hora*60).toInt();
     String tiempoRastreo = '${hora} Horas ${minutos} minutos';
     return tiempoRastreo;
   }
 }
}