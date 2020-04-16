import 'dart:convert';
import 'dart:io' as Io;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';

class ListadoPuntoRef extends StatefulWidget {
  final String idUsuario, nombreProyecto, idProyeccion, proyeccion;
  ListadoPuntoRef({Key key, this.idProyeccion, this.idUsuario, this.nombreProyecto, this.proyeccion}) : super(key: key);

  @override
  _ListadoPuntoRefState createState() => _ListadoPuntoRefState();
}

class _ListadoPuntoRefState extends State<ListadoPuntoRef> {
  @override
  Widget build(BuildContext context) {
    if (widget.proyeccion == 'Gauss-Krüger') {
      //Planas Gauss
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: gestorMBDatabase.db.getPuntosReferenciaData(widget.nombreProyecto),
                builder: (BuildContext context, AsyncSnapshot<List<puntosReferencia>> snapshot) {
                    if(snapshot.hasData) {
                      if(snapshot.data.length<=0) {
                        return Container(
                          child:  Center(
                              child: Text('Aún no tienes puntos de referencia dentro del proyecto'),
                            ),
                        );
                      }else {
                        return Container(
                          height: 300,
                            child: Center(
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index){
                                  puntosReferencia listPuntsRef = snapshot.data[index];
                                  Image fotoP = Image.memory(base64Decode(listPuntsRef.Foto_Placa));
                                  return fotoP;
                                  /*return ListTile(
                                    title: Text('${listPuntsRef.Nombre_Punto}'),
                                    leading: SizedBox(
                                      height: 150,
                                      width: 130,
                                      child: Image.memory(base64Decode(listPuntsRef.Foto_Placa)),
                                    )
                                  );*/
                                },
                                )
                            ),
                        );
                      }
                    }else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                }
              ),
            ),
          )
        ),
      );
    }else {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Plano Cartesiano'),
          ),
        ),
      );
    }
  }
}