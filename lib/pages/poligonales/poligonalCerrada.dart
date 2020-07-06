import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:measurebookapp/pages/gestorPuntos.dart';

class PoligonalCerrada extends StatefulWidget {
  final String nombreProyecto, proyeccionMB, idUser, idProyeccion;
  PoligonalCerrada(
      {Key key,
      this.nombreProyecto,
      this.proyeccionMB,
      this.idUser,
      this.idProyeccion})
      : super(key: key);
  @override
  _PoligonalCerradaState createState() => _PoligonalCerradaState();
}

class _PoligonalCerradaState extends State<PoligonalCerrada> {
  @override
  List<Widget> puntosREFWidget = List<Widget>();
  void initState() {
    super.initState();
  }

  String nombrePoligonal;
  String nombreEquipo;
  String serie, referencia;
  int precisionAngular;
  int indexPrecision = 0;
  List<Widget> listReferenciaPuntos = List<Widget>();

  List<Widget> precisionesEstacion = [
    Center(
        child: Text('1 Segundo',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('2 Segundos',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('3 Segundos',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('5 Segundos',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('7 Segundos',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('10 Segundos',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/poligonal_.png', height: 70),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Creación de ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Color(0xff007FFF),
                          )),
                      TextSpan(
                          text: 'Poligonal Cerrada',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: Colors.black54,
                          )),
                    ])),
                    Divider(
                      height: 3,
                    ),
                    Divider(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.assignment),
                          labelText: 'Nomenclatura Poligonal'),
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                      validator: (String nPoligonal) {
                        if (nPoligonal.isEmpty) {
                          return 'Ingrese la nomenclatura de la Poligonal';
                        } else {
                          setState(() {
                            nombrePoligonal = nPoligonal;
                          });
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.assignment),
                          labelText: 'Serie y Referencia del Equipo Optico'),
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                      validator: (String nPoligonal) {
                        if (nPoligonal.isEmpty) {
                          return 'Ingrese la nomenclatura de la Poligonal';
                        } else {
                          setState(() {
                            nombrePoligonal = nPoligonal;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Seleccione la precisión angular del Equipo',
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        child: CupertinoPicker(
                          itemExtent: 20,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              indexPrecision = index;
                            });
                          },
                          children: precisionesEstacion,
                          squeeze: 1.0,
                          looping: true,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Seleccione el punto de Referencia (Punto Armado)',
                        style:
                            TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    Container(
                        height: 90,
                        child: SingleChildScrollView(
                          child: FutureBuilder(
                              future: gestorMBDatabase.db
                                  .getPuntosReferenciaData(
                                      widget.nombreProyecto),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<puntosReferencia>>
                                      snapshot) {
                                MediaQueryData mediaQueryData =
                                    MediaQuery.of(context);
                                if (snapshot.hasData) {
                                  if (snapshot.data.length <= 0) {
                                    return Container(
                                        child: ListTile(
                                      dense: true,
                                      trailing: Icon(Icons.add_location),
                                      title: Text('Sin Puntos de Referencia',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12)),
                                      subtitle: Text(
                                          'Crear punto de Referencia',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 12)),
                                      leading: Icon(Icons.error),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GestosPuntos(
                                                      idUser: widget.idUser,
                                                      idProyeccion:
                                                          widget.idProyeccion,
                                                      nombreProyecto:
                                                          widget.nombreProyecto,
                                                      proyeccionMB:
                                                          widget.proyeccionMB,
                                                    )));
                                      },
                                    ));
                                  } else {
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                } else {
                                  return Container(
                                      child: Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              }),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Seleccione el punto de Referencia (Punto Visado)',
                        style:
                            TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    Container(
                        height: 90,
                        child: SingleChildScrollView(
                          child: Column(
                            children: puntosREFWidget,
                          ),
                        )),
                    Divider(
                      height: 5,
                    )
                  ],
                )),
          )),
        ),
      ),
    );
  }
}
