import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

Widget CardProyectos () {
  Container(
      child: Container(
      height: 500,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Container(
      child: Swiper(
      itemBuilder: (BuildContext context, int index) {
      return Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.black26,
      image: new DecorationImage(image: new AssetImage("assets/images/fondoblackbogota.jpg"), fit: BoxFit.cover,),
      ),
      child: Center(
      child: Column(
      children: <Widget>[
      Text('NombreProyecto', style: TextStyle(
      fontFamily: 'Roboto',
      color: Color(0xff007FFF),
       fontSize: 20.0,
      ),
      ),
      ],
      ),
      ),
      );
      },
      itemCount: 14,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: SwiperPagination(),
      ),
      ),
      ),
  );
}