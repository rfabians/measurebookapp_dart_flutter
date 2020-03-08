import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:measurebookapp/modelos/prueba.dart';
import 'dart:developer';
import 'package:measurebookapp/modelos/prueba.dart';



class gestorMBDatabase {
  gestorMBDatabase._();

  static final gestorMBDatabase db = gestorMBDatabase._();


  mbBasedeDatos() async {
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
      ByteData data = await rootBundle.load(
          join("assets/database/", "mbdatabase.db"));
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

  Future<List<consultaMunicipios>> getMunicipios() async {
    Database db = await mbBasedeDatos();
    var respuesta = await db.rawQuery("SELECT PK_MUNICIPIOS, NOMBRE FROM MUNICIPIOS");
    print(respuesta);
    List<consultaMunicipios> listaMunicipios = respuesta.map((c)=> consultaMunicipios.fromMap(c)).toList();
    return listaMunicipios;
  }

}
