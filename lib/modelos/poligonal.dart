class Poligonal {
  String nombrePoligonal, serieEquipo, tipoPoligonal;
  int precisionEquipo, numeroSeries;
  String nomPArmadoIni, nomPVIsadoIni, nomPVIsadofin, nomPArmadofin, cerrada;

  Poligonal(
      {this.nombrePoligonal,
      this.tipoPoligonal,
      this.serieEquipo,
      this.nomPArmadoIni,
      this.nomPVIsadoIni,
      this.precisionEquipo,
      this.nomPArmadofin,
      this.nomPVIsadofin,
      this.numeroSeries,
      this.cerrada});

  factory Poligonal.fromMap(Map<String, dynamic> json) => new Poligonal(
        nombrePoligonal: json["nombrePoligonal"],
        tipoPoligonal: json["tipoPoligonal"],
        serieEquipo: json['serieEquipo'],
        nomPArmadoIni: json['nomPArmadoIni'],
        nomPVIsadoIni: json['nomPVIsadoIni'],
        nomPArmadofin: json['nomPArmadofin'],
        nomPVIsadofin: json['nomPVIsadofin'],
        numeroSeries: json['numeroSeries'],
        precisionEquipo: json['precisionEquipo'],
        cerrada: json['cerrada'],
      );
}
