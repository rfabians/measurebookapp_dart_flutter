import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:measurebookapp/clases/database.dart';

import 'gestorPuntos.dart';

class PuntoNuevo extends StatefulWidget {
  final String idUserMB;
  final String nombreProyecto, proyeccion, id_sistemaCoor;
  PuntoNuevo({Key key, this.idUserMB, this.nombreProyecto, this.id_sistemaCoor, this.proyeccion}) : super(key: key);
  @override
  _PuntoNuevoState createState() => _PuntoNuevoState();
}

class _PuntoNuevoState extends State<PuntoNuevo> {
  bool alturaOrtometrica = true;
  double nortePuntoNuevo;
  double estePuntoNuevo;
  double alturaPuntoNuevo;
  String nombrePuntoNuevo;
  var fotoPlaca = null;
  var fotoNorte = null;
  var fotoEste = null;
  var fotoSur = null;
  var fotoOeste = null;
  List<int> fotoPlacaBytes = null;
  List<int> fotoNorteBytes = null;
  List<int> fotoEsteBytes = null;
  List<int> fotoSurBytes = null;
  List<int> fotoOesteBytes = null;


  //Obtener tipo de ALtura de Shuch
  String tipoaltura(bool tipoALturaSw){
    if (tipoALturaSw == true) {
      String alturaOrtometricaSW = 'Ortométrica';
      return alturaOrtometricaSW;
    }else {
      String alturaOrtometricaSW = 'Elipsoidal';
      return alturaOrtometricaSW;
    }
  }
  // Tomar foto con cámara
  void _abrirCamara (String nombreFoto) async{
    if (nombreFoto == 'placa') {
      var fPlaca = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      
    );
    fotoPlacaBytes = await fPlaca.readAsBytes();
    this.setState(() {
      fotoPlaca = fPlaca;
      
    });
    } else if(nombreFoto == 'norte'){
      var fNorte = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      );
      fotoNorteBytes = await fNorte.readAsBytes();
      this.setState(() {
      fotoNorte = fNorte;
    });
    } else if (nombreFoto == 'este') {
      var fEste = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      );
      fotoEsteBytes = await fEste.readAsBytes();
      this.setState(() {
      fotoEste = fEste;
    });
    } else if (nombreFoto == 'sur') {
      var fSur = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      );
      fotoSurBytes = await fSur.readAsBytes();
      this.setState((){
      fotoSur = fSur;
    });
  }else {
    var fOeste = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    fotoOesteBytes = await fOeste.readAsBytes();
    this.setState(() {
      fotoOeste = fOeste;
    });
  }
  }
  // Cargar Fotos de Galeria
  void _abrirGaleria (BuildContext context,String nombreFoto) async {
    if (nombreFoto == 'placa') {
      var fPlaca = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    fotoPlacaBytes = await fPlaca.readAsBytes();
    this.setState(() {
      fotoPlaca = fPlaca;
    });
    } else if(nombreFoto == 'norte') {
      var fNorte = await ImagePicker.pickImage(
      source: ImageSource.gallery
      );
      fotoNorteBytes =  await fNorte.readAsBytes();
      this.setState((){
      fotoNorte = fNorte;
    });
    } else if (nombreFoto == 'este') {
      var fEste = await ImagePicker.pickImage(
      source: ImageSource.gallery
      );
      fotoEsteBytes = await fEste.readAsBytes();
      this.setState((){
      fotoEste = fEste;
    });
    } else if (nombreFoto == 'sur') {
      var fSur = await ImagePicker.pickImage(
      source: ImageSource.gallery
      );
      fotoSurBytes = await fSur.readAsBytes();
      this.setState((){
      fotoSur = fSur;
    });
  }else {
    var fOeste = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    fotoOesteBytes =  await fOeste.readAsBytes();
    this.setState((){
      fotoOeste = fOeste;
    });
  }
  }
  Future<void> _opcionesFoto (BuildContext context,String nombrFoto) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
            ),
           content: SingleChildScrollView(
             child: ListBody(
               children: <Widget>[
                 ListTile(
                     leading: Icon(Icons.add_a_photo, size: 30, color: Colors.blueAccent),
                     title: Text('Capturar Foto',style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: 16.0,
                      color: Colors.black54,
                      )),
                      onTap: (){
                        _abrirCamara(nombrFoto);
                        Navigator.pop(context);
                      },
                   ),
                 Divider(),
                 ListTile(
                    leading: Icon(Icons.add_photo_alternate, size: 30, color: Colors.blueAccent),
                    title: Text('Seleccionar Foto de Galeria',style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 16.0,
                    color: Colors.black54,
                    )),
                    onTap: (){
                      _abrirGaleria(context,nombrFoto);
                      Navigator.pop(context);
                    },
                   ),
               ],
             ),
           ),
        );
      }
    );
  }
  Widget wFotoNorte() {
      if(fotoNorte == null) {
        return Icon(Icons.add_a_photo, size: 75, color: Colors.black54,
          );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.file(fotoNorte, width: 150, fit: BoxFit.fill,));
      }
  }
  // Revisar tamaño
  Widget wFotoPlaca() {
      if(fotoPlaca == null) {
        return Icon(Icons.add_a_photo, size: 100, color: Colors.blueAccent,);
      } else {
        return  ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(fotoPlaca, height: 400,fit: BoxFit.fill, width: 300,));
      }
  }
  Widget wFotoEste() {
      if(fotoEste == null) {
        return Icon(Icons.add_a_photo, size: 75, color: Colors.black54,);
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.file(fotoEste, width: 150,fit: BoxFit.fill));
      }
  }
  Widget wFotoSur() {
      if(fotoSur == null) {
        return Icon(Icons.add_a_photo, size: 75, color: Colors.black54,);
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.file(fotoSur, width: 150, fit: BoxFit.fill,));
      }
  }
  Widget wFotoOeste() {
      if(fotoOeste == null) {
        return Icon(Icons.add_a_photo, size: 75, color: Colors.black54,);
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(fotoOeste,width: 150  ,fit: BoxFit.fill,));
      }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: Form(
               key: _formKey,
               child: Center(
                 child: Column(
                   children: <Widget>[
                     Icon(Icons.add_location,size: 80, color: Colors.blueAccent,),
                      Text('Nuevo Punto de Referencia', style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xff007FFF),
                      fontSize: 18,)),
                      Divider(height: 20),
                      TextFormField(
                      decoration: InputDecoration(
                      icon: Icon(Icons.add_location),
                      labelText: 'Nombre del Punto',
                      ),
                      validator: (String nombrePunto){
                        if (nombrePunto.isEmpty) {
                          return 'Nombre del Punto Invalido';
                        } else {
                          nombrePuntoNuevo = nombrePunto;
                          return null;
                        }
                        },
                      ),
                      TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Coordenada Norte',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String nortePunto){
                        if (nortePunto.isEmpty) {
                          return 'Coordenadas Norte Invalida';
                        } else {
                          nortePuntoNuevo = double.parse(nortePunto);
                          return null;
                        }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_location),
                          labelText: 'Coordenada Este',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                        validator: (String estePunto){
                          if (estePunto.isEmpty) {
                          return 'Coordenadas Este Invalida';
                        } else {
                          estePuntoNuevo = double.parse(estePunto);
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Altura del Punto',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String alturaPunto){
                        if (alturaPunto.isEmpty) {
                          return 'Altura del Punto invalida';
                        } else {
                          alturaPuntoNuevo = double.parse(alturaPunto);
                          return null;
                        }
                      },
                    ),
                    Divider(height: 20.0),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                              Text('Altura Ortométrica'),
                              Align(
                              alignment: Alignment.centerLeft,
                              child: CupertinoSwitch(
                              value: alturaOrtometrica,
                              activeColor: Colors.blueAccent,
                              onChanged: (altOrtometrico){
                              alturaOrtometrica = altOrtometrico;
                              },
                            ),
                          ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text('Registro Fotográfico', style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18.0
                          ),),
                          Text('Placa', style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12.0,
                          ),),
                          GestureDetector(
                            onTap: () {
                              _opcionesFoto(context,'placa');
                            },
                            child: wFotoPlaca(),
                          ),
                          Divider(height: 10),
                          Text('Panoramicas', style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                          ),),
                          Divider(height: 10),
                          SingleChildScrollView(
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('Norte', style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                    ),),
                                    GestureDetector(
                                      child: wFotoNorte(),
                                      onTap: (){
                                        _opcionesFoto(context, 'norte');
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: <Widget>[
                                    Text('Este', style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                    ),),
                                    GestureDetector(
                                      child: wFotoEste(),
                                      onTap: (){
                                        _opcionesFoto(context, 'este');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 10.0,),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text('Oeste', style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                       ),),
                                      GestureDetector(
                                        onTap: (){
                                          _opcionesFoto(context, 'oeste');
                                        },
                                        child: wFotoOeste(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Sur', style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                      ),),
                                      GestureDetector(
                                        child: wFotoSur(),
                                        onTap: (){
                                          _opcionesFoto(context, 'sur');
                                        },
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(height: 20,),
                    FlatButton(onPressed: () {
                      if (_formKey.currentState.validate()) {
                          gestorMBDatabase.db.InserDataSQL('INSERT INTO PUNTOS_REFERENCIA (Id_Usuario, Proyecto, Nombre_Punto, Norte, Este, Altura, Tipo_Altura, Foto_Placa, Foto_Norte, Foto_Este, Foto_Sur, Foto_Oeste) VALUES ("${widget.idUserMB}", "${widget.nombreProyecto}", "${nombrePuntoNuevo}", ${nortePuntoNuevo}, ${estePuntoNuevo}, ${alturaPuntoNuevo}, "${tipoaltura(alturaOrtometrica)}", "${fotoPlacaBytes}", "${fotoNorteBytes}", "${fotoEsteBytes}", "${fotoSurBytes}", "${fotoOesteBytes}")');
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => GestosPuntos(
                            idProyeccion: widget.id_sistemaCoor,
                            idUser: widget.idUserMB,
                            nombreProyecto: widget.nombreProyecto,
                            proyeccionMB: widget.proyeccion,
                        )));
                      }else {
                        // No se Diligenciaron los Campos
                      }
                    },
                    child: Text('Guardar Punto', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blueAccent,
                    )
                   ],
                 ),
               ),
             )
           ),
         ),
       ),
    );
  }
}