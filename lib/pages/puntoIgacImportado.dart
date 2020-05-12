import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:measurebookapp/clases/database.dart';
import 'gestorPuntos.dart';
import 'dart:math' as m;

class PuntoIgacImportado extends StatefulWidget {
  final String idUsuario, nombreProyecto, nombrePunto, sistemaCoordenadas,pkSistemaCoordenadas;
  final double norte, este, altura, ondulacion;
  final bool tipoAltura;

  PuntoIgacImportado({Key key, this.sistemaCoordenadas, this.pkSistemaCoordenadas,this.idUsuario, this.nombreProyecto,this.nombrePunto, this.norte, this.este, this.altura, this.tipoAltura, this.ondulacion}) : super(key: key);

  @override
  _PuntoIgacImportadoState createState() => _PuntoIgacImportadoState();
}

class _PuntoIgacImportadoState extends State<PuntoIgacImportado> {


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
  String fotoPlacaSTRING,fotoNorteSTRING,fotoEsteSTRING,fotoSurSTRING,fotoOesteSTRING;
  @override
  final _textEditingAlturaController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    _textEditingAlturaController.addListener(_textEditingAlturaControllerListener);
  }

  void _textEditingAlturaControllerListener(){
    if(alturaOrtometrica == true){
      _textEditingAlturaController.text = (widget.altura-widget.ondulacion).toString();
    }else {
      _textEditingAlturaController.text = (widget.altura).toString();
    }
  }

//Conversión de Coordenadas importadas
  double roundDouble(double value, int places){ 
   double mod = m.pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}
// Estado tipo de Altura
String tipoaltura(bool tipoALturaSw){
    if (alturaOrtometrica == true) {
      String alturaOrtometricaSW = 'Ortométrica';
      setState(() {
        alturaPuntoNuevo = widget.altura-widget.ondulacion;
      }); 
      return alturaOrtometricaSW;
    }else {
      String alturaOrtometricaSW = 'Elipsoidal';
      setState(() {
        alturaPuntoNuevo = widget.altura;
      });
      return alturaOrtometricaSW;
    }
  }
  // Tomar foto con cámara
  void _abrirCamara (String nombreFoto) async{
    if (nombreFoto == 'placa') {
      var fPlaca = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      maxHeight: 1500,
      maxWidth: 1200,
    );
    fotoPlacaBytes = await fPlaca.readAsBytes();
    fotoPlacaSTRING = base64.encode(fotoPlacaBytes);
    this.setState(() {
      fotoPlaca = fPlaca;
      
      
    });
    } else if(nombreFoto == 'norte'){
      var fNorte = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      maxHeight: 1500,
      maxWidth: 1200,
      );
      fotoNorteBytes = await fNorte.readAsBytes();
      fotoEsteSTRING = base64.encode(fotoNorteBytes);
      this.setState(() {
      fotoNorte = fNorte;
    });
    } else if (nombreFoto == 'este') {
      var fEste = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      maxHeight: 1500,
      maxWidth: 1200,
      );
      fotoEsteBytes = await fEste.readAsBytes();
      fotoEsteSTRING = base64.encode(fotoEsteBytes);
      this.setState(() {
      fotoEste = fEste;
    });
    } else if (nombreFoto == 'sur') {
      var fSur = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      maxHeight: 1500,
      maxWidth: 1200,
      );
      fotoSurBytes = await fSur.readAsBytes();
      fotoSurSTRING = base64.encode(fotoSurBytes);
      this.setState((){
      fotoSur = fSur;
    });
  }else {
    var fOeste = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
      maxHeight: 1500,
      maxWidth: 1200,
    );
    fotoOesteBytes = await fOeste.readAsBytes();
    fotoOesteSTRING = base64.encode(fotoOesteBytes);
    this.setState(() {
      fotoOeste = fOeste;
    });
  }
  }
  // Cargar Fotos de Galeria
  void _abrirGaleria (BuildContext context,String nombreFoto) async {
    if (nombreFoto == 'placa') {
      var fPlaca = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1200,
    );
    fotoPlacaBytes = await fPlaca.readAsBytes();
    fotoPlacaSTRING = base64.encode(fotoPlacaBytes);
    this.setState(() {
      fotoPlaca = fPlaca;
    });
    } else if(nombreFoto == 'norte') {
      var fNorte = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1200,
      );
      fotoNorteBytes =  await fNorte.readAsBytes();
      fotoNorteSTRING = base64.encode(fotoNorteBytes);
      this.setState((){
      fotoNorte = fNorte;
    });
    } else if (nombreFoto == 'este') {
      var fEste = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1200,
      );
      fotoEsteBytes = await fEste.readAsBytes();
      fotoEsteSTRING = base64.encode(fotoEsteBytes);
      this.setState((){
      fotoEste = fEste;
    });
    } else if (nombreFoto == 'sur') {
      var fSur = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1200,
      );
      fotoSurBytes = await fSur.readAsBytes();
      fotoSurSTRING = base64.encode(fotoSurBytes);
      this.setState((){
      fotoSur = fSur;
    });
  }else {
    var fOeste = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1200,
    );
    fotoOesteBytes =  await fOeste.readAsBytes();
    fotoOesteSTRING = base64.encode(fotoOesteBytes);
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
                    title: Text('Seleccionar Foto de Galería',style: TextStyle(
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
                      initialValue: widget.nombrePunto,
                      decoration: InputDecoration(
                      icon: Icon(Icons.add_location),
                      labelText: 'Nombre del Punto',
                      ),
                      validator: (String nombrePunto){
                        if (nombrePunto.isEmpty) {
                          return 'Nombre del Punto Inválido';
                        } else {
                          nombrePuntoNuevo = nombrePunto;
                          return null;
                        }
                        },
                      ),
                      TextFormField(
                      initialValue: '${widget.norte}',
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Coordenada Norte',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String nortePunto){
                        if (nortePunto.isEmpty) {
                          return 'Coordenada Norte Inválida';
                        } else {
                          nortePuntoNuevo = double.parse(nortePunto);
                          return null;
                        }
                        },
                      ),
                      TextFormField(
                        initialValue: '${widget.este}',
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_location),
                          labelText: 'Coordenada Este',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                        validator: (String estePunto){
                          if (estePunto.isEmpty) {
                          return 'Coordenada Este Inválida';
                        } else {
                          estePuntoNuevo = double.parse(estePunto);
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: '${ roundDouble(widget.altura-widget.ondulacion,3)}',
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_location),
                        labelText: 'Altura Ortométrica del Punto',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [WhitelistingTextInputFormatter(new RegExp(r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'))],
                      validator: (String alturaPunto){
                        if (alturaPunto.isEmpty) {
                          return 'Altura del Punto inválida';
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
                          gestorMBDatabase.db.InserDataSQL('INSERT INTO PUNTOS_REFERENCIA (Id_Usuario, Proyecto, Nombre_Punto, Norte, Este, Altura, Tipo_Altura, Foto_Placa, Foto_Norte, Foto_Este, Foto_Sur, Foto_Oeste) VALUES ("${widget.idUsuario}", "${widget.nombreProyecto}", "${nombrePuntoNuevo}", ${nortePuntoNuevo}, ${estePuntoNuevo}, ${alturaPuntoNuevo}, "${tipoaltura(alturaOrtometrica)}", "${fotoPlacaSTRING}", "${fotoNorteSTRING}", "${fotoEsteSTRING}", "${fotoSurSTRING}", "${fotoOesteSTRING}")');
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => GestosPuntos(
                            idProyeccion: widget.pkSistemaCoordenadas,
                            idUser: widget.idUsuario,
                            nombreProyecto: widget.nombreProyecto,
                            proyeccionMB: widget.sistemaCoordenadas,
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