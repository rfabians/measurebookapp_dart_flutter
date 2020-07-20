class LecturaPoligonal {
  double anguloHorizontalAtras,
      anguloHorizontalAdelante,
      anguloVerticalAtras,
      anguloVerticalAdelante,
      distanciaAtras,
      distanciaAdelante,
      alturaObjetoAtras,
      alturaObjetoAdelante,
      alturaInstrumental,
      factorEscala,
      desviacionAngulo,
      desviacionDistanciaAtras,
      desviacionDistanciaAdelante;
  String nombrePuntoArmado,
      nombreBacksite,
      nombreVisado,
      idUser,
      nombreProyecto,
      nombrePoligonal;

  LecturaPoligonal(
      {this.nombreProyecto,
      this.idUser,
      this.nombrePoligonal,
      this.nombrePuntoArmado,
      this.nombreBacksite,
      this.nombreVisado,
      this.anguloHorizontalAtras,
      this.anguloHorizontalAdelante,
      this.anguloVerticalAtras,
      this.anguloVerticalAdelante,
      this.distanciaAtras,
      this.distanciaAdelante,
      this.alturaObjetoAtras,
      this.alturaObjetoAdelante,
      this.alturaInstrumental,
      this.desviacionAngulo,
      this.desviacionDistanciaAdelante,
      this.desviacionDistanciaAtras,
      this.factorEscala});

  factory LecturaPoligonal.fromMap(Map<String, dynamic> json) =>
      new LecturaPoligonal(
        nombrePoligonal: json["NOMBRE_POLIGONAL"],
        idUser: json["ID_USER"],
        nombreProyecto: json["NOMBRE_PROYECTO"],
        nombreBacksite: json["PUNTO_ATRAS"],
        nombrePuntoArmado: json["PUNTO_ARMADO"],
        nombreVisado: json["PUNTO_ADELANTE"],
        anguloHorizontalAdelante: json["ANGULO_HORIZONTAL_ADELANTE"],
        anguloHorizontalAtras: json["ANGULO_HORIZONTAL_ATRAS"],
        anguloVerticalAtras: json["ANGULO_VERTICAL_ATRAS"],
        anguloVerticalAdelante: json["ANGULO_VERTICAL_ADELANTE"],
        distanciaAtras: json["DISTANCIA_ATRAS"],
        distanciaAdelante: json["DISTANCIA_ADELANTE"],
        alturaObjetoAtras: json["ALTURA_OBJETO_ATRAS"],
        alturaObjetoAdelante: json["ALTURA_OBJETO_ADELANTE"],
        alturaInstrumental: json["ALTURA_INSTRUMENTAL"],
        factorEscala: json["FACTOR_ESCALA"],
        desviacionAngulo: json["DESVIACION_ANGULO"],
        desviacionDistanciaAdelante: json["DESVIACION_DISTANCIA_ADELANTE"],
        desviacionDistanciaAtras: json["DESVIACION_DISTANCIA_ATRAS"],
      );
}
