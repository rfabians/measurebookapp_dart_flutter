import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurebookapp/modelos/lecturaPoligonal.dart';
import 'package:measurebookapp/modelos/poligonal.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';
import 'package:measurebookapp/pages/poligonales/detallePoligonalCerrada.dart';

class AgregarLecturaPoligonal extends StatefulWidget {
  final proyectos datosProyecto;
  final Poligonal datosPoligonal;
  final String puntoArmado;
  final String puntoVisado;
  final String puntoArmadoFin;
  final String puntoVisadoFIn;
  AgregarLecturaPoligonal(
      {Key key,
      this.datosPoligonal,
      this.datosProyecto,
      this.puntoArmado,
      this.puntoArmadoFin,
      this.puntoVisadoFIn,
      this.puntoVisado})
      : super(key: key);

  @override
  _AgregarLecturaPoligonalState createState() =>
      _AgregarLecturaPoligonalState();
}

class _AgregarLecturaPoligonalState extends State<AgregarLecturaPoligonal> {
  //Variables sin series
  bool distanciaHorizontal00B = false;
  bool distanciaHorizontal00A = false;
  LecturaPoligonal lecturaDatos0 = LecturaPoligonal(
    anguloHorizontalAtras: 0.0000,
    anguloHorizontalAdelante: 0.0000,
    anguloVerticalAdelante: 90.0000,
    anguloVerticalAtras: 90.00000,
    alturaInstrumental: 0.000,
    alturaObjetoAdelante: 0.000,
    alturaObjetoAtras: 0.000,
    distanciaAdelante: 0.000,
    distanciaAtras: 0.000,
    factorEscala: 1.00000,
    nombreVisado: 'D1',
    desviacionAngulo: 0.000,
    desviacionDistanciaAdelante: 0.000,
    desviacionDistanciaAtras: 0.000,
  );
  @override
  void initState() {
    lecturaDatos0.nombrePuntoArmado = widget.puntoArmado;
    lecturaDatos0.nombreBacksite = widget.puntoVisado;
    lecturaDatos0.idUser = widget.datosProyecto.ID_USUARIO;
    lecturaDatos0.nombrePoligonal = widget.datosPoligonal.nombrePoligonal;
    lecturaDatos0.nombrePoligonal = widget.datosProyecto.Nombre_Proyecto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.datosPoligonal.numeroSeries == 0) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.timeline,
                      size: 70,
                      color: Colors.black54,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Punto Armado',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 12),
                              ),
                              Divider(),
                              Text(
                                '${widget.puntoArmado}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              TextFormField(
                                initialValue: '0.000',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Altura Instrumental (m)',
                                ),
                                onChanged: (alturaInstrumental) {
                                  if (double.parse(alturaInstrumental) >= 0) {
                                    setState(() {
                                      lecturaDatos0.alturaInstrumental =
                                          double.parse(alturaInstrumental);
                                    });
                                  } else {
                                    alertaAltura();
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                  } else {}
                                },
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Backsite',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 12),
                              ),
                              Divider(),
                              Text(
                                '${widget.puntoVisado}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              TextFormField(
                                initialValue: '0.000',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Altura Objeto (m)',
                                ),
                                onChanged: (alturaObjeto) {
                                  if (double.parse(alturaObjeto) >= 0) {
                                    setState(() {
                                      lecturaDatos0.alturaObjetoAtras =
                                          double.parse(alturaObjeto);
                                    });
                                  } else {
                                    alertaAltura();
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                  } else {}
                                },
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      endIndent: 4,
                      color: Colors.black,
                    ),
                    Text('Punto Visado',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 12)),
                    Row(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          child: Column(
                            children: <Widget>[
                              Divider(),
                              TextFormField(
                                initialValue: 'D1',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Nombre de Punto',
                                ),
                                onChanged: (nombrePunto) {
                                  setState(() {
                                    lecturaDatos0.nombreVisado = nombrePunto;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          child: Column(
                            children: <Widget>[
                              Divider(),
                              TextFormField(
                                initialValue: '0.000',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  labelText: 'Altura de Objeto',
                                ),
                                onChanged: (alturaObjeto) {
                                  if (double.parse(alturaObjeto) >= 0) {
                                    setState(() {
                                      lecturaDatos0.alturaObjetoAdelante =
                                          double.parse(alturaObjeto);
                                    });
                                  } else {
                                    alertaAltura();
                                  }
                                },
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //Lectura de Datos Backsite
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 20,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Datos Lectura Backsite',
                            style: TextStyle(
                                fontSize: 12, color: Colors.blueAccent),
                          ),
                          Form(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        20,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          initialValue: '0.000',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54),
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(fontSize: 12),
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            ),
                                            labelText:
                                                'Angulo Horizontal (GR.MMSS)',
                                          ),
                                          onChanged: (anguloHoriozntal) {
                                            if (double.parse(
                                                        anguloHoriozntal) >=
                                                    0 &&
                                                double.parse(anguloHoriozntal) <
                                                    360) {
                                              setState(() {
                                                lecturaDatos0
                                                        .anguloHorizontalAtras =
                                                    double.parse(
                                                        anguloHoriozntal);
                                              });
                                            } else {
                                              mostrarAlertaAnguloHorizontal();
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  signed: true, decimal: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          20,
                                  child: Center(
                                    child: Text(
                                      '${anguloHorizontalConvert(lecturaDatos0.anguloHorizontalAtras.toString())}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          CupertinoSwitch(
                              activeColor: Colors.blueAccent,
                              value: distanciaHorizontal00B,
                              onChanged: (value) {
                                setState(() {
                                  distanciaHorizontal00B = value;
                                });
                              }),
                          SizedBox(height: 5),
                          Text('Distancia Horizontal',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 12)),
                          Container(
                              child: Container(
                            child: Form(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              20,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: '0.000',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54),
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                      TextStyle(fontSize: 12),
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                  labelText:
                                                      '${tipoDistancia(distanciaHorizontal00B)}',
                                                ),
                                                onChanged:
                                                    (distanciaHorizontal) {
                                                  if (double.parse(
                                                          distanciaHorizontal) >
                                                      0) {
                                                    setState(() {
                                                      lecturaDatos0
                                                              .distanciaAtras =
                                                          double.parse(
                                                              distanciaHorizontal);
                                                    });
                                                  }
                                                  {
                                                    alertaDistancia();
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                  } else {}
                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        signed: true,
                                                        decimal: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                20,
                                        child: Center(
                                          child: Text(
                                            '${lecturaDatos0.distanciaAtras}m',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              20,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: '90.0000',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54),
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                      TextStyle(fontSize: 12),
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                  labelText:
                                                      'Angulo Zenital (GR.MMSS)',
                                                ),
                                                onChanged: (anguloVerti) {
                                                  if (double.parse(
                                                              anguloVerti) >=
                                                          0 &&
                                                      double.parse(
                                                              anguloVerti) <=
                                                          180) {
                                                    setState(() {
                                                      lecturaDatos0
                                                              .anguloVerticalAtras =
                                                          double.parse(
                                                              anguloVerti);
                                                    });
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                  } else {}
                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        signed: true,
                                                        decimal: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                20,
                                        child: Center(
                                          child: Text(
                                            '${anguloVerticalConvert(lecturaDatos0.anguloVerticalAtras.toString())}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    //Lectura de Datos Punto Adelante
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 20,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Datos Lectura Punto Observado',
                            style: TextStyle(
                                fontSize: 12, color: Colors.blueAccent),
                          ),
                          Form(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        20,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          initialValue: '0.000',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54),
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(fontSize: 12),
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            ),
                                            labelText:
                                                'Angulo Horizontal (GR.MMSS)',
                                          ),
                                          onChanged: (anguloHoriozntal) {
                                            if (double.parse(
                                                        anguloHoriozntal) >=
                                                    0 &&
                                                double.parse(anguloHoriozntal) <
                                                    360) {
                                              setState(() {
                                                lecturaDatos0
                                                        .anguloHorizontalAdelante =
                                                    double.parse(
                                                        anguloHoriozntal);
                                              });
                                            } else {
                                              mostrarAlertaAnguloHorizontal();
                                            }
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  signed: true, decimal: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          20,
                                  child: Center(
                                    child: Text(
                                      '${anguloHorizontalConvert(lecturaDatos0.anguloHorizontalAdelante.toString())}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueAccent),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          CupertinoSwitch(
                              activeColor: Colors.blueAccent,
                              value: distanciaHorizontal00A,
                              onChanged: (value) {
                                setState(() {
                                  distanciaHorizontal00A = value;
                                });
                              }),
                          SizedBox(height: 5),
                          Text('Distancia Horizontal',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 12)),
                          Container(
                              child: Container(
                            child: Form(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              20,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: '0.000',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54),
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                      TextStyle(fontSize: 12),
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                  labelText:
                                                      '${tipoDistancia(distanciaHorizontal00A)}',
                                                ),
                                                onChanged:
                                                    (distanciaHorizontal) {
                                                  if (double.parse(
                                                          distanciaHorizontal) >
                                                      0) {
                                                    setState(() {
                                                      lecturaDatos0
                                                              .distanciaAdelante =
                                                          double.parse(
                                                              distanciaHorizontal);
                                                    });
                                                  }
                                                  {
                                                    alertaDistancia();
                                                  }
                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        signed: true,
                                                        decimal: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                20,
                                        child: Center(
                                          child: Text(
                                            '${lecturaDatos0.distanciaAdelante}m',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              20,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: '90.0000',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54),
                                                decoration: InputDecoration(
                                                  labelStyle:
                                                      TextStyle(fontSize: 12),
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                  labelText:
                                                      'Angulo Zenital (GR.MMSS)',
                                                ),
                                                onChanged: (anguloVerti) {
                                                  if (double.parse(
                                                              anguloVerti) >=
                                                          0 &&
                                                      double.parse(
                                                              anguloVerti) <=
                                                          180) {
                                                    setState(() {
                                                      lecturaDatos0
                                                              .anguloVerticalAdelante =
                                                          double.parse(
                                                              anguloVerti);
                                                    });
                                                  }
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                  } else {}
                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        signed: true,
                                                        decimal: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                20,
                                        child: Center(
                                          child: Text(
                                            '${anguloVerticalConvert(lecturaDatos0.anguloVerticalAdelante.toString())}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Center(
                            child: Text(
                              'Registrar Lectura',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        color: Color(0xff007FFF),
                        onPressed: () {
                          almacenarLectura0(context, lecturaDatos0);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  AlertDialog verificarDatos(LecturaPoligonal datosLectura) {}
  String tipoDistancia(bool tipodistanciaAtras) {
    String tipodistancia;
    if (tipodistanciaAtras) {
      tipodistancia = 'Distancia Horizontal';
      return tipodistancia;
    } else {
      tipodistancia = 'Distancia Inclinada';
      return tipodistancia;
    }
  }

  String anguloHorizontalConvert(String anguloHori) {
    double anguloHorizontal = double.parse(anguloHori);
    int grados, minutos, segundos;
    if (anguloHorizontal == null) {
      mostrarAlertaAnguloHorizontal();
    } else {
      if (anguloHorizontal >= 360 || anguloHorizontal < 0) {
        String angHorHexa = "359° 59' 59''";
        return angHorHexa;
      } else {
        grados = anguloHorizontal.toInt();
        minutos = ((anguloHorizontal - grados) * 100).toInt();
        segundos =
            ((anguloHorizontal - grados - (minutos / 100)) * 10000).round();
        print(((anguloHorizontal - grados - (minutos / 100)) * 10000));
        if (minutos > 59.1) {
          mostrarAlertaAnguloHorizontal();
        } else if (segundos > 59.1) {
          mostrarAlertaAnguloHorizontal();
        } else {
          String angHorHexa = "${grados}° ${minutos}' ${segundos}''";
          return angHorHexa;
        }
      }
    }
  }

  String anguloVerticalConvert(String anguloVerti) {
    double anguloVertical = double.parse(anguloVerti);
    int grados, minutos, segundos;
    if (anguloVertical == null) {
      mostrarAlertaAnguloHorizontal();
    } else {
      if (anguloVertical >= 180 || anguloVertical < 0) {
        String angHorHexa = "179 59' 59''";
        return angHorHexa;
      } else {
        grados = anguloVertical.toInt();
        minutos = ((anguloVertical - grados) * 100).toInt();
        segundos =
            ((anguloVertical - grados - (minutos / 100)) * 10000).round();
        print(((anguloVertical - grados - (minutos / 100)) * 10000));
        if (minutos > 59.1) {
          mostrarAlertaAnguloHorizontal();
        } else if (segundos > 59.1) {
          mostrarAlertaAnguloHorizontal();
        } else {
          String angHorHexa = "${grados}° ${minutos}' ${segundos}''";
          return angHorHexa;
        }
      }
    }
  }

  double convertirFormatoAngulo(double anguGGMMSS) {
    int grados = anguGGMMSS.toInt();
    int minutos = ((anguGGMMSS - grados) * 100).toInt();
    int segundos = ((anguGGMMSS - grados - (minutos / 100)) * 10000).round();
    double anguloDecimal = grados + (minutos / 90) + (segundos / 3600);
    return anguloDecimal;
  }

  void mostrarAlertaAnguloHorizontal() {
    Fluttertoast.showToast(
        msg:
            "Angulo ingresado en Formato no valido, ingrese el angulo en Formato GG.MM.SS",
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  void alertaDistancia() {
    Fluttertoast.showToast(
        msg: "La distancia Ingresada se encuentra en un formato no válido",
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  void alertaAltura() {
    Fluttertoast.showToast(
        msg: "La altura Ingresada no es válida",
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  void almacenarLectura0(
      BuildContext context, LecturaPoligonal lecturaPoligonal) {
    showDialog(
        context: context,
        builder: (context) => Container(
              child: Material(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.timeline,
                          size: 70,
                          color: Colors.black54,
                        ),
                        Text('Punto Armado',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54)),
                        Text('${lecturaPoligonal.nombrePuntoArmado}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.blueAccent)),
                        Divider(),
                        Text('Altura Instrumental (m)',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54)),
                        Text('${lecturaPoligonal.alturaInstrumental}m',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 12)),
                        Divider(
                          height: 10,
                          indent: 2,
                          thickness: 2.0,
                          color: Colors.blueAccent,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
                              child: Column(
                                children: <Widget>[
                                  Text('BackSite',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text('${lecturaPoligonal.nombreBacksite}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                  Divider(),
                                  Text('Angulo Horizontal',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text(
                                      '${anguloHorizontalConvert(lecturaPoligonal.anguloHorizontalAtras.toString())}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                  Divider(),
                                  Text('Angulo Vertical',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text(
                                      '${anguloVerticalConvert(lecturaPoligonal.anguloVerticalAtras.toString())}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                  Divider(),
                                  Container(
                                      child: distanciaHorizontal00B
                                          ? Column(
                                              children: <Widget>[
                                                Text('Distancia Horizontal (m)',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54)),
                                                Text(
                                                    '${lecturaPoligonal.distanciaAtras}m',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize: 12)),
                                              ],
                                            )
                                          : Column(
                                              children: <Widget>[
                                                Text('Distancia Inclinada(m)',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54)),
                                                Text(
                                                    '${lecturaPoligonal.distanciaAtras}m',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize: 12)),
                                              ],
                                            )),
                                  Divider(),
                                  Text('Altura Objeto',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text('${lecturaPoligonal.alturaObjetoAtras}m',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
                              child: Column(
                                children: <Widget>[
                                  Text('Visado',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text('${lecturaPoligonal.nombreVisado}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                  Divider(),
                                  Text('Angulo Horizontal',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text(
                                      '${anguloHorizontalConvert(lecturaPoligonal.anguloHorizontalAdelante.toString())}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                  Divider(),
                                  Text('Angulo Vertical',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text(
                                      '${anguloVerticalConvert(lecturaPoligonal.anguloVerticalAdelante.toString())}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                  Divider(),
                                  Container(
                                      child: distanciaHorizontal00A
                                          ? Column(
                                              children: <Widget>[
                                                Text('Distancia Horizontal (m)',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54)),
                                                Text(
                                                    '${lecturaPoligonal.distanciaAdelante}m',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize: 12)),
                                              ],
                                            )
                                          : Column(
                                              children: <Widget>[
                                                Text('Distancia Inclinada(m)',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54)),
                                                Text(
                                                    '${lecturaPoligonal.distanciaAdelante}m',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize: 12)),
                                              ],
                                            )),
                                  Divider(),
                                  Text('Altura Objeto',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                  Text(
                                      '${lecturaPoligonal.alturaObjetoAdelante}m',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Center(
                                child: Text(
                                  'Guardar',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            color: Color(0xff007FFF),
                            onPressed: () {
                              gestorMBDatabase.db.guardarLecturaPoligonal(
                                lecturaPoligonal,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetallePoligonalCerrada(
                                            datosPoligonal:
                                                widget.datosPoligonal,
                                            datosProyecto: widget.datosProyecto,
                                          )));
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
