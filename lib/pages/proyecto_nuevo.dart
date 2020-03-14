import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/proyectos.dart';

class NuevoProyecto extends StatefulWidget {
  NuevoProyecto({Key key}) : super(key: key);

  @override
  _NuevoProyectoState createState() => _NuevoProyectoState();
}


class _NuevoProyectoState extends State<NuevoProyecto> {

  // Definición de Variables a Usar

  String nombreProyecto;
  String ubicacion;
  String fecha;
  String empresa;
  String cliente;
  String descripcion;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<proyectos>> (
        future: gestorMBDatabase.db.getProyectos(),
        builder: (BuildContext context, AsyncSnapshot<List<proyectos>> snapshot){
          int contadorProyectos = snapshot.data.length;

          if(contadorProyectos>0){
            print(contadorProyectos);
            // Interfaz si se tienen proyectos existentes.
            return Scaffold(
              body: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
                  },
                  itemCount: 3,
                  control: new SwiperControl(),
              ),
            );
          } else {
            return Scaffold(
              body: SingleChildScrollView(
                child:Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child:
                  Form
                    (key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 40,),
                          Image.asset('assets/images/nuevo.png',height: 80,),
                          Text('Nuevo Proyecto', style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xff007FFF),
                            fontSize: 18,)),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.folder_open),
                                labelText: 'Nombre Proyecto'
                            ),
                            validator: (String nProyecto) {
                              if (nProyecto.isEmpty) {
                                return 'Nombre de Proyecto no valido';
                              }return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_on),
                                labelText: 'Ubicación del Proyecto'
                            ),
                            validator: (String nUbicacion) {
                              if (nUbicacion.isEmpty) {
                                return 'Ubicación del Proyecto no valida';
                              }return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.import_contacts),
                                labelText: 'Descripción Proyecto'
                            ),
                            validator: (String nDescripcion) {
                              if (nDescripcion.isEmpty) {
                                return 'Descripción del Proyecto no valido';
                              }return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.group),
                                labelText: 'Cliente'
                            ),
                            validator: (String nCliente) {
                              if (nCliente.isEmpty) {
                                return 'Nombre del cliente no valido';
                              }return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_city),
                                labelText: 'Empresa'
                            ),
                            validator: (String nEmpresa) {
                              if (nEmpresa.isEmpty) {
                                return 'Nombre de la empresa no valida';
                              }return null;
                            },
                          ),
                          SizedBox(height: 50,),
                          Text('Los datos Ingresados, serán usados unicamente para la generación de reportes', style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black54,
                              fontSize: 12,

                          ),),
                          SizedBox(height: 30.0),
                          FlatButton(
                              onPressed:(){
                                if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                                Scaffold.of(context)
                                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                                                          }
                                else {
                                }
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.chevron_right, size: 75.0, color: Color(0xff007FFF),),
                                  Text('Continuar', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color(0xff007FFF),
                                      fontSize: 18
                                  ),)
                                ],
                              )
                          )
                        ],

                  )
                  ),
                ),
              )
              )
            );
          }
        },
      ),

       );
  }
}