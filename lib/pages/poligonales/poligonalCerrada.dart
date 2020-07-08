import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/pages/poligonales/poligonalCerradaDatos.dart';
import 'package:measurebookapp/modelos/poligonal.dart';
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

  get sistemaCoordenadas => null;

  String get idCoordenadas => null;
  @override
  _PoligonalCerradaState createState() => _PoligonalCerradaState();
}

class _PoligonalCerradaState extends State<PoligonalCerrada> {
  @override
  String nombrePoligonal;
  Poligonal datospoligonal = Poligonal();
  String nombreEquipo;
  String referencia;
  int puntoarmadoSelccionado = -1;
  int puntoVisadoSeleccionado = -1;
  int precisionAngular;
  puntosReferencia puntoArmada = puntosReferencia();
  puntosReferencia puntoVisado = puntosReferencia();
  int indexPrecision = 0;
  int indexSeries = 0;
  List<Widget> listReferenciaPuntos = List<Widget>();
  //Obtener Puntos de referencia de la base de datos
  Future<List<puntosReferencia>> listaPuntosRef() async {
    List<puntosReferencia> listaRef = await gestorMBDatabase.db
        .getPuntosReferenciaData(widget.nombreProyecto);
    return listaRef;
  }

  Widget seleccionArmada(int indice) {
    if (indice == puntoarmadoSelccionado) {
      return Icon(Icons.check_circle, size: 25, color: Colors.blueAccent);
    } else {
      return Icon(Icons.check_circle, size: 25, color: Colors.black54);
    }
  }

  Widget seleccionVisado(int indice) {
    if (indice == puntoVisadoSeleccionado) {
      return Icon(Icons.check_circle, size: 25, color: Colors.blueAccent);
    } else {
      return Icon(Icons.check_circle, size: 25, color: Colors.black54);
    }
  }

  List<Widget> numeroSeries = [
    Center(
        child: Text('0',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('1',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('2',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('3',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('4',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('5',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('6',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('7',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
    Center(
        child: Text('8',
            style: TextStyle(fontSize: 12, color: Colors.blueAccent),
            textAlign: TextAlign.center)),
  ];
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
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.blueAccent,
        child: Icon(Icons.menu, color: Colors.white),
        mini: true,
        onPressed: () {
          print('Boton Navegación');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: this._barraNavegacionMB(context),
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
                      validator: (String nReferencia) {
                        if (nReferencia.isEmpty) {
                          return 'Ingrese la nomenclatura de la Poligonal';
                        } else {
                          setState(() {
                            referencia = nReferencia;
                          });
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: [
                            Text('Precisión Angular del Equipo',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                            SizedBox(height: 5),
                            Container(
                                height: 50,
                                width:
                                    ((MediaQuery.of(context).size.width) / 2 -
                                        30),
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
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text('Número de Series',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                            Container(
                                height: 50,
                                width:
                                    ((MediaQuery.of(context).size.width) / 2 -
                                        30),
                                child: CupertinoPicker(
                                  itemExtent: 20,
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      indexSeries = index;
                                    });
                                  },
                                  children: numeroSeries,
                                  squeeze: 1.0,
                                  looping: true,
                                ))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Seleccione el punto de Referencia (Punto Armado)',
                        style:
                            TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(blurRadius: 5.0, color: Colors.black26)
                          ]),
                      height: 120,
                      child: FutureBuilder(
                        future: listaPuntosRef(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<Widget> puntosRef = List<Widget>();
                            if (snapshot.data.length > 0) {
                              for (var i = 0; i < snapshot.data.length; i++) {
                                puntosReferencia listaPuntos = snapshot.data[i];
                                puntosRef.add(ListTile(
                                  trailing: seleccionArmada(i),
                                  dense: true,
                                  title: Text('${listaPuntos.Nombre_Punto}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                  subtitle: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Norte: ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0,
                                          color: Color(0xff007FFF),
                                        )),
                                    TextSpan(
                                        text: '${listaPuntos.Norte}m  ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        )),
                                    TextSpan(
                                        text: 'Este: ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0,
                                          color: Color(0xff007FFF),
                                        )),
                                    TextSpan(
                                        text: '${listaPuntos.Este}m  ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        )),
                                    TextSpan(
                                        text: 'Altura: ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0,
                                          color: Color(0xff007FFF),
                                        )),
                                    TextSpan(
                                        text: '${listaPuntos.Altura}m',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        )),
                                  ])),
                                  leading: Icon(
                                    Icons.add_location,
                                    size: 30,
                                    color: Colors.blueAccent,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      puntoarmadoSelccionado = i;
                                      puntoArmada.Nombre_Punto =
                                          listaPuntos.Nombre_Punto;
                                      puntoArmada.Norte = listaPuntos.Norte;
                                      puntoArmada.Este = listaPuntos.Este;
                                      puntoArmada.Altura = listaPuntos.Altura;
                                      puntoArmada.ID_Punto =
                                          listaPuntos.ID_Punto;
                                    });
                                  },
                                ));
                              }
                              return Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: puntosRef,
                                  ),
                                ),
                              );
                            } else {
                              puntosRef.add(ListTile(
                                leading: Icon(
                                  Icons.error_outline,
                                  color: Colors.black54,
                                  size: 30,
                                ),
                                trailing: Icon(Icons.navigate_next,
                                    color: Colors.blueAccent, size: 40),
                                title: Text(
                                  'No tienes Puntos de Referencia dentro del Proyecto',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blueAccent),
                                ),
                                subtitle: Text(
                                    'Ingrese al Gestor y agrega puntos de referencia al proyecto',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GestosPuntos(
                                                idProyeccion:
                                                    widget.idProyeccion,
                                                idUser: widget.idUser,
                                                nombreProyecto:
                                                    widget.nombreProyecto,
                                                proyeccionMB:
                                                    widget.proyeccionMB,
                                              )));
                                },
                              ));
                              return SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: puntosRef,
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Container(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Seleccione el punto de Referencia (Punto Visado)',
                        style:
                            TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    SizedBox(height: 10),
                    Divider(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(blurRadius: 5.0, color: Colors.black26)
                          ]),
                      height: 120,
                      child: FutureBuilder(
                        future: listaPuntosRef(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<Widget> puntosRef = List<Widget>();
                            if (snapshot.data.length > 0) {
                              for (var i = 0; i < snapshot.data.length; i++) {
                                puntosReferencia listaPuntos = snapshot.data[i];
                                puntosRef.add(ListTile(
                                  dense: true,
                                  trailing: Container(
                                    child: seleccionVisado(i),
                                  ),
                                  leading: Icon(Icons.add_location,
                                      color: Colors.blueAccent, size: 30),
                                  title: Text(
                                    '${listaPuntos.Nombre_Punto}',
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 12),
                                  ),
                                  subtitle: Text(
                                      'Norte: ${listaPuntos.Norte}  Este: ${listaPuntos.Este}  Altura: ${listaPuntos.Altura}'),
                                  onTap: () {
                                    setState(() {
                                      puntoVisadoSeleccionado = i;
                                      puntoVisado.Nombre_Punto =
                                          listaPuntos.Nombre_Punto;
                                      puntoVisado.Norte = listaPuntos.Norte;
                                      puntoVisado.Este = listaPuntos.Este;
                                      puntoVisado.Altura = listaPuntos.Altura;
                                      puntoVisado.ID_Punto =
                                          listaPuntos.ID_Punto;
                                    });
                                  },
                                ));
                              }
                              return Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: puntosRef,
                                  ),
                                ),
                              );
                            } else {
                              puntosRef.add(ListTile(
                                leading: Icon(
                                  Icons.error_outline,
                                  color: Colors.black54,
                                  size: 30,
                                ),
                                trailing: Icon(Icons.navigate_next,
                                    color: Colors.blueAccent, size: 40),
                                title: Text(
                                  'No tienes Puntos de Referencia dentro del Proyecto',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blueAccent),
                                ),
                                subtitle: Text(
                                    'Ingrese al Gestor y agrega puntos de referencia al proyecto',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GestosPuntos(
                                                idProyeccion:
                                                    widget.idProyeccion,
                                                idUser: widget.idUser,
                                                nombreProyecto:
                                                    widget.nombreProyecto,
                                                proyeccionMB:
                                                    widget.proyeccionMB,
                                              )));
                                },
                              ));
                              return Container(
                                child: Column(
                                  children: puntosRef,
                                ),
                              );
                            }
                          } else {
                            return Container(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    FlatButton(
                        onPressed: () async {
                          if (puntoArmada.Nombre_Punto ==
                              puntoVisado.Nombre_Punto) {
                            mostarAlertaPuntoReferencia();
                          } else {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                datospoligonal.nomPArmadoIni =
                                    puntoArmada.ID_Punto;
                                datospoligonal.nomPVIsadoIni =
                                    puntoVisado.ID_Punto;
                                datospoligonal.nomPArmadofin =
                                    puntoArmada.ID_Punto;
                                datospoligonal.nomPVIsadofin =
                                    puntoVisado.ID_Punto;
                                datospoligonal.nombrePoligonal =
                                    nombrePoligonal;
                                datospoligonal.serieEquipo = referencia;
                                datospoligonal.precisionEquipo =
                                    precisionAngularEquipo(indexPrecision);
                                datospoligonal.numeroSeries = indexSeries;
                                datospoligonal.tipoPoligonal = 'Cerrada';
                              });
                              bool validarNombre = await gestorMBDatabase.db
                                  .validarNombrePoligonal(
                                      datospoligonal.nombrePoligonal);

                              if (validarNombre == true) {
                                mostrarAlertaNombrePoligonal();
                              } else {
                                gestorMBDatabase.db.guardarPoligonal(
                                    datospoligonal,
                                    widget.idUser,
                                    widget.nombreProyecto);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PoligonalCerradaDatos()));
                              }
                            }
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.check_circle_outline,
                                color: Colors.blueAccent, size: 40),
                            Divider(height: 2),
                            Text('Continuar',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blueAccent)),
                          ],
                        ))
                  ],
                )),
          )),
        ),
      ),
    );
  }

  int precisionAngularEquipo(int indice) {
    int precisionEstacion = 10;
    if (indice == 0) {
      precisionEstacion = 1;
    } else if (indice == 1) {
      precisionEstacion = 2;
    } else if (indexPrecision == 2) {
      precisionEstacion = 3;
    } else if (indice == 3) {
      precisionEstacion = 5;
    } else if (indice == 4) {
      precisionEstacion = 7;
    }
    return precisionEstacion;
  }

  void mostarAlertaPuntoReferencia() {
    Fluttertoast.showToast(
        msg: "El punto de armado no puede ser igual al Visado",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  BottomAppBar _barraNavegacionMB(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.black87,
      child: Row(
        children: <Widget>[
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('      Creación poligonal cerrada',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
// Validar Nombre Poligonal

  void mostrarAlertaNombrePoligonal() {
    Fluttertoast.showToast(
        msg: "La Poligonal ya existe",
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
}
