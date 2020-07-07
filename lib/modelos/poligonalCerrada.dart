import 'package:measurebookapp/modelos/puntosReferencia.dart';

class PoligonalCerradaDatos {
  String nombrePoligonal, serieEquipo;
  int precisionEquipo, numeroSeries;
  puntosReferencia armado, visado;
  PoligonalCerradaDatos(
      {this.nombrePoligonal,
      this.serieEquipo,
      this.armado,
      this.visado,
      this.precisionEquipo,
      this.numeroSeries});

  factory PoligonalCerradaDatos.fromMap(Map<String, dynamic> json) =>
      new PoligonalCerradaDatos(
        nombrePoligonal: json["nombrePoligonal"],
        serieEquipo: json['serieEquipo'],
        armado: json['armado'],
        visado: json['visado'],
        numeroSeries: json['numeroSeries'],
        precisionEquipo: json['precisionEquipo'],
      );
}
