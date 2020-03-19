import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:measurebookapp/modelos/departamentos.dart';
import 'package:measurebookapp/modelos/origenesGauss.dart';
import 'package:measurebookapp/clases/database.dart';

class SeleccionSistemaCoordendas  extends StatefulWidget {
final String nombreProyectoMB,ubicacionMB, clienteMB, empresaMB, proyeccionMB, decripcionMB;
final bool gauss;
SeleccionSistemaCoordendas({Key key, this.nombreProyectoMB, this.ubicacionMB, this.decripcionMB, this.clienteMB, this.empresaMB, this.proyeccionMB, this.gauss}) : super (key: key);

  @override
  _SeleccionSistemaCoordendasState createState() => _SeleccionSistemaCoordendasState();

}

bool _gauss;

class _SeleccionSistemaCoordendasState extends State<SeleccionSistemaCoordendas> {


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Center(
      child: SingleChildScrollView(
      child: widget.gauss
      ? 
    // Planas Gauss
    Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.0)
      )
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        body:FutureBuilder<List<origenesGauss>>(
          future: gestorMBDatabase.db.getGauss(),
          builder: (BuildContext context, AsyncSnapshot<List<origenesGauss>> snapshot) {
            if(snapshot.hasData){
              print(snapshot.data.length);
              return Swiper(
                layout: SwiperLayout.STACK,
                itemWidth: MediaQuery.of(context).size.width * 0.8,
                itemHeight: MediaQuery.of(context).size.height * 0.8,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  origenesGauss listaOrigenes = snapshot.data[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    key: UniqueKey(),
                    child: Card(
                      elevation: 14.0,
                      child: Container(
                        decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/fondo_sistemas.png'),
                        fit: BoxFit.cover,
                         ), 
                         borderRadius: BorderRadius.all(Radius.circular(10.0)
                         )  
                         ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '    Gauss-Krüger', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 18.0
                                  )),
                              ]
                            )),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '    ${listaOrigenes.NOMBRE}', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 18.0
                                ),
                              ),
                            ),
                            SizedBox(height: 80.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'DATUM ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 16.0
                                )),
                                TextSpan( text: 'Magna Sirgas        ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 16.0
                                ))
                              ]
                            )),
                            ),
                            SizedBox(height: 5.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Elipsoide: ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 16.0
                                )),
                                TextSpan( text: 'GRS80        ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 16.0
                                ))
                              ]
                            )),
                            ),
                            SizedBox(height: 80.0,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '      Sistema de Proyección ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 18.0
                                )),
                              ]
                            )),
                            ),
                            SizedBox(height: 15.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '      Proyección: ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 14.0
                                )),
                                TextSpan( text: '               Transversal de Mercator', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 14.0
                                ))
                              ]
                            )),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '      Latitud de Origen: ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 14.0
                                )),
                                TextSpan( text: '     ${listaOrigenes.LATITUD.toString()}', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 14.0
                                ))
                              ]
                            )),
                            ), 
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '      Longitud de Origen: ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 14.0
                                )),
                                TextSpan( text: ' ${listaOrigenes.LONGITUD.toString()}', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 14.0
                                ))
                              ]
                            )),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '      Falso Norte: ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 14.0
                                )),
                                TextSpan( text: '               ${listaOrigenes.NORTE.toString()}00 m', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 14.0
                                ))
                              ]
                            )),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '      Falso Este: ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 14.0
                                )),
                                TextSpan( text: '                 ${listaOrigenes.ESTE.toString()}00 m', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 14.0
                                ))
                              ]
                            )),
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '      Factor de Escala: ', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 14.0
                                )),
                                TextSpan( text: '       1.000000000', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff007FFF),
                                  fontSize: 14.0
                                ))
                              ]
                            )),
                            ),  
                            SizedBox(height: 80),
                            Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: (){
                                        print(listaOrigenes.NOMBRE);
                                        print(listaOrigenes.NORTE);
                                        print(listaOrigenes.ESTE);
                                        print(listaOrigenes.LATITUD);
                                        print(listaOrigenes.LONGITUD);

                                      }, 
                                      child: Icon(Icons.chevron_right, size: 50, color: Color(0xff007FFF))
                                      ),
                                      Text('Seleccionar', style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xff007FFF),
                                        fontSize: 14.0
                                ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
                }
                );
            }else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      )
      )
    
    // Planas cartesianas
    :SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          Text('Seleccione el Departamentos', style: TextStyle(
          fontFamily: 'Roboto',
          color: Color(0xff007FFF),
          fontSize: 16
          ),),
          Container(
            height: 300,
            width: 300,
            child: Scaffold(          
              body: FutureBuilder<List<departamentos>> (
                future: gestorMBDatabase.db.getDepartamentos(),
                builder: (BuildContext context, AsyncSnapshot<List<departamentos>> listaDep){
                  if(listaDep.hasData) {
                      return ListView.builder(
                        itemCount: listaDep.data.length,
                        itemBuilder: (BuildContext context, int index){
                          departamentos listaDepartamentos = listaDep.data[index];
                          return Dismissible(
                            key: UniqueKey(), 
                            child: ListTile(
                              title: Text(listaDepartamentos.NOMBRE),
                            ));
                        }
                        
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
        ],
      ),
    )
    )
    )

    ),
      
    );
  }
}