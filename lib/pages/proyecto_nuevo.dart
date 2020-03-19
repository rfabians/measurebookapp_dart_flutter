import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/proyectos.dart';
import 'package:measurebookapp/pages/seleccionSistemaCoordenadas.dart';

class NuevoProyecto extends StatefulWidget {
  NuevoProyecto({Key key}) : super(key: key);

  @override
  _NuevoProyectoState createState() => _NuevoProyectoState();
}


class _NuevoProyectoState extends State<NuevoProyecto> {

  // Definición de Variables a Usar
  String nombreProyectoMB,ubicacionMB, clienteMB, empresaMB, proyeccionMB, decripcionMB;


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
                          
                          TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.folder_open),
                                labelText: 'Nombre Proyecto'
                            ),
                            validator: (String nProyecto) {
                              if (nProyecto.isEmpty) {
                                return 'Nombre de Proyecto no valido';
                              }else {
                              nombreProyectoMB = nProyecto;
                                return null;
                              }
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
                                return 'Descripción del Proyecto no valido';
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
                                return 'Nombre del cliente no valido';
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
                            validator: (String nEmpresa) {
                              if (nEmpresa.isEmpty) {
                                return 'Nombre de la empresa no valida';
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
                            height: 180,
                            child:MediaQuery.removePadding(removeTop: true,
                            context: context,
                             child: ListView(
                              children: <Widget>[
                                      SizedBox(height: 20,),
                                      ListTile(
                                        leading: Icon(Icons.add_location, color: Color(0xff007FFF)),
                                        title: Text('Proyección Gauss Krüger'),
                                        subtitle: Text('Sistema de coordenadas proyectadas Cilindricas, Colombia cuenta con seis Origenes'),
                                        onTap: (){
                                          if (_formKey.currentState.validate()) {
                                            proyeccionMB = 'Gauss';
                                            Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => SeleccionSistemaCoordendas(
                                              clienteMB: clienteMB,
                                              decripcionMB: decripcionMB,
                                              empresaMB: empresaMB,
                                              nombreProyectoMB: nombreProyectoMB,
                                              proyeccionMB: proyeccionMB,
                                              ubicacionMB: ubicacionMB,
                                              gauss: true,
                                            ),
                                            ));
                                          }
                                          // No diligenciaron todos los campos
                                        }
                                      ),
                                      SizedBox(height: 10,),
                                      ListTile(
                                        leading: Icon(Icons.add_location, color: Color(0xff007FFF)),
                                        title: Text('Proyección Plana Cartesiana',style: TextStyle(
                                          color: Color(0xff007FFF)
                                        ),),
                                        subtitle: Text('Sistema de proyección cartesiano, usado para grandes escalas, razón por la cual existen tantos origenes como municipios'),
                                        onTap: (){
                                          if (_formKey.currentState.validate()) {
                                            proyeccionMB = 'Cartesiana';
                                            Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => SeleccionSistemaCoordendas(
                                              clienteMB: clienteMB,
                                              decripcionMB: decripcionMB,
                                              empresaMB: empresaMB,
                                              nombreProyectoMB: nombreProyectoMB,
                                              proyeccionMB: proyeccionMB,
                                              ubicacionMB: ubicacionMB,
                                              gauss: false,
                                            ),
                                            ));
                                          }
                                          // No diligenciaron todos los campos
                                        },
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
              )
            );
          }
        },
      ),

       );
  }
}