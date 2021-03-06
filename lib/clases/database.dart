import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:measurebookapp/modelos/GeoRED.dart';
import 'package:measurebookapp/modelos/MagnaECO.dart';
import 'package:measurebookapp/modelos/RedPasivaIGACPuntos.dart';
import 'package:measurebookapp/modelos/altNiveladas.dart';
import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
import 'package:measurebookapp/modelos/municipios.dart';
import 'package:measurebookapp/modelos/origenesCartesianos.dart';
import 'package:measurebookapp/modelos/origenesGauss.dart';
import 'package:measurebookapp/modelos/poligonal.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:measurebookapp/modelos/lecturaPoligonal.dart';

class gestorMBDatabase {
  gestorMBDatabase._();

  static final gestorMBDatabase db = gestorMBDatabase._();

  mbBasedeDatos() async {
    WidgetsFlutterBinding.ensureInitialized();
    var obtenerrutaBaseDatos = await getDatabasesPath();
    var rutaDB = join(obtenerrutaBaseDatos, "assets/database/mbdatabase.db");

// Verificar si la base de datos modelo ya fue importada dentro del sistema de archivos de Flutter
    var verificacionDB = await databaseExists(rutaDB);

    if (!verificacionDB) {
      // Importación de la base de datos, para primero uso dentro de la APP
      print("Creando copia de Base de Datos MeasureBookAPP");

      // Obtener la ruta donde está almacenada la base de datos, dentro del sistema de l sistema de archivos de la APP
      try {
        await Directory(dirname(rutaDB)).create(recursive: true);
      } catch (_) {
        print('No se logro cargar la base de Datos de MasureBookAPP');
      }

      // Realizar la copia de la base de datos de la carpeta Assets al directorio interno de la APP (Obtenido Documentación SQFLite GitHUB)
      ByteData data =
          await rootBundle.load(join("assets/database/", "mbdatabase.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Almacenar la base de datos dentro del sistema de archivos
      await File(rutaDB).writeAsBytes(bytes, flush: true);
    } else {
      print("Abriendo base de datos cargada con Anterioridad");
    }
    // Abrir base de Datos
    var measurebookAPP_DB = await openDatabase(rutaDB);

    return measurebookAPP_DB;
  }

  // GuardarPoligonal
  void guardarPoligonal(
      Poligonal dataPoligonal, String idUser, String nombreProyecto) async {
    Database db = await mbBasedeDatos();
    db.rawQuery(
        'INSERT INTO POLIGONAL ("idUser","nombreProyecto", "nombrePoligonal", "tipoPoligonal", "serieEquipo", "nomPArmadoIni", "nomPVIsadoIni", "nomPArmadofin", "nomPVIsadofin", "numeroSeries", "precisionEquipo") VALUES ("${idUser}", "${nombreProyecto}", "${dataPoligonal.nombrePoligonal}", "${dataPoligonal.tipoPoligonal}", "${dataPoligonal.serieEquipo}",  "${dataPoligonal.nomPArmadoIni}", "${dataPoligonal.nomPVIsadoIni}", "${dataPoligonal.nomPArmadofin}", "${dataPoligonal.nomPVIsadofin}", "${dataPoligonal.numeroSeries}", "${dataPoligonal.precisionEquipo}")');
  }

// Guardar datos Lecturas Poligonal
  void guardarLecturaPoligonal(
    LecturaPoligonal lecturaPoligonal,
  ) async {
    Database db = await mbBasedeDatos();
    db.rawQuery(
        'INSERT INTO OBSERVACIONES_POLIGONAL ("ID_USER", "NOMBRE_PROYECTO", "NOMBRE_POLIGONAL", "PUNTO_ARMADO", "PUNTO_ATRAS", "PUNTO_ADELANTE", "ANGULO_HORIZONTAL_ATRAS", "ANGULO_HORIZONTAL_ADELANTE", "DISTANCIA_ATRAS", "DISTANCIA_ADELANTE", "DESVIACION_ANGULO", "DESVIACION_DISTANCIA_ADELANTE", "DESVIACION_DISTANCIA_ATRAS", "ANGULO_VERTICAL_ADELANTE","ANGULO_VERTICAL_ATRAS","ALTURA_OBJETO_ATRAS","ALTURA_OBJETO_ADELANTE","ALTURA_INSTRUMENTAL","FACTOR_ESCALA") VALUES("${lecturaPoligonal.idUser}", "${lecturaPoligonal.nombreProyecto}", "${lecturaPoligonal.nombrePoligonal}", "${lecturaPoligonal.nombrePuntoArmado}", "${lecturaPoligonal.nombreBacksite}", "${lecturaPoligonal.nombreVisado}", "${lecturaPoligonal.anguloHorizontalAtras}", "${lecturaPoligonal.anguloHorizontalAdelante}", "${lecturaPoligonal.distanciaAtras}", "${lecturaPoligonal.distanciaAdelante}", "${lecturaPoligonal.desviacionAngulo}", "${lecturaPoligonal.desviacionDistanciaAdelante}", "${lecturaPoligonal.desviacionDistanciaAtras}", "${lecturaPoligonal.anguloHorizontalAdelante}", "${lecturaPoligonal.anguloVerticalAtras}", "${lecturaPoligonal.alturaObjetoAtras}", "${lecturaPoligonal.alturaObjetoAdelante}", "${lecturaPoligonal.alturaInstrumental}", "${lecturaPoligonal.factorEscala}")');
  }

  //Validar Nombre Poligonal
  Future<bool> validarNombrePoligonal(String nomPoligonal) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        'SELECT nombrePoligonal FROM POLIGONAL WHERE nombrePoligonal = "${nomPoligonal}"');
    List<Poligonal> listaPoligonal =
        response.map((c) => Poligonal.fromMap(c)).toList();
    if (listaPoligonal.length > 0) {
      return true;
    } else {
      return false;
    }
  }
  // Consultar Listado de Municipios

  Future<List<municipios>> getMunicipios(int codigoDepartamento) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        "SELECT PK_MUNICIPIOS, NOMBRE FROM MUNICIPIOS WHERE FK_DEPARTAMENTOS=$codigoDepartamento");
    List<municipios> listaMunicipios =
        response.map((c) => municipios.fromMap(c)).toList();
    return listaMunicipios;
  }

  // Consulta Lista departamentos
  Future<List<departamentos>> getDepartamentos() async {
    Database db = await mbBasedeDatos();
    var response =
        await db.rawQuery("SELECT PK_DEPARTAMENTO,NOMBRE FROM DEPARTAMENTOS");
    List<departamentos> listaDepartamentos =
        response.map((c) => departamentos.fromMap(c)).toList();

    return listaDepartamentos;
  }

  //Consulta lista de LecturasPoligonal
  Future<List<LecturaPoligonal>> getLecturasPoligonales(
      String idUser, nombreProyecto, nombrePoligonal) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        "SELECT * FROM OBSERVACIONES_POLIGONAL WHERE ID_USER = '${idUser}' AND NOMBRE_PROYECTO = '${nombreProyecto}' AND NOMBRE_POLIGONAL='${nombrePoligonal}'");
    List<LecturaPoligonal> listadoObservaciones =
        response.map((c) => LecturaPoligonal.fromMap(c)).toList();
    return listadoObservaciones;
  }

  // Consulta lista de Poligonales
  Future<List<Poligonal>> getPoligonales(String idUser, nombreProyecto) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        "SELECT * FROM POLIGONAL WHERE idUser = '${idUser}' AND nombreProyecto = '${nombreProyecto}'");
    List<Poligonal> listaPoligonales =
        response.map((c) => Poligonal.fromMap(c)).toList();
    return listaPoligonales;
  }

  // Consulta lista de Proyectos
  Future<List<proyectos>> getProyectos() async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery("SELECT * FROM PROYECTOS");
    List<proyectos> listaProyectos =
        response.map((c) => proyectos.fromMap(c)).toList();
    return listaProyectos;
  }

  // Consultar Listado de Sistema de coordenadas GAUSS
  Future<List<origenesGauss>> getGauss() async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        "SELECT PK_ORIGENES_GAUSS, NOMBRE, LATITUD, LONGITUD, NORTE, ESTE FROM ORIGENES_GAUSS WHERE FK_SISTEMA = 1");
    List<origenesGauss> listaGauss =
        response.map((c) => origenesGauss.fromMap(c)).toList();
    return listaGauss;
  }

  Future<List<origenesCartesianos>> getCartesianas(int fk_Municipio) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        "SELECT PK_ORIGENES_CART, FK_MUNICIPIOS, NOMBRE, LATITUD, LONGITUD, NORTE, ESTE, PLANO_PROY, DESCRIP FROM ORIGENES_CART WHERE (FK_SISTEMA=1) AND (FK_MUNICIPIOS=${fk_Municipio})");
    List<origenesCartesianos> listaCartesianas =
        response.map((c) => origenesCartesianos.fromMap(c)).toList();
    return listaCartesianas;
  }

  void InserDataSQL(String inserSQL) async {
    Database db = await mbBasedeDatos();
    db.rawQuery(inserSQL);
  }

  Future<List<redPIGACPuntos>> getPuntosRedPIGAC() async {
    WidgetsFlutterBinding.ensureInitialized();
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery('SELECT * FROM RED_PASIVA_IGAC');
    List<redPIGACPuntos> listaPuntosRedPasivaIGAC =
        response.map((c) => redPIGACPuntos.fromMap(c)).toList();
    return listaPuntosRedPasivaIGAC;
  }

  Future<List<AltNiveladas>> getPuntosAlturasNiveladasPIGAC() async {
    WidgetsFlutterBinding.ensureInitialized();
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery('SELECT * FROM ALTURAS_NIVELADAS');
    List<AltNiveladas> alturasNiveladasIGAC =
        response.map((c) => AltNiveladas.fromMap(c)).toList();
    return alturasNiveladasIGAC;
  }

  Future<GaussCS> getOrigenGaussData(String idProyeccionGauss) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        'SELECT NOMBRE, LATITUD, LONGITUD, NORTE, ESTE, N0 FROM ORIGENES_GAUSS WHERE NOMBRE = "${idProyeccionGauss}" AND FK_SISTEMA = 1;');
    List<GaussCS> datosOrigenGauss =
        response.map((c) => GaussCS.fromMap(c)).toList();
    GaussCS datosGaussOrigen = GaussCS();
    datosGaussOrigen.NOMBRE = datosOrigenGauss[0].NOMBRE;
    datosGaussOrigen.LATITUD = datosOrigenGauss[0].LATITUD;
    datosGaussOrigen.LONGITUD = datosOrigenGauss[0].LONGITUD;
    datosGaussOrigen.NORTE = datosOrigenGauss[0].NORTE;
    datosGaussOrigen.ESTE = datosOrigenGauss[0].ESTE;
    datosGaussOrigen.N0 = datosOrigenGauss[0].N0;

    return datosGaussOrigen;
  }

  Future<CartesianasCS> getOrigenCartesianoData(
      String idProyeccionCartesiana) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        'SELECT NOMBRE, LATITUD, LONGITUD, NORTE, ESTE, PLANO_PROY FROM ORIGENES_CART WHERE NOMBRE = "${idProyeccionCartesiana}" AND FK_SISTEMA = 1');
    List<CartesianasCS> datosOrigenCartesianos =
        response.map((c) => CartesianasCS.fromMap(c)).toList();
    CartesianasCS datosCartesainosOrigen = CartesianasCS();
    datosCartesainosOrigen.NOMBRE = datosOrigenCartesianos[0].NOMBRE;
    datosCartesainosOrigen.LATITUD = datosOrigenCartesianos[0].LATITUD;
    datosCartesainosOrigen.LONGITUD = datosOrigenCartesianos[0].LONGITUD;
    datosCartesainosOrigen.NORTE = datosOrigenCartesianos[0].NORTE;
    datosCartesainosOrigen.ESTE = datosOrigenCartesianos[0].ESTE;
    datosCartesainosOrigen.PLANO_PROY = datosOrigenCartesianos[0].PLANO_PROY;

    return datosCartesainosOrigen;
  }

  Future<List<puntosReferencia>> getPuntosReferenciaData(
      String nombrePRoyecto) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        'SELECT ID_Punto, Id_Usuario, Proyecto, Nombre_Punto, Norte,  Este, Altura, Tipo_Altura, Foto_Placa, Foto_Norte, Foto_Este, Foto_Sur, Foto_Oeste FROM PUNTOS_REFERENCIA WHERE Proyecto = "${nombrePRoyecto}"');
    List<puntosReferencia> listaPuntosRef =
        response.map((c) => puntosReferencia.fromMap(c)).toList();
    return listaPuntosRef;
  }

  Future<bool> validarNombreProyecto(String nomProyecto) async {
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery(
        'SELECT Nombre_Proyecto FROM PROYECTOS WHERE Nombre_Proyecto = "${nomProyecto}"');
    List<proyectos> listaProyectos =
        response.map((c) => proyectos.fromMap(c)).toList();
    if (listaProyectos.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<MagnaEco>> getMagnaECO() async {
    WidgetsFlutterBinding.ensureInitialized();
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery('SELECT * FROM MAGNAECO');
    List<MagnaEco> listaMagnaECO =
        response.map((c) => MagnaEco.fromMap(c)).toList();
    return listaMagnaECO;
  }

  Future<List<GeoRED>> getGeoRED() async {
    WidgetsFlutterBinding.ensureInitialized();
    Database db = await mbBasedeDatos();
    var response = await db.rawQuery('SELECT * FROM GEORED');
    List<GeoRED> listaGeoRED = response.map((c) => GeoRED.fromMap(c)).toList();
    return listaGeoRED;
  }
}
