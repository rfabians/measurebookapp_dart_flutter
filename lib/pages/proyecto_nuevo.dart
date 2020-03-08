import 'package:flutter/material.dart';
import 'package:measurebookapp/clases/database.dart';
import 'package:measurebookapp/modelos/prueba.dart';
import 'package:measurebookapp/clases/database.dart';

class NuevoProyecto extends StatelessWidget {


// Git
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      FutureBuilder<List<consultaMunicipios>> (
        future: gestorMBDatabase.db.getMunicipios(),
        builder: (BuildContext context, AsyncSnapshot<List<consultaMunicipios>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  consultaMunicipios item = snapshot.data[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.blueGrey,
                    ),
                    onDismissed: (diretion){
                      print(gestorMBDatabase.db.getMunicipios());
                    },
                    child: ListTile (
                      title: Text(item.NOMBRE),

                    ),
                  );
                });
          } else {
            return Center(child:  CircularProgressIndicator());
          }
        },
      )
    );
  }
}