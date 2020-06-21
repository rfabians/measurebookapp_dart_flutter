import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



class DescripcionVerticeII extends StatefulWidget {
  DescripcionVerticeII({Key key}) : super(key: key);

  @override
  _DescripcionVerticeIIState createState() => _DescripcionVerticeIIState();
}
  
  
class _DescripcionVerticeIIState extends State<DescripcionVerticeII> {
  CameraController _controller;
  Future<void> _initCamFuture;
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  _initApp() async {
    final cameras = await availableCameras();
    final firstCam = cameras.first;

    _controller = CameraController(
      firstCam,
      ResolutionPreset.medium,
    );

    _initCamFuture = _controller.initialize();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: Container(
               child: Center(
                 child: Column(
                   children: <Widget>[
                     Icon(Icons.assignment, size: 60, color: Colors.black54),
                       Divider(),
                       Text('Creación de formato de descripción de punto GNSS',style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
                       Divider(),
                       Text('Diagrama de Obstaculos', style: TextStyle(fontSize: 12, color: Colors.black54)),
                       Divider(),
                       GestureDetector(
                         child: Container(
                           height: 300,
                           child: Column(
                             children: <Widget>[
                              Image.asset('assets/images/obstaculos.png', height: 250),
                              SizedBox(height: 10),
                              Text('Generar Diagrama de Obstaculos', style: TextStyle(fontSize: 12, color: Colors.black54)),
                             ],
                           ),
                         ),
                         onTap: (){
                           AlertDialog mostarCamara = AlertDialog(
                             content: Container(
                               child: Scaffold(
                                 body: FutureBuilder<void>(
                                   future: _initCamFuture,
                                   builder: (context, snapshot) {
                                     return AspectRatio(aspectRatio: _controller.value.aspectRatio, child: CameraPreview(_controller),)
                                   }
                                 ),
                               )
                             ),
                           );
                           showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
                            return mostarCamara;
                            });
                         },
                       ),
                    Divider()
                   ],
                 ),
               ),
             ),
           ),
         )
         ),
    );
  }

}