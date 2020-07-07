import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/clases/funcionesGenericas.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/municipios.dart';

class DescripcionVertice extends StatefulWidget {
  DescripcionVertice({Key key}) : super(key: key);

  @override
  _DescripcionVerticeState createState() => _DescripcionVerticeState();
}

class _DescripcionVerticeState extends State<DescripcionVertice> {
  Map<String, int> departamentosMap = Map<String, int>();
  List<String> listadoDepartamentos = List<String>();
  List<String> listadoMunicipios = List<String>();
  String latitudPUnto = "0°0'0''";
  String longitudPunto = "0°0'0''";
  String alturaPuntos = '0';
  String nombrePuntoS, fechaS, veredaS, sitioS;
  String fechaMonumentacion,
      tipoMonumentacion,
      anchoMonumentacion,
      largoMonumentacion,
      sobresaleMonumentacion,
      estadoMonumento,
      monumentadoPor;
  String departamentoS, municipioS;
  bool datosBasicos = false;
  bool monumentacion = false;
  final controladorDepartamento = TextEditingController();
  final controladorMunicipio = TextEditingController();
  FuncionesGenericas funcionesGenericas = FuncionesGenericas();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _monumentacion = GlobalKey<FormState>();
  final GlobalKey<FormState> _formElip = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  @override
  void initState() {
    super.initState();
    listaDepartamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: datosBasicos
              ? Form(
                  key: _monumentacion,
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                          child: Container(
                              child: Center(
                                  child: Column(
                        children: <Widget>[
                          Icon(Icons.assignment,
                              size: 60, color: Colors.black54),
                          Divider(),
                          Text(
                              'Creación de formato de descripción de punto GNSS',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 12)),
                          Divider(),
                          Text('Datos de Monumentación',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54)),
                          Divider(),
                          DateTimeField(
                            decoration: InputDecoration(
                                labelText: 'Fecha de monumentación',
                                labelStyle: TextStyle(fontSize: 12),
                                icon: Icon(Icons.date_range,
                                    color: Colors.blueAccent)),
                            format: format,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100));
                            },
                            validator: (fechaMonumen) {
                              if (fechaMonumen == null) {
                                return 'La fecha ingresa no es valida';
                              } else {
                                setState(() {
                                  fechaMonumentacion = DateFormat('yyyy-MM-dd')
                                      .format(fechaMonumen);
                                });
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 12),
                              icon:
                                  Icon(Icons.all_out, color: Colors.blueAccent),
                              labelText: 'Tipo de Monumentación',
                            ),
                            validator: (String tipMonumentacion) {
                              if (tipMonumentacion.isEmpty) {
                                return 'El campo está vacio';
                              } else {
                                setState(() {
                                  veredaS = tipoMonumentacion;
                                });
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 12),
                              icon:
                                  Icon(Icons.all_out, color: Colors.blueAccent),
                              labelText: 'Ancho monumentación (m)',
                            ),
                            validator: (String anchMonumentacion) {
                              if (anchMonumentacion.isEmpty) {
                                return 'El campo está vacio';
                              } else {
                                setState(() {
                                  anchoMonumentacion = anchMonumentacion;
                                });
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 12),
                              icon:
                                  Icon(Icons.all_out, color: Colors.blueAccent),
                              labelText: 'Largo monumentación (m)',
                            ),
                            validator: (String larMonumentacion) {
                              if (larMonumentacion.isEmpty) {
                                return 'El campo está vacio';
                              } else {
                                setState(() {
                                  largoMonumentacion = larMonumentacion;
                                });
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 12),
                              icon:
                                  Icon(Icons.all_out, color: Colors.blueAccent),
                              labelText: 'Sobresale monumentación (m)',
                            ),
                            validator: (String sobMonumentacion) {
                              if (sobMonumentacion.isEmpty) {
                                return 'El campo está vacio';
                              } else {
                                setState(() {
                                  largoMonumentacion = sobMonumentacion;
                                });
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 12),
                              icon:
                                  Icon(Icons.all_out, color: Colors.blueAccent),
                              labelText: 'Estado del Punto',
                            ),
                            validator: (String estMonumento) {
                              if (estMonumento.isEmpty) {
                                return 'El campo está vacio';
                              } else {
                                setState(() {
                                  estadoMonumento = estMonumento;
                                });
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 12),
                              icon:
                                  Icon(Icons.all_out, color: Colors.blueAccent),
                              labelText: 'Monumentado por',
                            ),
                            validator: (String monumentadopr) {
                              if (monumentadopr.isEmpty) {
                                return 'El campo está vacio';
                              } else {
                                setState(() {
                                  monumentadoPor = monumentadopr;
                                });
                                return null;
                              }
                            },
                          ),
                        ],
                      ))))))
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.assignment,
                                  size: 60, color: Colors.black54),
                              Divider(),
                              Text(
                                  'Creación de formato de descripción de punto GNSS',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 12)),
                              Divider(),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  icon: Icon(Icons.description,
                                      color: Colors.blueAccent),
                                  labelText: 'Nombre del Punto',
                                ),
                                validator: (String nombrePunto) {
                                  if (nombrePunto.isEmpty) {
                                    return 'Nombre del punto no válido';
                                  } else {
                                    setState(() {
                                      nombrePuntoS = nombrePunto;
                                    });
                                    return null;
                                  }
                                },
                              ),
                              DateTimeField(
                                decoration: InputDecoration(
                                    labelText: 'Fecha',
                                    labelStyle: TextStyle(fontSize: 12),
                                    icon: Icon(Icons.date_range,
                                        color: Colors.blueAccent)),
                                format: format,
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100));
                                },
                                validator: (fecha) {
                                  if (fecha == null) {
                                    return 'La fecha ingresa no es valida';
                                  } else {
                                    setState(() {
                                      fechaS = DateFormat('yyyy-MM-dd')
                                          .format(fecha);
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              DropDownField(
                                controller: controladorDepartamento,
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.normal),
                                hintText: "Seleccione un Departamento",
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.normal),
                                enabled: true,
                                items: listadoDepartamentos,
                                icon: Icon(Icons.map, color: Colors.blueAccent),
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.normal),
                                onValueChanged: (departamentoSelect) async {
                                  controladorMunicipio.clear();
                                  int pkDep =
                                      departamentosMap[departamentoSelect];
                                  List<String> listaNombreMunicipios =
                                      List<String>();
                                  List<municipios> municipiosDB =
                                      await gestorMBDatabase.db
                                          .getMunicipios(pkDep);
                                  for (var i = 0;
                                      i < municipiosDB.length;
                                      i++) {
                                    listaNombreMunicipios
                                        .add(municipiosDB[i].NOMBRE);
                                  }
                                  setState(() {
                                    departamentoS = departamentoSelect;
                                    listadoMunicipios = listaNombreMunicipios;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                              DropDownField(
                                controller: controladorMunicipio,
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.normal),
                                hintText: "Seleccione un Municipio",
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.normal),
                                enabled: true,
                                strict: false,
                                items: listadoMunicipios,
                                icon: Icon(Icons.map, color: Colors.blueAccent),
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontStyle: FontStyle.normal),
                                onValueChanged: (municipioSelect) {
                                  setState(() {
                                    municipioS = municipioSelect;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  icon:
                                      Icon(Icons.map, color: Colors.blueAccent),
                                  labelText: 'Nombre de Vereda/Barrio',
                                ),
                                validator: (String nombreVereda) {
                                  if (nombreVereda.isEmpty) {
                                    return 'Nombre de la Vereda/Barrio no Valida';
                                  } else {
                                    setState(() {
                                      veredaS = nombreVereda;
                                    });
                                    return null;
                                  }
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  icon:
                                      Icon(Icons.map, color: Colors.blueAccent),
                                  labelText: 'Nombre del Sitio',
                                ),
                                validator: (String nombreSitio) {
                                  if (nombreSitio.isEmpty) {
                                    return 'Nombre del sitio no Valido';
                                  } else {
                                    setState(() {
                                      sitioS = nombreSitio;
                                    });
                                    return null;
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black87,
                                            blurRadius: 2)
                                      ]),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(children: [
                                          SizedBox(height: 5),
                                          Text(
                                              'Coordenadas Navegadas de Punto MAGNA SIRGAS',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueAccent)),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Text('Latitud',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .blueAccent)),
                                                  Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color:
                                                              Colors.black45),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            '${latitudPUnto}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                children: <Widget>[
                                                  Text('Longitud',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .blueAccent),
                                                      textAlign:
                                                          TextAlign.center),
                                                  Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color:
                                                              Colors.black45),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            '${longitudPunto}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                children: <Widget>[
                                                  Text('Altura',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .blueAccent),
                                                      textAlign:
                                                          TextAlign.center),
                                                  Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color:
                                                              Colors.black45),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            '${alturaPuntos}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.blueAccent),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                        onTap: () async {
                                                          Position
                                                              posicionUser =
                                                              await Geolocator()
                                                                  .getCurrentPosition();
                                                          setState(() {
                                                            latitudPUnto = funcionesGenericas
                                                                .decimal2Hexadecimal(
                                                                    posicionUser
                                                                        .latitude);
                                                            longitudPunto = funcionesGenericas
                                                                .decimal2Hexadecimal(
                                                                    posicionUser
                                                                        .longitude);
                                                            alturaPuntos = funcionesGenericas
                                                                .redondearDouble(
                                                                    posicionUser
                                                                        .altitude,
                                                                    3)
                                                                .toString();
                                                          });
                                                        },
                                                        child: Text(
                                                            'Obtener coordenadas',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center)),
                                                  )),
                                              SizedBox(width: 10),
                                              Container(
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.blueAccent),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          AlertDialog
                                                              ingresarCoordenadasManuales =
                                                              AlertDialog(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  content:
                                                                      Container(
                                                                    height: 310,
                                                                    width: 250,
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                            Icons
                                                                                .location_searching,
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            size: 40),
                                                                        Text(
                                                                            'Ingresar las coordenadas Manuales de tu Punto navegado',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                                                                        Form(
                                                                            key:
                                                                                _formElip,
                                                                            child:
                                                                                Column(
                                                                              children: <Widget>[
                                                                                TextFormField(
                                                                                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                                                  decoration: InputDecoration(
                                                                                    labelStyle: TextStyle(fontSize: 12),
                                                                                    icon: Icon(Icons.add_location, color: Colors.blueAccent),
                                                                                    labelText: 'Latitud Navegada del Punto',
                                                                                  ),
                                                                                  validator: (String latitudPuntoF) {
                                                                                    if (latitudPuntoF.isEmpty) {
                                                                                      return 'Ingresa un valor para la latitud del Punto';
                                                                                    } else {
                                                                                      setState(() {
                                                                                        latitudPUnto = latitudPuntoF;
                                                                                      });
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                ),
                                                                                TextFormField(
                                                                                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                                                  decoration: InputDecoration(
                                                                                    labelStyle: TextStyle(fontSize: 12),
                                                                                    icon: Icon(Icons.add_location, color: Colors.blueAccent),
                                                                                    labelText: 'Longitud Navegada del Punto',
                                                                                  ),
                                                                                  validator: (String longitudPuntoF) {
                                                                                    if (longitudPuntoF.isEmpty) {
                                                                                      return 'Ingresa un valor para la longitud del Punto';
                                                                                    } else {
                                                                                      setState(() {
                                                                                        longitudPunto = longitudPuntoF;
                                                                                      });
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                ),
                                                                                TextFormField(
                                                                                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                                                  decoration: InputDecoration(
                                                                                    labelStyle: TextStyle(fontSize: 12),
                                                                                    icon: Icon(Icons.add_location, color: Colors.blueAccent),
                                                                                    labelText: 'Altura Navegada del Punto',
                                                                                  ),
                                                                                  validator: (String alturaPuntoF) {
                                                                                    if (alturaPuntoF.isEmpty) {
                                                                                      return 'Ingresa un valor para la altura del Punto';
                                                                                    } else {
                                                                                      setState(() {
                                                                                        alturaPuntos = alturaPuntoF;
                                                                                      });
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                ),
                                                                                Center(
                                                                                  child: FlatButton(
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          SizedBox(height: 20),
                                                                                          Icon(Icons.navigate_next, size: 40, color: Colors.blueAccent),
                                                                                          Text('Continuar', style: TextStyle(fontSize: 12, color: Colors.blueAccent))
                                                                                        ],
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        if (_formElip.currentState.validate()) {
                                                                                          Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                                        } else {
                                                                                          // no llena formato
                                                                                        }
                                                                                      }),
                                                                                )
                                                                              ],
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ));
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  true,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ingresarCoordenadasManuales;
                                                              });
                                                        },
                                                        child: Text(
                                                            'Ingresar Coordenadas',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center)),
                                                  ))
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      child: Icon(Icons.navigate_next,
                                          size: 60, color: Colors.blueAccent),
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          if (departamentoS == null) {
                                            sinDepartamento();
                                          } else {
                                            if (municipioS == null) {
                                              sinMunicipio();
                                            } else {
                                              setState(() {
                                                datosBasicos = true;
                                              });
                                            }
                                          }
                                        } else {}
                                      },
                                    ),
                                    Text('Continuar',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
    );
  }

  listaDepartamentos() async {
    List<departamentos> listDep = await gestorMBDatabase.db.getDepartamentos();
    for (var i = 0; i < listDep.length - 1; i++) {
      departamentosMap[listDep[i].NOMBRE] = listDep[i].PK_DEPARTAMENTO;
      listadoDepartamentos.add(listDep[i].NOMBRE);
    }
  }

  void sinMunicipio() {
    Fluttertoast.showToast(
        msg: "Seleccione un Municpio",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void sinDepartamento() {
    Fluttertoast.showToast(
        msg: "Seleccione un Departamento",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }

  void sinFechaMonumentacion() {
    Fluttertoast.showToast(
        msg: "Ingrese una fecha para el campo monumentación",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }
}
