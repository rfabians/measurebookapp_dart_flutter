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
                           obtenerDatosDiagrama(context);
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
  void obtenerDatosDiagrama(BuildContext context){
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        floatingActionButton: FlatButton(
          onPressed: null, 
          child: Icon(Icons.check_circle_outline , size: 40, color: Colors.blueAccent,)
          ),
      body: FutureBuilder<void>(
        future: _initCamFuture,
        builder: (context, snapshot) {
          return SizedBox.expand(
            child:Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                          SizedBox(height: 5),
                          Icon(Icons.assignment_turned_in, size: 50,color: Colors.black54),
                          Divider(),
                          Text('Generador de Diagramas de Obstaculos'),
                          Divider(),
                          Stack(
                            children: <Widget>[
                            SizedBox(height: 20),
                            Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                              ),
                              width: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio, 
                                  child: CameraPreview(_controller)),
                              )
                                )),
                            Positioned(
                              left: (MediaQuery.of(context).size.width/2)-25,
                              top: (MediaQuery.of(context).size.height*0.25)-25,
                              child: Icon(Icons.add_circle_outline, size: 50, color: Colors.black54,)),
                        ],
                      ),
                      ],
                    )
                  )
                ],
              )
              
            ],
          )
          );
        }
      ),
    ));
  }
}