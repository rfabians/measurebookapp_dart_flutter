import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class CoversionArchivo extends StatefulWidget {
  CoversionArchivo({Key key}) : super(key: key);

  @override
  _CoversionArchivoState createState() => _CoversionArchivoState();
}

class _CoversionArchivoState extends State<CoversionArchivo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: FlatButton(
             onPressed: ()async{
               String pathCsv = await FilePicker.getFilePath(type: FileType.custom, allowedExtensions: ['csv']); 
               final datosCSV = await rootBundle.loadString(pathCsv);
               print(datosCSV);
               List<List<dynamic>> rowsAsListOfValues = CsvToListConverter().convert(datosCSV);
               print(rowsAsListOfValues);
             }, 
             child: Text('Prueba')
             ),
         )
         ),
    );
  }
}