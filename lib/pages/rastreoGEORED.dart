 import 'package:flutter/material.dart';

 class RastreoGEORED extends StatefulWidget {
   RastreoGEORED({Key key}) : super(key: key);
 
   @override
   _RastreoGEOREDState createState() => _RastreoGEOREDState();
 }
 
 class _RastreoGEOREDState extends State<RastreoGEORED> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: Center(
           child: Text('GEORED TIEMPOS RASTREO'),
         )
         ),
    );
   }
 }