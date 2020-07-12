import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurebookapp/modelos/poligonal.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/modelos/puntosReferencia.dart';

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
  String anguloHorizontalAtras01 = '0.0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Icon(
                    Icons.timeline,
                    size: 70,
                    color: Colors.black54,
                  ),
                  Divider(),
                  generarInterfazLecturasPoligonal(
                      widget.datosPoligonal.numeroSeries)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget generarInterfazLecturasPoligonal(int series) {
    if (series == 0) {
      return Container(
        child: Form(
            child: SingleChildScrollView(
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
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
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Punto de Orientación',
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 12),
                                  ),
                                  Divider(),
                                  Text(
                                    '${widget.puntoVisado}',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 10),
                        Text('Angulo Observador punto de Orientación',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 12)),
                        Row(
                          children: <Widget>[
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
                              child: TextFormField(
                                initialValue: '0.0000',
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                style: TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    labelText: 'Ángulo Horizontal'),
                                validator: (String angulohorizontal) {
                                  if (angulohorizontal.isEmpty) {
                                    return 'Ingrese un valor para el angulo Horizontal';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (anguloHorizontal) {
                                  setState(() {
                                    anguloHorizontalAtras01 =
                                        anguloHorizontalConvert(
                                            anguloHorizontal);
                                  });
                                },
                              ),
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 20,
                              child: Center(
                                  child: Text('${anguloHorizontalAtras01}',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12))),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        )),
      );
    }
  }

  String anguloHorizontalConvert(String anguloHori) {
    double anguloHorizontal = double.parse(anguloHori);
    int grados, minutos, segundos;
    if (anguloHorizontal == null) {
      mostrarAlertaAnguloHorizontal();
    } else {
      if (anguloHorizontal >= 360) {
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

  void mostrarAlertaAnguloHorizontal() {
    Fluttertoast.showToast(
        msg:
            "Angulo ingresado en Formato no valido, ingrese el angulo en Formato GG.MM.SS",
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
}
