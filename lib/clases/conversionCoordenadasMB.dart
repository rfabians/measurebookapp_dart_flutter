import 'dart:math' as m;

import 'package:measurebookapp/modelos/cartesianasCS.dart';
import 'package:measurebookapp/modelos/coordenadasCartesianas.dart';
import 'package:measurebookapp/modelos/coordenadasElipsoidales.dart';
import 'package:measurebookapp/modelos/coordenadasGeocenticas.dart';
import 'package:measurebookapp/modelos/coordenadasPlanasGauss.dart';
import 'package:measurebookapp/modelos/gaussCS.dart';
class ConversionCoordenadasMB {

// funciones de ayuda
double grados2Radianes(double grados) {
  double radianes = (grados*m.pi)/(180);
  return radianes;
}

double radianes2Grados(double radianes){ 
  double grados = (radianes*180)/(m.pi);
  return grados;
}

// Conversión de Coordenadas Geocentricas a Elipsoidales
CoordenadasElipsoidales geocentricas2Elipsoidales (CoordenadasGeocentricas coordenadasGeocentricas){
  //datos de Entrada
  double _X = coordenadasGeocentricas.x;
  double _Y = coordenadasGeocentricas.y;
  double _Z = coordenadasGeocentricas.z;

  // Variables para conversión.
  double _longitud = radianes2Grados(m.atan((_Y)/(_X)));
  double _a = 6378137.000;
  double _b = 6356752.31414;
  double _e1 = 0.00669438002290;
  double _e2 = 0.00673949677548;
  double _x2 = m.pow(_X, 2);
  double _y2 = m.pow(_Y, 2);
  double _v = (_Z*_a)/(m.sqrt(_x2+_y2)*_b);
  double _latitud = radianes2Grados(m.atan(
      (_Z+_e2*_b*m.pow(m.sin(_v),3))/(m.sqrt(_x2+_y2)-_e1*_a*m.pow(m.cos(_v),3))
      ));
  double _N = (_a)/(m.sqrt(1-_e1*m.pow(m.sin(grados2Radianes(_latitud)),2)));
  double _altura = ((m.sqrt(_x2+_y2))/(m.cos(grados2Radianes(_latitud))))-_N;
  CoordenadasElipsoidales _coordenadasElipsoidales = CoordenadasElipsoidales();
  _coordenadasElipsoidales.altitud = _altura;
  _coordenadasElipsoidales.latitud = _latitud;
  _coordenadasElipsoidales.longitud = _longitud;

  return _coordenadasElipsoidales;
}

// Conversión de Coordenadas Elipsoidales a Geocentricas

CoordenadasGeocentricas elipsoidales2Geocentricas (CoordenadasElipsoidales _coordenadasElipsoidales){
double _a = 6378137.000;
double _e1 = 0.00669438002290;
double _latitud = _coordenadasElipsoidales.latitud;
double _longitud = _coordenadasElipsoidales.longitud;
double _altura = _coordenadasElipsoidales.altitud;
double _N = (_a)/(m.sqrt(1-_e1*m.pow(m.sin(grados2Radianes(_latitud)),2)));
double _X = (_N+_altura)*m.cos(grados2Radianes(_latitud))*m.cos(grados2Radianes(_longitud));
double _Y = (_N+_altura)*m.cos(grados2Radianes(_latitud))*m.sin(grados2Radianes(_longitud));
double _Z = ((1-_e1)*_N+_altura)*m.sin(grados2Radianes(_latitud));
CoordenadasGeocentricas _coordenadasGeocentricas;
_coordenadasGeocentricas.x = _X;
_coordenadasGeocentricas.y = _Y;
_coordenadasGeocentricas.z = _Z;
return _coordenadasGeocentricas;
}

//Conversión de coordenadas Elipsoidales a Gauss
CoordenadasGauss elipsoidales2Gauss(CoordenadasElipsoidales _elipsoidales, GaussCS _gaussOrigen) {
  double _latitudPunto = _elipsoidales.latitud;
  double _longitudPunto = _elipsoidales.longitud;
  double _alturaPunto = _elipsoidales.altitud;
  // Constantes Elipsoide
  double _a = 6378137.000;
  double _b = 6356752.31414;
  double _e1 = 0.00669438002290;
  double _e2 = 0.00673949677548;
  double _latitudOrigen = _gaussOrigen.LATITUD;
  double _longitudOrigen = _gaussOrigen.LONGITUD;
  double _laRad = grados2Radianes(_latitudPunto);
  double _loRad = grados2Radianes(_longitudPunto);
  double _laORad = grados2Radianes(_latitudOrigen);
  double _loORad = grados2Radianes(_longitudOrigen);
  double _l = _loRad - _loORad;
  double _t = m.tan(_laRad);
  double _eta2 = _e2 * m.pow(m.cos(_laRad), 2);
  double _n = (_a - _b) / (_a + _b);
  double _sinLaRad = m.sin(_laRad);
  double _n1 = 1 - _e1 * m.pow(_sinLaRad, 2);
  double _N = _a / m.sqrt(_n1);
  double _A = (_a + _b) / 2 * (1 + m.pow(_n, 2) / 4 + m.pow(_n, 4) / 64);
  double _B = -(3 * _n / 2) + 9 * m.pow(_n, 3) / 16 - 3 * m.pow(_n, 5) / 32;
  double _C = 15 * m.pow(_n, 2) / 16 - 15 * m.pow(_n, 4) / 32;
  double _D = -(35 * m.pow(_n, 3) / 48) + 105 * m.pow(_n, 5) / 256;
  double _E = 315 * m.pow(_n, 4) / 512;
  double _arcoMP = _A * (_laRad + _B * m.sin(2 * _laRad) + _C * m.sin(4 * _laRad) + _D * m.sin(6 * _laRad) + _E * m.sin(8 * _laRad));
  double _arcoMO = _A * (_laORad + _B * m.sin(2 * _laORad) + _C * m.sin(4 * _laORad) + _D * m.sin(6 * _laORad) + _E * m.sin(8 * _laORad));
  double _Darcos = _arcoMP - _arcoMO;
  double _N1 = _t * _N / 2 * m.pow(_l, 2) * m.pow(m.cos(_laRad), 2);
  double _N2 = _t * _N / 24 * m.pow(m.cos(_laRad), 4) * (5 - m.pow(_t, 2) + 9 * _eta2 + 4 * m.pow(_eta2, 2)) * m.pow(_l, 4);
  double _N3 = _t * _N / 720 * m.pow(m.cos(_laRad), 6) * (61 - 58 * m.pow(_t, 2) + m.pow(_t, 4) + 270 * _eta2 - 330 * _eta2 * m.pow(_t, 2)) * m.pow(_l, 6);
  double _N4 = _t * _N / 40320 * m.pow(m.cos(_laRad), 8) * (1385 - 3111 * m.pow(_t, 2) + 543 * m.pow(_t, 4) - m.pow(_t, 6)) * m.pow(_l, 8);
  double _norte = 1000000 + _Darcos + _N1 + _N2 + _N3 + _N4;
  double _E1 = _N * _l * m.cos(_laRad);
  double _E2 = _N / 6 * m.pow(m.cos(_laRad), 3) * (1 - m.pow(_t, 2) + _eta2) * m.pow(_l, 3);
  double _E3 = _N / 120 * m.pow(m.cos(_laRad), 5) * (5 - 18 * m.pow(_t, 2) + m.pow(_t, 4) + 14 * _eta2 - 58 * m.pow(_t, 2) * _eta2) * m.pow(_l, 5);
  double _E4 = _N / 5040 * m.pow(m.cos(_laRad), 7) * (61 - 479 * m.pow(_t, 2) + 179 * m.pow(_t, 4) - m.pow(_t, 6)) * m.pow(_l, 7);
  double _east = 1000000 + _E1 + _E2 + _E3 + _E4;
  CoordenadasGauss coordenadasGauss = CoordenadasGauss();
  coordenadasGauss.norte = _norte;
  coordenadasGauss.este = _east;
  coordenadasGauss.altura = _alturaPunto;
  return coordenadasGauss;
}
// Coversión de coordenadas Gauss a Elipsoidales
CoordenadasElipsoidales gauss2Elipsoidales (GaussCS _origenGauss, CoordenadasGauss _gauss) {
  double _alturaPunto = _gauss.altura;
  double _No = _gauss.norte;
  double _e2 = _gauss.este;
  double _X = 6378137.000;
  double _Y = 6356752.31414;
  double _laIni = 0.00669438002290;
  double _V = 0.00673949677548;
  double _gNO = _origenGauss.N0;
  double _a = _No - _gNO;
  double _A1 = _e2 - 1000000.0;
  double _A2 = (_X - _Y) / (_X + _Y);
  double _J2 = (_X + _Y) / 2 * (1 + m.pow(_A2, 2) / 4 + m.pow(_A2, 4) / 64);
  double _J4 = 3 * _A2 / 2 - 27 * m.pow(_A2, 3) / 32 + 269 * m.pow(_A2, 5) / 512;
  double _J6 = 21 * m.pow(_A2, 2) / 16 - 55 * m.pow(_A2, 4) / 32;
  double _al = 151 * m.pow(_A2, 3) / 96 - 417 * m.pow(_A2, 5) / 128;
  double _be = 1097 * m.pow(_A2, 4) / 512;
  double _y = _a / _J2 + _J4 * m.sin(2 * _a / _J2) + _J6 * m.sin(4 * _a / _J2) + _al * m.sin(6 * _a / _J2) + _be * m.sin(8 * _a / _J2);
  double _B0 = m.tan(_y);
  double _b = _V * m.pow(m.cos(_y), 2);
  double _C = _X / m.sqrt(1 - _laIni * m.pow(m.sin(_y), 2));
  double _E = _B0 / (2 * m.pow(_C, 2)) * (-1 - _b) * m.pow(_A1, 2);
  double _N = _B0 / (24 * m.pow(_C, 4)) * (5 + 3 * m.pow(_B0, 2) + 6 * _b - 6 * m.pow(_B0, 2) * _b - 3 * m.pow(_b, 2) - 9 * m.pow(_B0, 2) * m.pow(_b, 2)) * m.pow(_A1, 4);
  double _sene = _B0 / (720 * m.pow(_C, 6)) * (-61 - 90 * m.pow(_B0, 2) - 45 * m.pow(_B0, 4) - 107 * _b + 162 * m.pow(_B0, 2) * _b + 45 * m.pow(_B0, 4) * _b) * m.pow(_A1, 6);
  double _di = _B0 / (40320 * m.pow(_C, 8)) * (1385 + 3633 * m.pow(_B0, 2) + 4096 * m.pow(_B0, 4) + 1575 * m.pow(_B0, 6)) * m.pow(_A1, 8);
  double _T = _y + _E + _N + _sene + _di;
  double _latitude = radianes2Grados(_T);
  double _loIni = 1 / (_C * m.cos(_y)) * _A1;
  double _lo = 1 / (6 * m.pow(_C, 3) * m.cos(_y)) * (-1 - 2 * m.pow(_B0, 2) - _b) * m.pow(_A1, 3);
  double _lo3 = 1 / (120 * m.pow(_C, 5) * m.cos(_y)) * (5 - 28 * m.pow(_B0, 2) + 24 * m.pow(_B0, 4) + 6 * _b + 8 * m.pow(_B0, 2) * _b) * m.pow(_A1, 5);
  double _lo4 = 1 / (5040 * m.pow(_C, 7) * m.cos(_y)) * (-61 - 662 * m.pow(_B0, 2) - 1320 * m.pow(_B0, 4) - 720 * m.pow(_B0, 6)) * m.pow(_A1, 7);
  double _lon = grados2Radianes(_origenGauss.LONGITUD) + _loIni + _lo + _lo3 + _lo4;
  double _longitude = radianes2Grados(_lon);
  CoordenadasElipsoidales elipCoor = CoordenadasElipsoidales();
  elipCoor.longitud = _longitude;
  elipCoor.latitud = _latitude;
  elipCoor.altitud= _alturaPunto;

  return elipCoor;
}
// Conversión de coordenadas Elipsoidales a planas Cartesianas

CoordenadasCartesianas elipsoidales2Cartesianas (CartesianasCS _cartesianasO, CoordenadasElipsoidales _coordenadasElipsoidales) {
  double _la = _coordenadasElipsoidales.latitud;
  double _lo = _coordenadasElipsoidales.longitud;
  double _alturaP = _coordenadasElipsoidales.altitud;
  double _a = 6378137.000;
  double _e1 = 0.00669438002290;
  double _laORad = grados2Radianes(_cartesianasO.LATITUD);
  double _loORad = grados2Radianes(_cartesianasO.LONGITUD);
  double _laRad = grados2Radianes(_la);
  double _loRad = grados2Radianes(_lo);
  double _pP = _cartesianasO.PLANO_PROY;
  double _deltaLa = _laRad - _laORad;
  double _deltaLo = _loRad - _loORad;
  double _laM = (_laORad + _laRad) / 2;
  double _sinLaRad = m.sin(_laRad);
  double _n1 = 1 - _e1 * m.pow(_sinLaRad, 2);
  double _N = _a / m.sqrt(_n1);
  double _sinLaORad = m.sin(_laORad);
  double _no = 1 - _e1 * m.pow(_sinLaORad, 2);
  double _No = _a / m.sqrt(_no);
  double _sinLaMRad = m.sin(_laM);
  double _n3 = 1 - _e1 * m.pow(_sinLaMRad, 2);
  double _M = _a * (1 - _e1) / m.pow(_n3, 1.5);
  double _Mo = _a * (1 - _e1) / m.pow(_no, 1.5);
  double _N1 = _deltaLa + m.tan(_laORad) * m.pow(_deltaLo, 2) * m.pow(_N, 2) * m.pow(m.cos(_laRad), 2) / (2 * _Mo * _No);
  double _N2 = 1 + _pP / _Mo;
  double _north = _Mo * _N1 * _N2 + 109320.965;
  double _E1 = _deltaLo * _N * m.cos(_laRad);
  double _E2 = 1 + _pP / _No;
  double _east = _E1 * _E2 + 92334.879;

  CoordenadasCartesianas _coordenadasCartesianas = CoordenadasCartesianas();
  _coordenadasCartesianas.norte =  _north;
  _coordenadasCartesianas.este = _east;
  _coordenadasCartesianas.altura = _alturaP;

  return _coordenadasCartesianas;
}

// conversion de coordenadas Elipsoidales a Planas Cartesianas

CoordenadasElipsoidales cartesianas2Elipoidales(CoordenadasCartesianas _coordenadasCartesianas, CartesianasCS _cartesianasCS) {
  
  double _No = _coordenadasCartesianas.norte;
  double _e2 = _coordenadasCartesianas.este;
  double _alturaPunto = _coordenadasCartesianas.altura;
  double _X = 6378137.000;
  double _Y = 6356752.31414;
  double _laIni = 0.00669438002290;
  double _V = 0.00673949677548;
  double _a = grados2Radianes(_cartesianasCS.LATITUD);
  double _A1 = grados2Radianes(_cartesianasCS.LONGITUD);
  double _A2 = _cartesianasCS.PLANO_PROY;
  //Falso Norte
  double _J2 = _No - _cartesianasCS.NORTE;
  //Falso Este
  double _J4 = _e2 - _cartesianasCS.ESTE;
  double _J6 = m.sin(_a);
  double _al = 1 - _laIni * m.pow(_J6, 2);
  double _be = _X / m.sqrt(_al);
  double _y = _X * (1 - _laIni) / m.pow(_al, 1.5);
  double _B0 = _J2 / ((1 + _A2 / (_X * (1 - _laIni))) * _y);
  double _b = m.tan(_a) / (2 * _be * _y);
  double _C = m.pow(_J4 / (1 + _A2 / _X), 2);
  double _E = _B0 - _b * _C;
  double _N = _a + _E;
  double _latitude = _N * 57.29577951308232;
  double _sinLaRad = m.sin(_N);
  double _n2 = 1 - _laIni * m.pow(_sinLaRad, 2);
  double _Np = _X / m.sqrt(_n2);
  double _loIni = _J4 / (_Np * m.cos(_N) * (1 + _A2 / _X));
  double _lo = _A1 + _loIni;
  double _lon = _lo * 57.29577951308232;
  CoordenadasElipsoidales _coordenadasElipsoidales = CoordenadasElipsoidales();
  _coordenadasElipsoidales.latitud = _latitude;
  _coordenadasElipsoidales.longitud = _lon;
  _coordenadasElipsoidales.altitud = _alturaPunto;
  return _coordenadasElipsoidales;    
}
}