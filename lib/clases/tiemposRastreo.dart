

class TiemposRastreo {
  
  String formatoTiempo (double minutos) {
    int minutosInt = minutos.toInt();
    int horas = (minutosInt/60).toInt();
    int minutosResidual = minutosInt - horas*60;
    
    if (horas>0) {
      String tiempoOcupacion = '${horas}h: ${minutosResidual} minutos';
      return tiempoOcupacion;
    }else {
      String tiempoOcupacion = '${minutosResidual} minutos';
      return tiempoOcupacion;
    }
  }

}