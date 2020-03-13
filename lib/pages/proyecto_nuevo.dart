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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder<List<proyectos>> (
        future: gestorMBDatabase.db.getProyectos(),
        builder: (BuildContext context, AsyncSnapshot<List<proyectos>> snapshot){
          if(snapshot.hasData){
            // Interfaz si se tienen proyectos existentes.
            return Scaffold(
              body: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
                  },
                  itemCount: 3,
                  control: new SwiperControl(),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text("Hola mundo"),
              ),
            );
          }
        },
      ),

       );
  }
}