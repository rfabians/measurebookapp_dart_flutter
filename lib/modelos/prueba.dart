
class consultaMunicipios {

  // construcción de modelo de datos para la consulta.
  int PK_MUNICIPIOS;
  String NOMBRE;

  consultaMunicipios({this.PK_MUNICIPIOS,this.NOMBRE});

  // Pasando los datos de map a Json

  factory consultaMunicipios.fromMap(Map<String, dynamic> json) => new consultaMunicipios(
    PK_MUNICIPIOS: json["PK_MUNICIPIOS"],
    NOMBRE: json["NOMBRE"]
  );
  }

