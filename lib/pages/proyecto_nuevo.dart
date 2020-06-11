import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/municipios.dart';
import 'package:measurebookapp/pages/menuPrincipal.dart';
import 'package:measurebookapp/pages/seleccionSistemaCoordenadas.dart';

class NuevoProyecto extends StatefulWidget {
  String idUsuario;
  NuevoProyecto({Key key, this.idUsuario}) : super(key: key);

  @override
  _NuevoProyectoState createState() => _NuevoProyectoState();
}


class _NuevoProyectoState extends State<NuevoProyecto> {

  // Definición de Variables a Usar
  String nombreProyectoMB,ubicacionMB, clienteMB, empresaMB, proyeccionMB, decripcionMB;

  bool validadorNombreProyecto;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child:Card(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child:
                    Form
                      (key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15),
                            Image.asset('assets/images/nuevo.png',height: 60,),
                            Text('Nuevo Proyecto', style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                              fontSize: 18,)),
                            TextFormField(
                                decoration: InputDecoration(
                                    icon: Icon(Icons.folder_open),
                                    labelText: 'Nombre Proyecto'
                                ),
                                validator: (String nProyecto) {
                                  
                                  if (nProyecto.isEmpty) {
                                    return 'Nombre de Proyecto no válido';
                                  }else {
                                    setState(() {
                                      nombreProyectoMB = nProyecto;
                                      return null;
                                    });
                                  }}
                              ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.location_on),
                                  labelText: 'Ubicación del Proyecto'
                              ),
                              validator: (String nUbicacion) {
                                if (nUbicacion.isEmpty) {
                                  return 'Ubicación del Proyecto no válida';
                                }else {
                                ubicacionMB = nUbicacion;
                                  return null;
                              }},
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.import_contacts),
                                  labelText: 'Descripción Proyecto'
                              ),
                              validator: (String nDescripcion) {
                                if (nDescripcion.isEmpty) {
                                  return 'Descripción del Proyecto no válido';
                                } else {
                                  decripcionMB = nDescripcion;
                                  return null;
                            }},
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.group),
                                  labelText: 'Cliente'
                              ),
                              validator: (String nCliente) {
                                if (nCliente.isEmpty) {
                                  return 'Nombre del cliente no válido';
                                } else{
                                  clienteMB = nCliente;
                                return null;
                              }},
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.location_city),
                                  labelText: 'Empresa'
                              ),
                              validator: (String nEmpresa){
                                if (nEmpresa.isEmpty) {
                                  return 'Nombre de la empresa no válido';
                                } else {
                                  
                                  empresaMB = nEmpresa;
                                  return null;
                              }},

                            ),
                            SizedBox(height: 25,),
                            Text('Seleccione el tipo de proyección a Utilizar', style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff007FFF),
                              fontSize: 16,)),
                            Container(
                              height: 250,
                              child:MediaQuery.removePadding(removeTop: true,
                              context: context,
                               child: ListView(
                                children: <Widget>[
                                        SizedBox(height: 20,),
                                        ListTile(
                                          leading: Icon(Icons.add_location, color: Colors.black54),
                                          title: Text('Proyección Gauss Krüger'),
                                          subtitle: Text('Sistema de coordenadas proyectadas Cilíndricas, Colombia cuenta con seis origenes'),
                                          onTap: ()async {
                                            if (_formKey.currentState.validate()) {
                                              proyeccionMB = 'Gauss Krüger';
                                              bool validarNombre = await gestorMBDatabase.db.validarNombreProyecto(nombreProyectoMB);
                                              if(validarNombre == true) {
                                                mostrarAlertaNombreProyecto();
                                              } else {
                                                Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => SeleccionSistemaCoordendas(
                                                clienteMB: clienteMB,
                                                decripcionMB: decripcionMB,
                                                empresaMB: empresaMB,
                                                nombreProyectoMB: nombreProyectoMB,
                                                proyeccionMB: proyeccionMB,
                                                ubicacionMB: ubicacionMB,
                                                gauss: true,
                                                fk_Municipio: 1,
                                                id_Usuario: widget.idUsuario,
                                              ),
                                              ));
                                              }
                                              
                                            }
                                            // No diligenciaron todos los campos
                                          }
                                        ),
                                        SizedBox(height: 10,),
                                        ListTile(
                                          leading: Icon(Icons.add_location, color: Colors.black54),
                                          title: Text('Proyección Plana Cartesiana'),
                                          subtitle: Text('Sistema de proyección cartesiano, usado para grandes escalas, razón por la cual existen tantos origenes como municipios'),
                                          onTap: ()async {
                                            
                                            if(_formKey.currentState.validate()) {
                                              bool validarNombre = await gestorMBDatabase.db.validarNombreProyecto(nombreProyectoMB);
                                              if(validarNombre == true) {
                                                mostrarAlertaNombreProyecto();
                                              } else {
                                                _alertDialogoCartesianas(context);
                                              }
                                            }else {
                                            
                                            }
                                            }                                          
                                          
                                        ),
                                        SizedBox(height: 10,),
                                        ListTile(
                                          leading: Icon(Icons.add_location, color: Color(0xff007FFF)),
                                          title: Text('Origen Nacional',style: TextStyle(
                                            color: Color(0xff007FFF)
                                          ),),
                                          subtitle: Text('Sistema de proyección Transversal de Mercator implementado mediante resolución 471 del 2020 IGAC, cubre en su totalidad el territorio Nacional'),
                                          onTap: ()async {
                                            
                                            if(_formKey.currentState.validate()) {
                                              bool validarNombre = await gestorMBDatabase.db.validarNombreProyecto(nombreProyectoMB);
                                              if(validarNombre == true) {
                                                mostrarAlertaNombreProyecto();
                                              } else {
                                                gestorMBDatabase.db.InserDataSQL('INSERT INTO PROYECTOS (ID_USUARIO, Nombre_Proyecto, Tipo_Proyeccion, ID_Proyeccion, Ubicacion, Empresa, Cliente, Descripcion) VALUES ("${widget.idUsuario}", "${nombreProyectoMB}", "Transversal de Mercator", "Origen Nacional", "${ubicacionMB}", "${empresaMB}", "${clienteMB}",  "${decripcionMB}")');
                                                Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => MenuPrincipalMB(
                                                clienteMB: clienteMB,
                                                decripcionMB: decripcionMB,
                                                empresaMB: empresaMB,
                                                id_proyeccion: 'Origen Nacional',
                                                id_usuario: widget.idUsuario,
                                                nombreProyectoMB: nombreProyectoMB,
                                                proyeccionMB: 'Transversal de Mercator',
                                                ubicacionMB: ubicacionMB,
                                                ),
                                                ));
                                              }
                                            }
                                            }                                          
                                          
                                        )
                                ],
                               ),
                              ),
                            ),
                          ],

                    )
                    ),
                  ),
                )
                ),
              )
            );
          }
  void _alertDialogoCartesianas(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Container(
      height: 500,
      
      child: Scaffold(
        body: FutureBuilder<List<departamentos>>(
          future: gestorMBDatabase.db.getDepartamentos(),
          builder: (BuildContext context, AsyncSnapshot<List<departamentos>> listaDep){
            if(listaDep.hasData) {
                return Container(
                  height: 700,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text('Seleccione un Departamento', style: TextStyle(
                        color: Color(0xff007FFF),
                        fontSize: 16.0
                      ),),
                      SizedBox(
                        height: 14.0,
                      ),
                      Flexible(
                      child: ListView.builder(
                      itemCount: listaDep.data.length,
                      itemBuilder: (BuildContext context, int index){
                      departamentos listaDepartamentos = listaDep.data[index];
                      return Dismissible(
                      onDismissed: (direction){},
                      key: UniqueKey(), 
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: Text(listaDepartamentos.NOMBRE, style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0
                          ),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.chevron_right, color: Colors.blueAccent)
                          ],
                        ),
                        onTap: (){
                          _alertDialogoCartesianasMunicipio(context, listaDepartamentos.PK_DEPARTAMENTO);
                        },
                        )
                      )
                      );
                      }   
                      ),
                      )
                    ],
                  )
                );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
              );
            }
          }
          ),
      ),
    )
  );
}

  void _alertDialogoCartesianasMunicipio(BuildContext context, int fk_Departamento) {
  showDialog(
    context: context,
    builder: (context) => Container(
      height: 500,
      
      child: Scaffold(
        body: FutureBuilder<List<municipios>>(
          future: gestorMBDatabase.db.getMunicipios(fk_Departamento),
          builder: (BuildContext context, AsyncSnapshot<List<municipios>> listaMunicipios){
            if(listaMunicipios.hasData) {
                return Container(
                  height: 700,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text('Seleccione un Municipio', style: TextStyle(
                        color: Color(0xff007FFF),
                        fontSize: 16.0
                      ),),
                      SizedBox(
                        height: 14.0,
                      ),
                      Flexible(
                      child: ListView.builder(
                      itemCount: listaMunicipios.data.length,
                      itemBuilder: (BuildContext context, int index){
                      municipios listaMun = listaMunicipios.data[index];
                      return Dismissible(
                      key: UniqueKey(), 
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: Text(listaMun.NOMBRE, style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0
                          ),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.chevron_right, color: Colors.blueAccent)
                          ],
                        ),
                        onTap: (){
                          proyeccionMB = 'Planas Cartesianas';
                            Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SeleccionSistemaCoordendas(
                            id_Usuario: widget.idUsuario,
                            clienteMB: clienteMB,
                            decripcionMB: decripcionMB,
                            empresaMB: empresaMB,
                            nombreProyectoMB: nombreProyectoMB,
                            proyeccionMB: proyeccionMB,
                            ubicacionMB: ubicacionMB,
                            gauss: false,
                            fk_Municipio: listaMun.PK_MUNICIPIOS,

                           ),
                          ));
                        },
                        )
                      )
                      );
                      }   
                      ),
                      )
                    ],
                  )
                );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
              );
            }
          }
          ),
      ),
    )
  );
}

  void mostrarAlertaNombreProyecto(){
    Fluttertoast.showToast(
    msg: "El proyecto ya existe",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1
    );
  }
}

