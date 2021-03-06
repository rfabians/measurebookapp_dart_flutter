import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

class Formatos {
  Future<String> descripcionPunto() async {
    String descripcionHTML = '''
        <!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Web 1920 – 1</title>
<style id="applicationStylesheet" type="text/css">
	.mediaViewInfo {
		--web-view-name: Web 1920 – 1;
		--web-view-id: Web_1920__1;
		--web-scale-on-resize: true;
		--web-enable-deep-linking: true;
	}
	:root {
		--web-view-ids: Web_1920__1;
	}
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		border: none;
	}
	#Web_1920__1 {
		position: absolute;
		width: 1200px;
		height: 1550px;
		background-color: rgba(255,255,255,1);
		overflow: hidden;
		--web-view-name: Web 1920 – 1;
		--web-view-id: Web_1920__1;
		--web-scale-on-resize: true;
		--web-enable-deep-linking: true;
	}
	#Componente_1__1 {
		position: absolute;
		width: 998px;
		height: 1485px;
		left: 41px;
		top: 57px;
		overflow: visible;
	}
	#Rectngulo_21 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_21 {
		position: absolute;
		overflow: visible;
		width: 416px;
		height: 675px;
		left: 581px;
		top: 507.68px;
	}
	#Rectngulo_1 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_1 {
		position: absolute;
		overflow: visible;
		width: 998px;
		height: 127px;
		left: 0px;
		top: 0px;
	}
	#logo {
		position: absolute;
		width: 180px;
		height: 63px;
		left: 25px;
		top: 32px;
		overflow: visible;
	}
	#Lnea_1 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_1 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 126px;
		left: 221.162px;
		top: 0.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#HOJA_DE_CAMPO_PARA_OBSERVACION {
		left: 264.238px;
		top: 52px;
		position: absolute;
		overflow: visible;
		width: 419px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 20px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_2 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_2 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 126px;
		left: 741.895px;
		top: 0.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#fecha {
		left: 846px;
		top: 14px;
		position: absolute;
		overflow: visible;
		width: 51px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#AO-MES-DA {
		left: 828px;
		top: 53px;
		position: absolute;
		overflow: visible;
		width: 87px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#ID2020-05-25 {
		left: 833px;
		top: 92px;
		position: absolute;
		overflow: visible;
		width: 77px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_3 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_3 {
		overflow: visible;
		position: absolute;
		width: 256px;
		height: 1px;
		left: 741.5px;
		top: 43.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_4 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_4 {
		overflow: visible;
		position: absolute;
		width: 256px;
		height: 1px;
		left: 741.5px;
		top: 83.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Rectngulo_2 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_2 {
		position: absolute;
		overflow: visible;
		width: 998px;
		height: 104px;
		left: 0px;
		top: 132px;
	}
	#Lnea_5 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_5 {
		overflow: visible;
		position: absolute;
		width: 741px;
		height: 1px;
		left: 0.5px;
		top: 182.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura {
		left: 69px;
		top: 147px;
		position: absolute;
		overflow: visible;
		width: 66px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_v {
		left: 238.37px;
		top: 145px;
		position: absolute;
		overflow: visible;
		width: 478px;
		height: 34px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_w {
		left: 60px;
		top: 198px;
		position: absolute;
		overflow: visible;
		width: 89px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_x {
		left: 231.88px;
		top: 200px;
		position: absolute;
		overflow: visible;
		width: 493px;
		height: 21px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_6 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_6 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 126px;
		left: 221.162px;
		top: 132.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_7 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_7 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 126px;
		left: 741.895px;
		top: 132.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_ {
		left: 749.252px;
		top: 143px;
		position: absolute;
		overflow: visible;
		width: 58px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ba {
		left: 754px;
		top: 166px;
		position: absolute;
		overflow: visible;
		width: 233px;
		height: 61px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_3 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_3 {
		position: absolute;
		overflow: visible;
		width: 577px;
		height: 111px;
		left: 0px;
		top: 239.867px;
	}
	#Nomenclatura_bb {
		left: 210.972px;
		top: 247px;
		position: absolute;
		overflow: visible;
		width: 191px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_8 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_8 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 274.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_bc {
		left: 26px;
		top: 299.39px;
		position: absolute;
		overflow: visible;
		width: 53px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Rectngulo_4 {
		fill: rgba(255,255,255,1);
		stroke: rgba(112,112,112,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_4 {
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 34px;
		left: 84px;
		top: 293.065px;
	}
	#Nomenclatura_bd {
		left: 198.132px;
		top: 299.39px;
		position: absolute;
		overflow: visible;
		width: 71px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Rectngulo_5 {
		fill: rgba(255,255,255,1);
		stroke: rgba(112,112,112,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_5 {
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 34px;
		left: 278.064px;
		top: 293.065px;
	}
	#Nomenclatura_be {
		left: 371.049px;
		top: 299.39px;
		position: absolute;
		overflow: visible;
		width: 101px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Rectngulo_6 {
		fill: rgba(255,255,255,1);
		stroke: rgba(112,112,112,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_6 {
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 34px;
		left: 481.424px;
		top: 293.065px;
	}
	#Rectngulo_7 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_7 {
		position: absolute;
		overflow: visible;
		width: 417px;
		height: 111px;
		left: 581px;
		top: 239.867px;
	}
	#Lnea_9 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_9 {
		overflow: visible;
		position: absolute;
		width: 416px;
		height: 1px;
		left: 581.5px;
		top: 274.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_bf {
		left: 726px;
		top: 246px;
		position: absolute;
		overflow: visible;
		width: 116px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_bg {
		left: 632.135px;
		top: 302.046px;
		position: absolute;
		overflow: visible;
		width: 33px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Rectngulo_8 {
		fill: rgba(255,255,255,1);
		stroke: rgba(112,112,112,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_8 {
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 34px;
		left: 681.391px;
		top: 292.718px;
	}
	#Nomenclatura_bh {
		left: 788px;
		top: 299.161px;
		position: absolute;
		overflow: visible;
		width: 35px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Rectngulo_9 {
		fill: rgba(255,255,255,1);
		stroke: rgba(112,112,112,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_9 {
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 34px;
		left: 851px;
		top: 292.834px;
	}
	#Rectngulo_10 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_10 {
		position: absolute;
		overflow: visible;
		width: 577px;
		height: 148px;
		left: 0px;
		top: 355.68px;
	}
	#Nomenclatura_bj {
		left: 244.237px;
		top: 360.085px;
		position: absolute;
		overflow: visible;
		width: 58px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_10 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_10 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 383.255px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_11 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_11 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 407.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_bm {
		left: 169px;
		top: 386.694px;
		position: absolute;
		overflow: visible;
		width: 39px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_bn {
		left: 25px;
		top: 422.305px;
		position: absolute;
		overflow: visible;
		width: 55px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_bo {
		left: 327.18px;
		top: 386.694px;
		position: absolute;
		overflow: visible;
		width: 47px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_bp {
		left: 486.546px;
		top: 386.694px;
		position: absolute;
		overflow: visible;
		width: 37px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Lnea_12 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_12 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 454.046px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_br {
		left: 31px;
		top: 465.604px;
		position: absolute;
		overflow: visible;
		width: 43px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_13 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_13 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 120px;
		left: 274.071px;
		top: 383.114px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_14 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_14 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 120px;
		left: 437.046px;
		top: 383.114px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_15 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_15 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 120px;
		left: 108.5px;
		top: 383.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Rectngulo_11 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_11 {
		position: absolute;
		overflow: visible;
		width: 417px;
		height: 149px;
		left: 581px;
		top: 354.68px;
	}
	#Nomenclatura_bw {
		left: 736px;
		top: 362.429px;
		position: absolute;
		overflow: visible;
		width: 86px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_16 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_16 {
		overflow: visible;
		position: absolute;
		width: 416px;
		height: 1px;
		left: 581.5px;
		top: 388.369px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_by {
		left: 591.628px;
		top: 398.694px;
		position: absolute;
		overflow: visible;
		width: 55px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_bz {
		left: 590px;
		top: 436.468px;
		position: absolute;
		overflow: visible;
		width: 394px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_12 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_12 {
		position: absolute;
		overflow: visible;
		width: 577px;
		height: 675px;
		left: 0px;
		top: 507.942px;
	}
	#Lnea_17 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_17 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 542.043px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_b {
		left: 162.715px;
		top: 513.637px;
		position: absolute;
		overflow: visible;
		width: 326px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ca {
		left: 29px;
		top: 550.022px;
		position: absolute;
		overflow: visible;
		width: 31px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_cb {
		left: 94px;
		top: 550.022px;
		position: absolute;
		overflow: visible;
		width: 97px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_cc {
		left: 218.438px;
		top: 550.022px;
		position: absolute;
		overflow: visible;
		width: 39px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_cd {
		left: 290.018px;
		top: 550.022px;
		position: absolute;
		overflow: visible;
		width: 55px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_ce {
		left: 441.892px;
		top: 542.284px;
		position: absolute;
		overflow: visible;
		width: 69px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_cf {
		left: 392.283px;
		top: 559.646px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_cg {
		left: 467.618px;
		top: 559.646px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_ch {
		left: 529.582px;
		top: 559.646px;
		position: absolute;
		overflow: visible;
		width: 27px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Lnea_18 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_18 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 577.599px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Rectngulo_13 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_13 {
		position: absolute;
		overflow: visible;
		width: 998px;
		height: 187px;
		left: 0px;
		top: 1187px;
	}
	#Rectngulo_14 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_14 {
		position: absolute;
		overflow: visible;
		width: 998px;
		height: 107px;
		left: 0px;
		top: 1378px;
	}
	#Trazado_2 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_2 {
		overflow: visible;
		position: absolute;
		width: 4.241px;
		height: 640.516px;
		left: 82.274px;
		top: 542.043px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_3 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_3 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 1px;
		left: 277.412px;
		top: 1245.078px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_4 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_4 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 1px;
		left: 379.683px;
		top: 1245.141px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_23 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_23 {
		overflow: visible;
		position: absolute;
		width: 216.73px;
		height: 1px;
		left: 359.77px;
		top: 559.434px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_5 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_5 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 1px;
		left: 455.869px;
		top: 1243.568px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_6 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_6 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 1px;
		left: 533.091px;
		top: 1243.505px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_26 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_26 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 617.494px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_27 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_27 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 657.39px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_28 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_28 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 697.285px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_29 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_29 {
		overflow: visible;
		position: absolute;
		width: 576.003px;
		height: 2.681px;
		left: 0.5px;
		top: 735.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_30 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_30 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 777.076px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_31 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_31 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 816.972px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_32 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_32 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 856.867px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_33 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_33 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 896.763px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_34 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_34 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 936.658px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_35 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_35 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 976.554px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_36 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_36 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 1016.449px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_37 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_37 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 1056.345px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_38 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_38 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 1096.24px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_39 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_39 {
		overflow: visible;
		position: absolute;
		width: 576px;
		height: 1px;
		left: 0.5px;
		top: 1136.136px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_cy {
		left: 687px;
		top: 512.637px;
		position: absolute;
		overflow: visible;
		width: 164px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_41 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_41 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 533.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Imagen_1 {
		position: absolute;
		width: 137px;
		height: 133px;
		left: 858px;
		top: 561.141px;
		overflow: visible;
	}
	#Lnea_42 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_42 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 554.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_c {
		left: 778.81px;
		top: 534.513px;
		position: absolute;
		overflow: visible;
		width: 49px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_da {
		left: 135px;
		top: 420.468px;
		position: absolute;
		overflow: visible;
		width: 109px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_db {
		left: 606.284px;
		top: 583.436px;
		position: absolute;
		overflow: visible;
		width: 31px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dc {
		left: 606.483px;
		top: 644.524px;
		position: absolute;
		overflow: visible;
		width: 29px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Imagen_4 {
		position: absolute;
		width: 61px;
		height: 125px;
		left: 896px;
		top: 730.89px;
		overflow: visible;
	}
	#Lnea_45 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_45 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 697.285px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_46 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_46 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 717.676px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dd {
		left: 783.008px;
		top: 698.529px;
		position: absolute;
		overflow: visible;
		width: 45px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Lnea_47 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_47 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 856.867px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_48 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_48 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 877.258px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_de {
		left: 780.81px;
		top: 857.89px;
		position: absolute;
		overflow: visible;
		width: 49px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Imagen_5 {
		position: absolute;
		width: 112px;
		height: 129px;
		left: 871px;
		top: 884.136px;
		overflow: visible;
	}
	#Lnea_50 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_50 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 652.075px;
		top: 600.649px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_df {
		left: 788px;
		top: 583.436px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Lnea_51 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_51 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 650.419px;
		top: 660.049px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dh {
		left: 786px;
		top: 642.753px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Nomenclatura_di {
		left: 606.284px;
		top: 741.025px;
		position: absolute;
		overflow: visible;
		width: 31px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dj {
		left: 606.483px;
		top: 802.113px;
		position: absolute;
		overflow: visible;
		width: 29px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_52 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_52 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 652.075px;
		top: 758.458px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dl {
		left: 788px;
		top: 741.025px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Lnea_53 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_53 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 650.419px;
		top: 817.858px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dn {
		left: 786px;
		top: 800.343px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Nomenclatura_do {
		left: 606.284px;
		top: 909.239px;
		position: absolute;
		overflow: visible;
		width: 31px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dp {
		left: 606.483px;
		top: 970.327px;
		position: absolute;
		overflow: visible;
		width: 29px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_54 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_54 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 652.075px;
		top: 926.906px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dr {
		left: 788px;
		top: 909.239px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Lnea_55 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_55 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 650.419px;
		top: 986.306px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dt {
		left: 786px;
		top: 968.556px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Lnea_56 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_56 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 1016.449px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dv {
		left: 791.785px;
		top: 1017.25px;
		position: absolute;
		overflow: visible;
		width: 29px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Lnea_58 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_58 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 1036.84px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_dx {
		left: 606.284px;
		top: 1043.319px;
		position: absolute;
		overflow: visible;
		width: 31px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dy {
		left: 606.18px;
		top: 1073.274px;
		position: absolute;
		overflow: visible;
		width: 29px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_59 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_59 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 652.075px;
		top: 1062.19px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_d {
		left: 788px;
		top: 1043.319px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Lnea_60 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_60 {
		overflow: visible;
		position: absolute;
		width: 165px;
		height: 1px;
		left: 652.075px;
		top: 1090.425px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_ea {
		left: 788px;
		top: 1070.503px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: lowercase;
	}
	#Lnea_62 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_62 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 1103.022px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_eb {
		left: 720px;
		top: 1103.655px;
		position: absolute;
		overflow: visible;
		width: 109px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Lnea_63 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_63 {
		overflow: visible;
		position: absolute;
		width: 415px;
		height: 1px;
		left: 581.5px;
		top: 1123.413px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_ec {
		left: 596.14px;
		top: 1143.61px;
		position: absolute;
		overflow: visible;
		width: 53px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ed {
		left: 718.679px;
		top: 1144.61px;
		position: absolute;
		overflow: visible;
		width: 45px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ee {
		left: 830px;
		top: 1146.61px;
		position: absolute;
		overflow: visible;
		width: 101px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_16 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_16 {
		position: absolute;
		overflow: visible;
		width: 45px;
		height: 25px;
		left: 657.165px;
		top: 1141.309px;
	}
	#Rectngulo_17 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_17 {
		position: absolute;
		overflow: visible;
		width: 45px;
		height: 25px;
		left: 769.728px;
		top: 1141.309px;
	}
	#Rectngulo_18 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_18 {
		position: absolute;
		overflow: visible;
		width: 45px;
		height: 25px;
		left: 938px;
		top: 1141.309px;
	}
	#Nomenclatura_ef {
		left: 5px;
		top: 1207px;
		position: absolute;
		overflow: visible;
		width: 191px;
		height: 25px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_eg {
		left: 23px;
		top: 1391px;
		position: absolute;
		overflow: visible;
		width: 135px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_64 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_64 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 186px;
		left: 205.5px;
		top: 1187.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_eh {
		left: 237.972px;
		top: 1196px;
		position: absolute;
		overflow: visible;
		width: 237px;
		height: 21px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ei {
		left: 543.269px;
		top: 1196px;
		position: absolute;
		overflow: visible;
		width: 260px;
		height: 21px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ej {
		left: 828px;
		top: 1211px;
		position: absolute;
		overflow: visible;
		width: 154px;
		height: 21px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_65 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_65 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 185.73px;
		left: 809.5px;
		top: 1187.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_1 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_1 {
		overflow: visible;
		position: absolute;
		width: 997.342px;
		height: 1.5px;
		left: 0.5px;
		top: 1251.564px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_67 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_67 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 185.73px;
		left: 527.083px;
		top: 1187.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_68 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_68 {
		overflow: visible;
		position: absolute;
		width: 997px;
		height: 1px;
		left: 0.5px;
		top: 1312.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_em {
		left: 55px;
		top: 1274px;
		position: absolute;
		overflow: visible;
		width: 96px;
		height: 21px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_en {
		left: 58px;
		top: 1334px;
		position: absolute;
		overflow: visible;
		width: 90px;
		height: 21px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Lnea_69 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_69 {
		overflow: visible;
		position: absolute;
		width: 604px;
		height: 1px;
		left: 205.5px;
		top: 1220.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_ep {
		left: 238.306px;
		top: 1226px;
		position: absolute;
		overflow: visible;
		width: 20px;
		height: 21px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_70 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_70 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 152px;
		left: 286.037px;
		top: 1221.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_71 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_71 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 152px;
		left: 369.933px;
		top: 1221.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_72 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_72 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 122px;
		left: 453.83px;
		top: 1251.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_et {
		left: 318.228px;
		top: 1226px;
		position: absolute;
		overflow: visible;
		width: 17px;
		height: 21px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_eu {
		left: 407.841px;
		top: 1226px;
		position: absolute;
		overflow: visible;
		width: 18px;
		height: 21px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ev {
		left: 565.285px;
		top: 1226px;
		position: absolute;
		overflow: visible;
		width: 20px;
		height: 21px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Lnea_73 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_73 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 152px;
		left: 622.805px;
		top: 1221.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Lnea_74 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_74 {
		overflow: visible;
		position: absolute;
		width: 1px;
		height: 152px;
		left: 730.486px;
		top: 1221.5px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Nomenclatura_ey {
		left: 667.922px;
		top: 1226px;
		position: absolute;
		overflow: visible;
		width: 17px;
		height: 21px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ez {
		left: 763.08px;
		top: 1226px;
		position: absolute;
		overflow: visible;
		width: 18px;
		height: 21px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_e {
		left: 458.684px;
		top: 1270px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_fa {
		left: 458.684px;
		top: 1334px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Rectngulo_19 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_19 {
		position: absolute;
		overflow: visible;
		width: 28px;
		height: 25px;
		left: 480.332px;
		top: 1270px;
	}
	#Rectngulo_20 {
		fill: rgba(255,255,255,1);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_20 {
		position: absolute;
		overflow: visible;
		width: 28px;
		height: 25px;
		left: 480.332px;
		top: 1334px;
	}
	#Nomenclatura_fb {
		left: 511.445px;
		top: 1270px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#Nomenclatura_fc {
		left: 511.445px;
		top: 1334px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: capitalize;
	}
	#X {
		left: 105px;
		top: 299.551px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
	}
	#X_e {
		left: 299.929px;
		top: 299.551px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
	}
	#X_fa {
		left: 503.379px;
		top: 299.551px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
	}
	#X_fb {
		left: 702.872px;
		top: 298.551px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
	}
	#X_fc {
		left: 873px;
		top: 299.551px;
		position: absolute;
		overflow: visible;
		width: 11px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
	}
	#Nomenclatura_fd {
		left: 135px;
		top: 466.302px;
		position: absolute;
		overflow: visible;
		width: 109px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fe {
		left: 296.911px;
		top: 418.698px;
		position: absolute;
		overflow: visible;
		width: 109px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ff {
		left: 297.736px;
		top: 466.302px;
		position: absolute;
		overflow: visible;
		width: 109px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fg {
		left: 450.849px;
		top: 420.534px;
		position: absolute;
		overflow: visible;
		width: 109px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fh {
		left: 449.849px;
		top: 466.374px;
		position: absolute;
		overflow: visible;
		width: 109px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fi {
		left: 654.686px;
		top: 579.667px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fj {
		left: 654.686px;
		top: 635.421px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fk {
		left: 654.686px;
		top: 735.425px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fl {
		left: 654.686px;
		top: 792.949px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fm {
		left: 654.686px;
		top: 904.458px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fn {
		left: 654.686px;
		top: 962.867px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_2 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 6px;
		top: 588.656px;
		overflow: visible;
	}
	#Grupo_1 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_fo {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fp {
		left: 97px;
		top: 588.656px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fq {
		left: 205.398px;
		top: 588.656px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fr {
		left: 290.067px;
		top: 586.885px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fs {
		left: 373.736px;
		top: 588.656px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ft {
		left: 449.964px;
		top: 588.656px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fu {
		left: 517.883px;
		top: 588.656px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fv {
		left: 97px;
		top: 628.489px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fw {
		left: 205.398px;
		top: 628.489px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fx {
		left: 290.067px;
		top: 626.719px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fy {
		left: 373.736px;
		top: 628.489px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_fz {
		left: 449.964px;
		top: 628.489px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_f {
		left: 517.883px;
		top: 628.489px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ga {
		left: 97px;
		top: 668.323px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gb {
		left: 205.398px;
		top: 668.323px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gc {
		left: 290.067px;
		top: 666.553px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gd {
		left: 373.736px;
		top: 668.323px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ge {
		left: 449.964px;
		top: 668.323px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gf {
		left: 517.883px;
		top: 668.323px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gg {
		left: 97px;
		top: 709.042px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gh {
		left: 205.398px;
		top: 709.042px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gi {
		left: 290.067px;
		top: 707.272px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gj {
		left: 373.736px;
		top: 709.042px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gk {
		left: 449.964px;
		top: 709.042px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gl {
		left: 517.883px;
		top: 709.042px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gm {
		left: 97px;
		top: 753.761px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gn {
		left: 205.398px;
		top: 749.761px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_go {
		left: 290.067px;
		top: 747.991px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gp {
		left: 373.736px;
		top: 749.761px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gq {
		left: 449.964px;
		top: 749.761px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gr {
		left: 517.883px;
		top: 749.761px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gs {
		left: 97px;
		top: 791.825px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gt {
		left: 205.398px;
		top: 787.825px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gu {
		left: 290.067px;
		top: 786.054px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gv {
		left: 373.736px;
		top: 787.825px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gw {
		left: 449.964px;
		top: 787.825px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gx {
		left: 517.883px;
		top: 787.825px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gy {
		left: 97px;
		top: 830.773px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_gz {
		left: 205.398px;
		top: 826.773px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_g {
		left: 290.067px;
		top: 825.003px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ha {
		left: 373.736px;
		top: 826.773px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hb {
		left: 449.964px;
		top: 826.773px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hc {
		left: 517.883px;
		top: 826.773px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hd {
		left: 97px;
		top: 871.492px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_he {
		left: 205.398px;
		top: 867.492px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hf {
		left: 290.067px;
		top: 865.722px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hg {
		left: 373.736px;
		top: 867.492px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hh {
		left: 449.964px;
		top: 867.492px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hi {
		left: 517.883px;
		top: 867.492px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hj {
		left: 97px;
		top: 907.326px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hk {
		left: 205.398px;
		top: 907.326px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hl {
		left: 290.067px;
		top: 905.556px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hm {
		left: 373.736px;
		top: 907.326px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hn {
		left: 449.964px;
		top: 907.326px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ho {
		left: 517.883px;
		top: 907.326px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hp {
		left: 97px;
		top: 947.16px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hq {
		left: 205.398px;
		top: 947.16px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hr {
		left: 290.067px;
		top: 945.39px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hs {
		left: 373.736px;
		top: 947.16px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ht {
		left: 449.964px;
		top: 947.16px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hu {
		left: 517.883px;
		top: 947.16px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hv {
		left: 97px;
		top: 986.994px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hw {
		left: 205.398px;
		top: 986.994px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hx {
		left: 290.067px;
		top: 985.224px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hy {
		left: 373.736px;
		top: 986.994px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_hz {
		left: 449.964px;
		top: 986.994px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_h {
		left: 517.883px;
		top: 986.994px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ia {
		left: 97px;
		top: 1025.943px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ib {
		left: 205.398px;
		top: 1025.943px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ic {
		left: 290.067px;
		top: 1024.172px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_id {
		left: 373.736px;
		top: 1025.943px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ie {
		left: 449.964px;
		top: 1025.943px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_if {
		left: 517.883px;
		top: 1025.943px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ig {
		left: 97px;
		top: 1064.006px;
		position: absolute;
		overflow: visible;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ih {
		left: 205.398px;
		top: 1064.006px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ii {
		left: 290.067px;
		top: 1062.236px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ij {
		left: 373.736px;
		top: 1064.006px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ik {
		left: 449.964px;
		top: 1064.006px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_il {
		left: 517.883px;
		top: 1064.006px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_im {
		left: 97px;
		top: 1104.725px;
		position: absolute;
		overflow: hidden;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_in {
		left: 205.398px;
		top: 1104.725px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_io {
		left: 290.067px;
		top: 1102.955px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ip {
		left: 373.736px;
		top: 1104.725px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_iq {
		left: 449.964px;
		top: 1104.725px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ir {
		left: 517.883px;
		top: 1104.725px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_is {
		left: 97px;
		top: 1145.444px;
		position: absolute;
		overflow: hidden;
		width: 83px;
		height: 18px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_it {
		left: 205.398px;
		top: 1145.444px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_iu {
		left: 290.067px;
		top: 1143.674px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_iv {
		left: 373.736px;
		top: 1145.444px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_iw {
		left: 449.964px;
		top: 1145.444px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ix {
		left: 517.883px;
		top: 1145.444px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_iy {
		left: 217.791px;
		top: 1273px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_iz {
		left: 295.429px;
		top: 1273px;
		position: absolute;
		overflow: visible;
		width: 63px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_i {
		left: 377.08px;
		top: 1273px;
		position: absolute;
		overflow: visible;
		width: 66px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ja {
		left: 217.791px;
		top: 1332px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jb {
		left: 295.429px;
		top: 1332px;
		position: absolute;
		overflow: visible;
		width: 63px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jc {
		left: 377.08px;
		top: 1332px;
		position: absolute;
		overflow: visible;
		width: 66px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jd {
		left: 485.548px;
		top: 1273px;
		position: absolute;
		overflow: visible;
		width: 16px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_je {
		left: 486.398px;
		top: 1337px;
		position: absolute;
		overflow: visible;
		width: 16px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jf {
		left: 542.883px;
		top: 1274px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jg {
		left: 644.195px;
		top: 1274px;
		position: absolute;
		overflow: visible;
		width: 63px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jh {
		left: 738.005px;
		top: 1274px;
		position: absolute;
		overflow: visible;
		width: 66px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ji {
		left: 542.883px;
		top: 1333px;
		position: absolute;
		overflow: visible;
		width: 54px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jj {
		left: 644.195px;
		top: 1333px;
		position: absolute;
		overflow: visible;
		width: 63px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jk {
		left: 738.005px;
		top: 1333px;
		position: absolute;
		overflow: visible;
		width: 66px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jl {
		left: 870px;
		top: 1273px;
		position: absolute;
		overflow: visible;
		width: 66px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jm {
		left: 870px;
		top: 1337px;
		position: absolute;
		overflow: visible;
		width: 66px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jn {
		left: 650.524px;
		top: 1042.481px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jo {
		left: 650.524px;
		top: 1070.65px;
		position: absolute;
		overflow: visible;
		width: 139px;
		height: 23px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jp {
		left: 671.134px;
		top: 1144.426px;
		position: absolute;
		overflow: visible;
		width: 16px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jq {
		left: 784px;
		top: 1144.426px;
		position: absolute;
		overflow: visible;
		width: 16px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_jr {
		left: 952px;
		top: 1144.426px;
		position: absolute;
		overflow: visible;
		width: 16px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_3 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 626.719px;
		overflow: visible;
	}
	#Grupo_1_it {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_js {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_4 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 6px;
		top: 670.094px;
		overflow: visible;
	}
	#Grupo_1_iw {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_jt {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_5 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 708.157px;
		overflow: visible;
	}
	#Grupo_1_iz {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_ju {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_6 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 6px;
		top: 747.991px;
		overflow: visible;
	}
	#Grupo_1_i {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_jv {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_7 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 786.054px;
		overflow: visible;
	}
	#Grupo_1_ja {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_jw {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_8 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 6px;
		top: 829.429px;
		overflow: visible;
	}
	#Grupo_1_jb {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_jx {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_9 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 867.492px;
		overflow: visible;
	}
	#Grupo_1_jc {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_jy {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_10 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 908.211px;
		overflow: visible;
	}
	#Grupo_1_je {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_jz {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_11 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 4px;
		top: 946.275px;
		overflow: visible;
	}
	#Grupo_1_jh {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_j {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_12 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 989.65px;
		overflow: visible;
	}
	#Grupo_1_jk {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_ka {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_13 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 4px;
		top: 1027.713px;
		overflow: visible;
	}
	#Grupo_1_jn {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_kb {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_14 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 1067.547px;
		overflow: visible;
	}
	#Grupo_1_jq {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_kc {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_15 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 4px;
		top: 1105.61px;
		overflow: visible;
	}
	#Grupo_1_jt {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_kd {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Grupo_16 {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 5px;
		top: 1148.985px;
		overflow: visible;
	}
	#Grupo_1_jw {
		position: absolute;
		width: 73px;
		height: 20px;
		left: 0px;
		top: 0px;
		overflow: visible;
	}
	#Nomenclatura_ke {
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 74px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_kf {
		left: 23px;
		top: 1422px;
		position: absolute;
		overflow: hidden;
		width: 959px;
		height: 45px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Trazado_7 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_7 {
		overflow: visible;
		position: absolute;
		width: 4.076px;
		height: 640.474px;
		left: 192.274px;
		top: 542.085px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_8 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_8 {
		overflow: visible;
		position: absolute;
		width: 4.076px;
		height: 640.474px;
		left: 275.274px;
		top: 542.085px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_9 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_9 {
		overflow: visible;
		position: absolute;
		width: 4.076px;
		height: 640.474px;
		left: 356.274px;
		top: 542.085px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_10 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_10 {
		overflow: visible;
		position: absolute;
		width: 4.076px;
		height: 623.125px;
		left: 434.274px;
		top: 559.434px;
		transform: matrix(1,0,0,1,0,0);
	}
	#Trazado_11 {
		fill: rgba(0,0,0,0);
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Trazado_11 {
		overflow: visible;
		position: absolute;
		width: 4.076px;
		height: 623.125px;
		left: 508.274px;
		top: 559.434px;
		transform: matrix(1,0,0,1,0,0);
	}
</style>
<script id="applicationScript">
///////////////////////////////////////
// INITIALIZATION
///////////////////////////////////////

/**
 * Functionality for scaling, showing by media query, and navigation between multiple pages on a single page. 
 * Code subject to change.
 **/

if (window.console==null) { window["console"] = { log : function() {} } }; // some browsers do not set console

var Application = function() {
	// event constants
	this.prefix = "--web-";
	this.NAVIGATION_CHANGE = "viewChange";
	this.VIEW_NOT_FOUND = "viewNotFound";
	this.VIEW_CHANGE = "viewChange";
	this.VIEW_CHANGING = "viewChanging";
	this.STATE_NOT_FOUND = "stateNotFound";
	this.APPLICATION_COMPLETE = "applicationComplete";
	this.APPLICATION_RESIZE = "applicationResize";
	this.SIZE_STATE_NAME = "data-is-view-scaled";
	this.STATE_NAME = this.prefix + "state";

	this.lastView = null;
	this.lastState = null;
	this.lastOverlay = null;
	this.currentView = null;
	this.currentState = null;
	this.currentOverlay = null;
	this.currentQuery = {index: 0, rule: null, mediaText: null, id: null};
	this.inclusionQuery = "(min-width: 0px)";
	this.exclusionQuery = "none and (min-width: 99999px)";
	this.LastModifiedDateLabelName = "LastModifiedDateLabel";
	this.viewScaleSliderId = "ViewScaleSliderInput";
	this.pageRefreshedName = "showPageRefreshedNotification";
	this.applicationStylesheet = null;
	this.mediaQueryDictionary = {};
	this.viewsDictionary = {};
	this.addedViews = [];
	this.views = {};
	this.viewIds = [];
	this.viewQueries = {};
	this.overlays = {};
	this.overlayIds = [];
	this.numberOfViews = 0;
	this.verticalPadding = 0;
	this.horizontalPadding = 0;
	this.stateName = null;
	this.viewScale = 1;
	this.viewLeft = 0;
	this.viewTop = 0;

	// view settings
	this.showUpdateNotification = false;
	this.showNavigationControls = false;
	this.scaleViewsToFit = false;
	this.scaleToFitOnDoubleClick = false;
	this.actualSizeOnDoubleClick = false;
	this.scaleViewsOnResize = false;
	this.navigationOnKeypress = false;
	this.showViewName = false;
	this.enableDeepLinking = true;
	this.refreshPageForChanges = false;
	this.showRefreshNotifications = true;

	// view controls
	this.scaleViewSlider = null;
	this.lastModifiedLabel = null;
	this.supportsPopState = false; // window.history.pushState!=null;
	this.initialized = false;

	// refresh properties
	this.refreshDuration = 250;
	this.lastModifiedDate = null;
	this.refreshRequest = null;
	this.refreshInterval = null;
	this.refreshContent = null;
	this.refreshContentSize = null;
	this.refreshCheckContent = false;
	this.refreshCheckContentSize = false;

	var self = this;

	self.initialize = function(event) {
		var view = self.getVisibleView();
		var views = self.getVisibleViews();
		if (view==null) view = self.getInitialView();
		self.collectViews();
		self.collectOverlays();
		self.collectMediaQueries();

		for (let index = 0; index < views.length; index++) {
			var view = views[index];
			self.setViewOptions(view);
			self.setViewVariables(view);
			self.centerView(view);
		}

		// sometimes the body size is 0 so we call this now and again later
		if (self.initialized) {
			window.addEventListener(self.NAVIGATION_CHANGE, self.viewChangeHandler);
			window.addEventListener("keyup", self.keypressHandler);
			window.addEventListener("keypress", self.keypressHandler);
			window.addEventListener("resize", self.resizeHandler);
			window.document.addEventListener("dblclick", self.doubleClickHandler);

			if (self.supportsPopState) {
				window.addEventListener('popstate', self.popStateHandler);
			}
			else {
				window.addEventListener('hashchange', self.hashChangeHandler);
			}

			// we are ready to go
			window.dispatchEvent(new Event(self.APPLICATION_COMPLETE));
		}

		if (self.initialized==false) {
			if (self.enableDeepLinking) {
				self.syncronizeViewToURL();
			} 
	
			if (self.refreshPageForChanges) {
				self.setupRefreshForChanges();
			}
	
			self.initialized = true;
		}
		
		if (self.scaleViewsToFit) {
			self.viewScale = self.scaleViewToFit(view);
			
			if (self.viewScale<0) {
				setTimeout(self.scaleViewToFit, 500, view);
			}
		}
		else if (view) {
			self.viewScale = self.getViewScaleValue(view);
			self.centerView(view);
			self.updateSliderValue(self.viewScale);
		}
		else {
			// no view found
		}
	
		if (self.showUpdateNotification) {
			self.showNotification();
		}

		//"addEventListener" in window ? null : window.addEventListener = window.attachEvent;
		//"addEventListener" in document ? null : document.addEventListener = document.attachEvent;
	}


	///////////////////////////////////////
	// AUTO REFRESH 
	///////////////////////////////////////

	self.setupRefreshForChanges = function() {
		self.refreshRequest = new XMLHttpRequest();

		if (!self.refreshRequest) {
			return false;
		}

		// get document start values immediately
		self.requestRefreshUpdate();
	}

	/**
	 * Attempt to check the last modified date by the headers 
	 * or the last modified property from the byte array (experimental)
	 **/
	self.requestRefreshUpdate = function() {
		var url = document.location.href;
		var protocol = window.location.protocol;
		var method;
		
		try {

			if (self.refreshCheckContentSize) {
				self.refreshRequest.open('HEAD', url, true);
			}
			else if (self.refreshCheckContent) {
				self.refreshContent = document.documentElement.outerHTML;
				self.refreshRequest.open('GET', url, true);
				self.refreshRequest.responseType = "text";
			}
			else {

				// get page last modified date for the first call to compare to later
				if (self.lastModifiedDate==null) {

					// File system does not send headers in FF so get blob if possible
					if (protocol=="file:") {
						self.refreshRequest.open("GET", url, true);
						self.refreshRequest.responseType = "blob";
					}
					else {
						self.refreshRequest.open("HEAD", url, true);
						self.refreshRequest.responseType = "blob";
					}

					self.refreshRequest.onload = self.refreshOnLoadOnceHandler;

					// In some browsers (Chrome & Safari) this error occurs at send: 
					// 
					// Chrome - Access to XMLHttpRequest at 'file:///index.html' from origin 'null' 
					// has been blocked by CORS policy: 
					// Cross origin requests are only supported for protocol schemes: 
					// http, data, chrome, chrome-extension, https.
					// 
					// Safari - XMLHttpRequest cannot load file:///Users/user/Public/index.html. Cross origin requests are only supported for HTTP.
					// 
					// Solution is to run a local server, set local permissions or test in another browser
					self.refreshRequest.send(null);

					// In MS browsers the following behavior occurs possibly due to an AJAX call to check last modified date: 
					// 
					// DOM7011: The code on this page disabled back and forward caching.

					// In Brave (Chrome) error when on the server
					// index.js:221 HEAD https://www.example.com/ net::ERR_INSUFFICIENT_RESOURCES
					// self.refreshRequest.send(null);

				}
				else {
					self.refreshRequest = new XMLHttpRequest();
					self.refreshRequest.onreadystatechange = self.refreshHandler;
					self.refreshRequest.ontimeout = function() {
						self.log("Couldn't find page to check for updates");
					}
					
					var method;
					if (protocol=="file:") {
						method = "GET";
					}
					else {
						method = "HEAD";
					}

					//refreshRequest.open('HEAD', url, true);
					self.refreshRequest.open(method, url, true);
					self.refreshRequest.responseType = "blob";
					self.refreshRequest.send(null);
				}
			}
		}
		catch (error) {
			self.log("Refresh failed for the following reason:")
			self.log(error);
		}
	}

	self.refreshHandler = function() {
		var contentSize;

		try {

			if (self.refreshRequest.readyState === XMLHttpRequest.DONE) {
				
				if (self.refreshRequest.status === 2 || 
					self.refreshRequest.status === 200) {
					var pageChanged = false;

					self.updateLastModifiedLabel();

					if (self.refreshCheckContentSize) {
						var lastModifiedHeader = self.refreshRequest.getResponseHeader("Last-Modified");
						contentSize = self.refreshRequest.getResponseHeader("Content-Length");
						//lastModifiedDate = refreshRequest.getResponseHeader("Last-Modified");
						var headers = self.refreshRequest.getAllResponseHeaders();
						var hasContentHeader = headers.indexOf("Content-Length")!=-1;
						
						if (hasContentHeader) {
							contentSize = self.refreshRequest.getResponseHeader("Content-Length");

							// size has not been set yet
							if (self.refreshContentSize==null) {
								self.refreshContentSize = contentSize;
								// exit and let interval call this method again
								return;
							}

							if (contentSize!=self.refreshContentSize) {
								pageChanged = true;
							}
						}
					}
					else if (self.refreshCheckContent) {

						if (self.refreshRequest.responseText!=self.refreshContent) {
							pageChanged = true;
						}
					}
					else {
						lastModifiedHeader = self.getLastModified(self.refreshRequest);

						if (self.lastModifiedDate!=lastModifiedHeader) {
							self.log("lastModifiedDate:" + self.lastModifiedDate + ",lastModifiedHeader:" +lastModifiedHeader);
							pageChanged = true;
						}

					}

					
					if (pageChanged) {
						clearInterval(self.refreshInterval);
						self.refreshUpdatedPage();
						return;
					}

				}
				else {
					self.log('There was a problem with the request.');
				}

			}
		}
		catch( error ) {
			//console.log('Caught Exception: ' + error);
		}
	}

	self.refreshOnLoadOnceHandler = function(event) {

		// get the last modified date
		if (self.refreshRequest.response) {
			self.lastModifiedDate = self.getLastModified(self.refreshRequest);

			if (self.lastModifiedDate!=null) {

				if (self.refreshInterval==null) {
					self.refreshInterval = setInterval(self.requestRefreshUpdate, self.refreshDuration);
				}
			}
			else {
				self.log("Could not get last modified date from the server");
			}
		}
	}

	self.refreshUpdatedPage = function() {
		if (self.showRefreshNotifications) {
			var date = new Date().setTime((new Date().getTime()+10000));
			document.cookie = encodeURIComponent(self.pageRefreshedName) + "=true" + "; max-age=6000;" + " path=/";
		}

		document.location.reload(true);
	}

	self.showNotification = function(duration) {
		var notificationID = self.pageRefreshedName+"ID";
		var notification = document.getElementById(notificationID);
		if (duration==null) duration = 4000;

		if (notification!=null) {return;}

		notification = document.createElement("div");
		notification.id = notificationID;
		notification.textContent = "PAGE UPDATED";
		var styleRule = ""
		styleRule = "position: fixed; padding: 7px 16px 6px 16px; font-family: Arial, sans-serif; font-size: 10px; font-weight: bold; left: 50%;";
		styleRule += "top: 20px; background-color: rgba(0,0,0,.5); border-radius: 12px; color:rgb(235, 235, 235); transition: all 2s linear;";
		styleRule += "transform: translateX(-50%); letter-spacing: .5px; filter: drop-shadow(2px 2px 6px rgba(0, 0, 0, .1))";
		notification.setAttribute("style", styleRule);

		notification.className= "PageRefreshedClass";
		
		document.body.appendChild(notification);

		setTimeout(function() {
			notification.style.opacity = "0";
			notification.style.filter = "drop-shadow( 0px 0px 0px rgba(0,0,0, .5))";
			setTimeout(function() {
				notification.parentNode.removeChild(notification);
			}, duration)
		}, duration);

		document.cookie = encodeURIComponent(self.pageRefreshedName) + "=; max-age=1; path=/";
	}

	/**
	 * Get the last modified date from the header 
	 * or file object after request has been received
	 **/
	self.getLastModified = function(request) {
		var date;

		// file protocol - FILE object with last modified property
		if (request.response && request.response.lastModified) {
			date = request.response.lastModified;
		}
		
		// http protocol - check headers
		if (date==null) {
			date = request.getResponseHeader("Last-Modified");
		}

		return date;
	}

	self.updateLastModifiedLabel = function() {
		var labelValue = "";
		
		if (self.lastModifiedLabel==null) {
			self.lastModifiedLabel = document.getElementById("LastModifiedLabel");
		}

		if (self.lastModifiedLabel) {
			var seconds = parseInt(((new Date().getTime() - Date.parse(document.lastModified)) / 1000 / 60) * 100 + "");
			var minutes = 0;
			var hours = 0;

			if (seconds < 60) {
				seconds = Math.floor(seconds/10)*10;
				labelValue = seconds + " seconds";
			}
			else {
				minutes = parseInt((seconds/60) + "");

				if (minutes>60) {
					hours = parseInt((seconds/60/60) +"");
					labelValue += hours==1 ? " hour" : " hours";
				}
				else {
					labelValue = minutes+"";
					labelValue += minutes==1 ? " minute" : " minutes";
				}
			}
			
			if (seconds<10) {
				labelValue = "Updated now";
			}
			else {
				labelValue = "Updated " + labelValue + " ago";
			}

			if (self.lastModifiedLabel.firstElementChild) {
				self.lastModifiedLabel.firstElementChild.textContent = labelValue;

			}
			else if ("textContent" in self.lastModifiedLabel) {
				self.lastModifiedLabel.textContent = labelValue;
			}
		}
	}

	self.getShortString = function(string, length) {
		if (length==null) length = 30;
		string = string!=null ? string.substr(0, length).replace(/\n/g, "") : "[String is null]";
		return string;
	}

	self.getShortNumber = function(value, places) {
		if (places==null || places<1) places = 4;
		value = Math.round(value * Math.pow(10,places)) / Math.pow(10, places);
		return value;
	}

	///////////////////////////////////////
	// NAVIGATION CONTROLS
	///////////////////////////////////////

	self.updateViewLabel = function() {
		var viewNavigationLabel = document.getElementById("ViewNavigationLabel");
		var view = self.getVisibleView();
		var viewIndex = view ? self.getViewIndex(view) : -1;
		var viewName = view ? self.getViewPreferenceValue(view, self.prefix + "view-name") : null;
		var viewId = view ? view.id : null;

		if (viewNavigationLabel && view) {
			if (viewName && viewName.indexOf('"')!=-1) {
				viewName = viewName.replace(/"/g, "");
			}

			if (self.showViewName) {
				viewNavigationLabel.textContent = viewName;
				self.setTooltip(viewNavigationLabel, viewIndex + 1 + " of " + self.numberOfViews);
			}
			else {
				viewNavigationLabel.textContent = viewIndex + 1 + " of " + self.numberOfViews;
				self.setTooltip(viewNavigationLabel, viewName);
			}

		}
	}

	self.updateURL = function(view) {
		view = view == null ? self.getVisibleView() : view;
		var viewId = view ? view.id : null
		var viewFragment = view ? "#"+ viewId : null;

		if (viewId && self.viewIds.length>1 && self.enableDeepLinking) {

			if (self.supportsPopState==false) {
				self.setFragment(viewId);
			}
			else {
				if (viewFragment!=window.location.hash) {

					if (window.location.hash==null) {
						window.history.replaceState({name:viewId}, null, viewFragment);
					}
					else {
						window.history.pushState({name:viewId}, null, viewFragment);
					}
				}
			}
		}
	}

	self.updateURLState = function(view, stateName) {
		stateName = view && (stateName=="" || stateName==null) ? self.getStateNameByViewId(view.id) : stateName;

		if (self.supportsPopState==false) {
			self.setFragment(stateName);
		}
		else {
			if (stateName!=window.location.hash) {

				if (window.location.hash==null) {
					window.history.replaceState({name:view.viewId}, null, stateName);
				}
				else {
					window.history.pushState({name:view.viewId}, null, stateName);
				}
			}
		}
	}

	self.setFragment = function(value) {
		window.location.hash = "#" + value;
	}

	self.setTooltip = function(element, value) {
		// setting the tooltip in edge causes a page crash on hover
		if (/Edge/.test(navigator.userAgent)) { return; }

		if ("title" in element) {
			element.title = value;
		}
	}

	self.getStylesheetRules = function(styleSheet) {
		try {
			if (styleSheet) return styleSheet.cssRules || styleSheet.rules;
	
			return document.styleSheets[0]["cssRules"] || document.styleSheets[0]["rules"];
		}
		catch (error) {
			// ERRORS:
			// SecurityError: The operation is insecure.
			// Errors happen when script loads before stylesheet or loading an external css locally

			// InvalidAccessError: A parameter or an operation is not supported by the underlying object
			// Place script after stylesheet

			console.log(error);
			if (error.toString().indexOf("The operation is insecure")!=-1) {
				console.log("Load the stylesheet before the script or load the stylesheet inline until it can be loaded on a server")
			}
			return [];
		}
	}

	/**
	 * If single page application hide all of the views. 
	 * @param {Number} selectedIndex if provided shows the view at index provided
	 **/
	self.hideViews = function(selectedIndex, animation) {
		var rules = self.getStylesheetRules();
		var queryIndex = 0;
		var numberOfRules = rules!=null ? rules.length : 0;

		// loop through rules and hide media queries except selected
		for (var i=0;i<numberOfRules;i++) {
			var rule = rules[i];

			if (rule.media!=null) {

				if (queryIndex==selectedIndex) {
					self.currentQuery.mediaText = rule.conditionText;
					self.currentQuery.index = selectedIndex;
					self.currentQuery.rule = rule;
					self.enableMediaQuery(rule);
				}
				else {
					if (animation) {
						self.fadeOut(rule)
					}
					else {
						self.disableMediaQuery(rule);
					}
				}
				
				queryIndex++;
			}
		}

		self.numberOfViews = queryIndex;
		self.updateViewLabel();
		self.updateURL();

		self.dispatchViewChange();

		var view = self.getVisibleView();
		var viewIndex = view ? self.getViewIndex(view) : -1;

		return viewIndex==selectedIndex ? view : null;
	}

	/**
	 * Hide view
	 * @param {Object} view element to hide
	 **/
	self.hideView = function(view) {
		var rule = view ? self.mediaQueryDictionary[view.id] : null;

		if (rule) {
			self.disableMediaQuery(rule);
		}
	}

	/**
	 * Hide overlay
	 * @param {Object} overlay element to hide
	 **/
	self.hideOverlay = function(overlay) {
		var rule = overlay ? self.mediaQueryDictionary[overlay.id] : null;

		if (rule) {
			self.disableMediaQuery(rule);

			//if (self.showByMediaQuery) {
				overlay.style.display = "none";
			//}
		}
	}

	/**
	 * Show the view by media query. Does not hide current views
	 * Sets view options by default
	 * @param {Object} view element to show
	 * @param {Boolean} setViewOptions sets view options if null or true
	 */
	self.showViewByMediaQuery = function(view, setViewOptions) {
		var id = view ? view.id : null;
		var query = id ? self.mediaQueryDictionary[id] : null;
		var display = null;
		setViewOptions = setViewOptions==null ? true : setViewOptions;

		if (query) {
			self.enableMediaQuery(query);
			if (view && setViewOptions) self.setViewOptions(view);
			if (view && setViewOptions) self.setViewVariables(view);
		}
	}

	/**
	 * Show the view. Does not hide current views
	 */
	self.showView = function(view, setViewOptions) {
		var id = view ? view.id : null;
		var query = id ? self.mediaQueryDictionary[id] : null;
		var display = null;
		setViewOptions = setViewOptions==null ? true : setViewOptions;

		if (query) {
			self.enableMediaQuery(query);
			if (view==null) view =self.getVisibleView();
			if (view && setViewOptions) self.setViewOptions(view);
		}
		else if (id) {
			display = window.getComputedStyle(view).getPropertyValue("display");
			if (display=="" || display=="none") {
				view.style.display = "block";
			}
		}

		if (view) {
			if (self.currentView!=null) {
				self.lastView = self.currentView;
			}

			self.currentView = view;
		}
	}

	self.showViewById = function(id, setViewOptions) {
		var view = id ? self.getViewById(id) : null;

		if (view) {
			self.showView(view);
			return;
		}

		self.log("View not found '" + id + "'");
	}

	/**
	 * Show overlay over view
	 * @param {String} id id of view or view reference
	 * @param {Number} x x location
	 * @param {Number} y y location
	 * @param {Event | HTMLElement} event event or html element with styles applied
	 */
	self.showOverlay = function(id, x, y, event) {
		var overlay = id && typeof id === 'string' ? self.getViewById(id) : id ? id : null;
		var query = overlay ? self.mediaQueryDictionary[overlay.id] : null;
		var centerHorizontally = false;
		var centerVertically = false;
		var display = null;

		// get enter animation - event target must have css variables declared
		if (event) {
			var button = event.currentTarget || event; // can be event or htmlelement
			var buttonComputedStyles = getComputedStyle(button);
			var actionTargetValue = buttonComputedStyles.getPropertyValue(self.prefix+"action-target").trim();
			var animation = buttonComputedStyles.getPropertyValue(self.prefix+"animation").trim();
			var targetType = buttonComputedStyles.getPropertyValue(self.prefix+"action-type").trim();
			var actionTarget = self.application ? null : self.getElement(actionTargetValue);
			var actionTargetStyles = actionTarget ? actionTarget.style : null;

			if (actionTargetStyles) {
				actionTargetStyles.setProperty("animation", animation);
			}

			if ("stopImmediatePropagation" in event) {
				event.stopImmediatePropagation();
			}
		}
		
		if (self.application==false || targetType=="page") {
			document.location.href = "./" + actionTargetValue;
			return;
		}

		// remove any current overlays
		if (self.currentOverlay) {
			self.removeOverlay();
		}

		if (query) {
			//self.setElementAnimation(overlay, null);
			//overlay.style.animation = animation;
			self.enableMediaQuery(query);
			
			var display = overlay && overlay.style.display;
			
			if (overlay && display=="" || display=="none") {
				overlay.style.display = "block";
				self.setViewOptions(overlay);
			}

			// add animation defined in event target style declaration
			if (animation && self.supportAnimations) {
				self.fadeIn(overlay, false, animation);
			}
		}
		else if (id) {
			if (overlay==null || overlay==false) {
				self.log("Overlay not found, '"+ id + "'");
				return;
			}

			display = window.getComputedStyle(overlay).getPropertyValue("display");

			if (display=="" || display=="none") {
				overlay.style.display = "block";
			}

			// add animation defined in event target style declaration
			if (animation && self.supportAnimations) {
				self.fadeIn(overlay, false, animation);
			}
		}

		// do not set x or y position if centering
		centerHorizontally = self.getViewPreferenceBoolean(overlay, self.prefix + "center-horizontally", false);
		centerVertically = self.getViewPreferenceBoolean(overlay, self.prefix + "center-vertically", false);

		if (overlay && centerHorizontally==false) {
			overlay.style.left = x + "px";
		}
		
		if (overlay && centerVertically==false) {
			overlay.style.top = y + "px";
		}

		self.currentOverlay = overlay;
	}

	self.goBack = function() {
		if (self.currentOverlay) {
			self.removeOverlay();
		}
		else if (self.lastView) {
			self.goToView(self.lastView.id);
		}
	}

	self.removeOverlay = function(animate) {
		var overlay = self.currentOverlay;
		animate = animate===false ? false : true;

		if (overlay) {
			var style = overlay.style;
			
			if (style.animation && self.supportAnimations && animate) {
				self.reverseAnimation(overlay, true);

				var duration = self.getAnimationDuration(style.animation, true);
		
				setTimeout(function() {
					self.setElementAnimation(overlay, null);
					self.hideOverlay(overlay);
				}, duration);
			}
			else {
				self.setElementAnimation(overlay, null);
				self.hideOverlay(overlay);
			}
		}
	}

	/**
	 * Reverse the animation and hide after
	 * @param {Object} target element with animation
	 * @param {Boolean} hide hide after animation ends
	 */
	self.reverseAnimation = function(target, hide) {
		var lastAnimation = null;
		var style = target.style;

		style.animationPlayState = "paused";
		lastAnimation = style.animation;
		style.animation = null;
		style.animationPlayState = "paused";

		if (hide) {
			//target.addEventListener("animationend", self.animationEndHideHandler);
	
			var duration = self.getAnimationDuration(lastAnimation, true);
			var isOverlay = self.isOverlay(target);
	
			setTimeout(function() {
				self.setElementAnimation(target, null);

				if (isOverlay) {
					self.hideOverlay(target);
				}
				else {
					self.hideView(target);
				}
			}, duration);
		}

		setTimeout(function() {
			style.animation = lastAnimation;
			style.animationPlayState = "paused";
			style.animationDirection = "reverse";
			style.animationPlayState = "running";
		}, 30);
	}

	self.animationEndHandler = function(event) {
		var target = event.currentTarget;
		self.dispatchEvent(new Event(event.type));
	}

	self.isOverlay = function(view) {
		var result = view ? self.getViewPreferenceBoolean(view, self.prefix + "is-overlay") : false;

		return result;
	}

	self.animationEndHideHandler = function(event) {
		var target = event.currentTarget;
		self.setViewVariables(null, target);
		self.hideView(target);
		target.removeEventListener("animationend", self.animationEndHideHandler);
	}

	self.animationEndShowHandler = function(event) {
		var target = event.currentTarget;
		target.removeEventListener("animationend", self.animationEndShowHandler);
	}

	self.setViewOptions = function(view) {

		if (view) {
			self.minimumScale = self.getViewPreferenceValue(view, self.prefix + "minimum-scale");
			self.maximumScale = self.getViewPreferenceValue(view, self.prefix + "maximum-scale");
			self.scaleViewsToFit = self.getViewPreferenceBoolean(view, self.prefix + "scale-to-fit");
			self.scaleToFitType = self.getViewPreferenceValue(view, self.prefix + "scale-to-fit-type");
			self.scaleToFitOnDoubleClick = self.getViewPreferenceBoolean(view, self.prefix + "scale-on-double-click");
			self.actualSizeOnDoubleClick = self.getViewPreferenceBoolean(view, self.prefix + "actual-size-on-double-click");
			self.scaleViewsOnResize = self.getViewPreferenceBoolean(view, self.prefix + "scale-on-resize");
			self.enableScaleUp = self.getViewPreferenceBoolean(view, self.prefix + "enable-scale-up");
			self.centerHorizontally = self.getViewPreferenceBoolean(view, self.prefix + "center-horizontally");
			self.centerVertically = self.getViewPreferenceBoolean(view, self.prefix + "center-vertically");
			self.navigationOnKeypress = self.getViewPreferenceBoolean(view, self.prefix + "navigate-on-keypress");
			self.showViewName = self.getViewPreferenceBoolean(view, self.prefix + "show-view-name");
			self.refreshPageForChanges = self.getViewPreferenceBoolean(view, self.prefix + "refresh-for-changes");
			self.refreshPageForChangesInterval = self.getViewPreferenceValue(view, self.prefix + "refresh-interval");
			self.showNavigationControls = self.getViewPreferenceBoolean(view, self.prefix + "show-navigation-controls");
			self.scaleViewSlider = self.getViewPreferenceBoolean(view, self.prefix + "show-scale-controls");
			self.enableDeepLinking = self.getViewPreferenceBoolean(view, self.prefix + "enable-deep-linking");
			self.singlePageApplication = self.getViewPreferenceBoolean(view, self.prefix + "application");
			self.showByMediaQuery = self.getViewPreferenceBoolean(view, self.prefix + "show-by-media-query");
			self.showUpdateNotification = document.cookie!="" ? document.cookie.indexOf(self.pageRefreshedName)!=-1 : false;
			self.imageComparisonDuration = self.getViewPreferenceValue(view, self.prefix + "image-comparison-duration");
			self.supportAnimations = self.getViewPreferenceBoolean(view, self.prefix + "enable-animations", true);

			if (self.scaleViewsToFit) {
				var newScaleValue = self.scaleViewToFit(view);
				
				if (newScaleValue<0) {
					setTimeout(self.scaleViewToFit, 500, view);
				}
			}
			else {
				self.viewScale = self.getViewScaleValue(view);
				self.viewToFitWidthScale = self.getViewFitToViewportWidthScale(view, self.enableScaleUp)
				self.viewToFitHeightScale = self.getViewFitToViewportScale(view, self.enableScaleUp);
				self.updateSliderValue(self.viewScale);
			}

			if (self.imageComparisonDuration!=null) {
				// todo
			}

			if (self.refreshPageForChangesInterval!=null) {
				self.refreshDuration = Number(self.refreshPageForChangesInterval);
			}
		}
	}

	self.previousView = function(event) {
		var rules = self.getStylesheetRules();
		var view = self.getVisibleView()
		var index = view ? self.getViewIndex(view) : -1;
		var prevQueryIndex = index!=-1 ? index-1 : self.currentQuery.index-1;
		var queryIndex = 0;
		var numberOfRules = rules!=null ? rules.length : 0;

		if (event) {
			event.stopImmediatePropagation();
		}

		if (prevQueryIndex<0) {
			return;
		}

		// loop through rules and hide media queries except selected
		for (var i=0;i<numberOfRules;i++) {
			var rule = rules[i];
			
			if (rule.media!=null) {

				if (queryIndex==prevQueryIndex) {
					self.currentQuery.mediaText = rule.conditionText;
					self.currentQuery.index = prevQueryIndex;
					self.currentQuery.rule = rule;
					self.enableMediaQuery(rule);
					self.updateViewLabel();
					self.updateURL();
					self.dispatchViewChange();
				}
				else {
					self.disableMediaQuery(rule);
				}

				queryIndex++;
			}
		}
	}

	self.nextView = function(event) {
		var rules = self.getStylesheetRules();
		var view = self.getVisibleView();
		var index = view ? self.getViewIndex(view) : -1;
		var nextQueryIndex = index!=-1 ? index+1 : self.currentQuery.index+1;
		var queryIndex = 0;
		var numberOfRules = rules!=null ? rules.length : 0;
		var numberOfMediaQueries = self.getNumberOfMediaRules();

		if (event) {
			event.stopImmediatePropagation();
		}

		if (nextQueryIndex>=numberOfMediaQueries) {
			return;
		}

		// loop through rules and hide media queries except selected
		for (var i=0;i<numberOfRules;i++) {
			var rule = rules[i];
			
			if (rule.media!=null) {

				if (queryIndex==nextQueryIndex) {
					self.currentQuery.mediaText = rule.conditionText;
					self.currentQuery.index = nextQueryIndex;
					self.currentQuery.rule = rule;
					self.enableMediaQuery(rule);
					self.updateViewLabel();
					self.updateURL();
					self.dispatchViewChange();
				}
				else {
					self.disableMediaQuery(rule);
				}

				queryIndex++;
			}
		}
	}

	/**
	 * Enables a view via media query
	 */
	self.enableMediaQuery = function(rule) {

		try {
			rule.media.mediaText = self.inclusionQuery;
		}
		catch(error) {
			//self.log(error);
			rule.conditionText = self.inclusionQuery;
		}
	}

	self.disableMediaQuery = function(rule) {

		try {
			rule.media.mediaText = self.exclusionQuery;
		}
		catch(error) {
			rule.conditionText = self.exclusionQuery;
		}
	}

	self.dispatchViewChange = function() {
		try {
			var event = new Event(self.NAVIGATION_CHANGE);
			window.dispatchEvent(event);
		}
		catch (error) {
			// In IE 11: Object doesn't support this action
		}
	}

	self.getNumberOfMediaRules = function() {
		var rules = self.getStylesheetRules();
		var numberOfRules = rules ? rules.length : 0;
		var numberOfQueries = 0;

		for (var i=0;i<numberOfRules;i++) {
			if (rules[i].media!=null) { numberOfQueries++; }
		}
		
		return numberOfQueries;
	}

	/////////////////////////////////////////
	// VIEW SCALE 
	/////////////////////////////////////////

	self.sliderChangeHandler = function(event) {
		var value = self.getShortNumber(event.currentTarget.value/100);
		var view = self.getVisibleView();
		self.setViewScaleValue(view, false, value, true);
	}

	self.updateSliderValue = function(scale) {
		var slider = document.getElementById(self.viewScaleSliderId);
		var tooltip = parseInt(scale * 100 + "") + "%";
		var inputType;
		var inputValue;
		
		if (slider) {
			inputValue = self.getShortNumber(scale * 100);
			if (inputValue!=slider["value"]) {
				slider["value"] = inputValue;
			}
			inputType = slider.getAttributeNS(null, "type");

			if (inputType!="range") {
				// input range is not supported
				slider.style.display = "none";
			}

			self.setTooltip(slider, tooltip);
		}
	}

	self.viewChangeHandler = function(event) {
		var view = self.getVisibleView();
		var matrix = view ? getComputedStyle(view).transform : null;
		
		if (matrix) {
			self.viewScale = self.getViewScaleValue(view);
			
			var scaleNeededToFit = self.getViewFitToViewportScale(view);
			var isViewLargerThanViewport = scaleNeededToFit<1;
			
			// scale large view to fit if scale to fit is enabled
			if (self.scaleViewsToFit) {
				self.scaleViewToFit(view);
			}
			else {
				self.updateSliderValue(self.viewScale);
			}
		}
	}

	self.getViewScaleValue = function(view) {
		var matrix = getComputedStyle(view).transform;

		if (matrix) {
			var matrixArray = matrix.replace("matrix(", "").split(",");
			var scaleX = parseFloat(matrixArray[0]);
			var scaleY = parseFloat(matrixArray[3]);
			var scale = Math.min(scaleX, scaleY);
		}

		return scale;
	}

	/**
	 * Scales view to scale. 
	 * @param {Object} view view to scale. views are in views array
	 * @param {Boolean} scaleToFit set to true to scale to fit. set false to use desired scale value
	 * @param {Number} desiredScale scale to define. not used if scale to fit is false
	 * @param {Boolean} isSliderChange indicates if slider is callee
	 */
	self.setViewScaleValue = function(view, scaleToFit, desiredScale, isSliderChange) {
		var enableScaleUp = self.enableScaleUp;
		var scaleToFitType = self.scaleToFitType;
		var minimumScale = self.minimumScale;
		var maximumScale = self.maximumScale;
		var hasMinimumScale = !isNaN(minimumScale) && minimumScale!="";
		var hasMaximumScale = !isNaN(maximumScale) && maximumScale!="";
		var scaleNeededToFit = self.getViewFitToViewportScale(view, enableScaleUp);
		var scaleNeededToFitWidth = self.getViewFitToViewportWidthScale(view, enableScaleUp);
		var scaleNeededToFitHeight = self.getViewFitToViewportHeightScale(view, enableScaleUp);
		var scaleToFitFull = self.getViewFitToViewportScale(view, true);
		var scaleToFitFullWidth = self.getViewFitToViewportWidthScale(view, true);
		var scaleToFitFullHeight = self.getViewFitToViewportHeightScale(view, true);
		var scaleToWidth = scaleToFitType=="width";
		var scaleToHeight = scaleToFitType=="height";
		var shrunkToFit = false;
		var topPosition = null;
		var leftPosition = null;
		var translateY = null;
		var translateX = null;
		var transformValue = "";
		var canCenterVertically = true;
		var canCenterHorizontally = true;

		if (scaleToFit && isSliderChange!=true) {
			if (scaleToFitType=="fit" || scaleToFitType=="") {
				desiredScale = scaleNeededToFit;
			}
			else if (scaleToFitType=="width") {
				desiredScale = scaleNeededToFitWidth;
			}
			else if (scaleToFitType=="height") {
				desiredScale = scaleNeededToFitHeight;
			}
		}
		else {
			if (isNaN(desiredScale)) {
				desiredScale = 1;
			}
		}

		self.updateSliderValue(desiredScale);
		
		// scale to fit width
		if (scaleToWidth && scaleToHeight==false) {
			canCenterVertically = scaleNeededToFitHeight>=scaleNeededToFitWidth;
			canCenterHorizontally = scaleNeededToFitWidth>=1 && enableScaleUp==false;

			if (isSliderChange) {
				canCenterHorizontally = desiredScale<scaleToFitFullWidth;
			}
			else if (scaleToFit) {
				desiredScale = scaleNeededToFitWidth;
			}

			if (hasMinimumScale) {
				desiredScale = Math.max(desiredScale, Number(minimumScale));
			}

			if (hasMaximumScale) {
				desiredScale = Math.min(desiredScale, Number(maximumScale));
			}

			desiredScale = self.getShortNumber(desiredScale);

			canCenterHorizontally = self.canCenterHorizontally(view, "width", enableScaleUp, desiredScale, minimumScale, maximumScale);
			canCenterVertically = self.canCenterVertically(view, "width", enableScaleUp, desiredScale, minimumScale, maximumScale);

			if (desiredScale>1 && (enableScaleUp || isSliderChange)) {
				transformValue = "scale(" + desiredScale + ")";
			}
			else if (desiredScale>=1 && enableScaleUp==false) {
				transformValue = "scale(" + 1 + ")";
			}
			else {
				transformValue = "scale(" + desiredScale + ")";
			}

			if (self.centerVertically) {
				if (canCenterVertically) {
					translateY = "-50%";
					topPosition = "50%";
				}
				else {
					translateY = "0";
					topPosition = "0";
				}
				
				if (view.style.top != topPosition) {
					view.style.top = topPosition + "";
				}

				if (canCenterVertically) {
					transformValue += " translateY(" + translateY+ ")";
				}
			}

			if (self.centerHorizontally) {
				if (canCenterHorizontally) {
					translateX = "-50%";
					leftPosition = "50%";
				}
				else {
					translateX = "0";
					leftPosition = "0";
				}

				if (view.style.left != leftPosition) {
					view.style.left = leftPosition + "";
				}

				if (canCenterHorizontally) {
					transformValue += " translateX(" + translateX+ ")";
				}
			}

			view.style.transformOrigin = "0 0";
			view.style.transform = transformValue;

			self.viewScale = desiredScale;
			self.viewToFitWidthScale = scaleNeededToFitWidth;
			self.viewToFitHeightScale = scaleNeededToFitHeight;
			self.viewLeft = leftPosition;
			self.viewTop = topPosition;

			return desiredScale;
		}

		// scale to fit height
		if (scaleToHeight && scaleToWidth==false) {
			//canCenterVertically = scaleNeededToFitHeight>=scaleNeededToFitWidth;
			//canCenterHorizontally = scaleNeededToFitHeight<=scaleNeededToFitWidth && enableScaleUp==false;
			canCenterVertically = scaleNeededToFitHeight>=scaleNeededToFitWidth;
			canCenterHorizontally = scaleNeededToFitWidth>=1 && enableScaleUp==false;
			
			if (isSliderChange) {
				canCenterHorizontally = desiredScale<scaleToFitFullHeight;
			}
			else if (scaleToFit) {
				desiredScale = scaleNeededToFitHeight;
			}

			if (hasMinimumScale) {
				desiredScale = Math.max(desiredScale, Number(minimumScale));
			}

			if (hasMaximumScale) {
				desiredScale = Math.min(desiredScale, Number(maximumScale));
				//canCenterVertically = desiredScale>=scaleNeededToFitHeight && enableScaleUp==false;
			}

			desiredScale = self.getShortNumber(desiredScale);

			canCenterHorizontally = self.canCenterHorizontally(view, "height", enableScaleUp, desiredScale, minimumScale, maximumScale);
			canCenterVertically = self.canCenterVertically(view, "height", enableScaleUp, desiredScale, minimumScale, maximumScale);

			if (desiredScale>1 && (enableScaleUp || isSliderChange)) {
				transformValue = "scale(" + desiredScale + ")";
			}
			else if (desiredScale>=1 && enableScaleUp==false) {
				transformValue = "scale(" + 1 + ")";
			}
			else {
				transformValue = "scale(" + desiredScale + ")";
			}

			if (self.centerHorizontally) {
				if (canCenterHorizontally) {
					translateX = "-50%";
					leftPosition = "50%";
				}
				else {
					translateX = "0";
					leftPosition = "0";
				}

				if (view.style.left != leftPosition) {
					view.style.left = leftPosition + "";
				}

				if (canCenterHorizontally) {
					transformValue += " translateX(" + translateX+ ")";
				}
			}

			if (self.centerVertically) {
				if (canCenterVertically) {
					translateY = "-50%";
					topPosition = "50%";
				}
				else {
					translateY = "0";
					topPosition = "0";
				}
				
				if (view.style.top != topPosition) {
					view.style.top = topPosition + "";
				}

				if (canCenterVertically) {
					transformValue += " translateY(" + translateY+ ")";
				}
			}

			view.style.transformOrigin = "0 0";
			view.style.transform = transformValue;

			self.viewScale = desiredScale;
			self.viewToFitWidthScale = scaleNeededToFitWidth;
			self.viewToFitHeightScale = scaleNeededToFitHeight;
			self.viewLeft = leftPosition;
			self.viewTop = topPosition;

			return scaleNeededToFitHeight;
		}

		if (scaleToFitType=="fit") {
			//canCenterVertically = scaleNeededToFitHeight>=scaleNeededToFitWidth;
			//canCenterHorizontally = scaleNeededToFitWidth>=scaleNeededToFitHeight;
			canCenterVertically = scaleNeededToFitHeight>=scaleNeededToFit;
			canCenterHorizontally = scaleNeededToFitWidth>=scaleNeededToFit;

			if (hasMinimumScale) {
				desiredScale = Math.max(desiredScale, Number(minimumScale));
			}

			desiredScale = self.getShortNumber(desiredScale);

			if (isSliderChange || scaleToFit==false) {
				canCenterVertically = scaleToFitFullHeight>=desiredScale;
				canCenterHorizontally = desiredScale<scaleToFitFullWidth;
			}
			else if (scaleToFit) {
				desiredScale = scaleNeededToFit;
			}

			transformValue = "scale(" + desiredScale + ")";

			//canCenterHorizontally = self.canCenterHorizontally(view, "fit", false, desiredScale);
			//canCenterVertically = self.canCenterVertically(view, "fit", false, desiredScale);
			
			if (self.centerVertically) {
				if (canCenterVertically) {
					translateY = "-50%";
					topPosition = "50%";
				}
				else {
					translateY = "0";
					topPosition = "0";
				}
				
				if (view.style.top != topPosition) {
					view.style.top = topPosition + "";
				}

				if (canCenterVertically) {
					transformValue += " translateY(" + translateY+ ")";
				}
			}

			if (self.centerHorizontally) {
				if (canCenterHorizontally) {
					translateX = "-50%";
					leftPosition = "50%";
				}
				else {
					translateX = "0";
					leftPosition = "0";
				}

				if (view.style.left != leftPosition) {
					view.style.left = leftPosition + "";
				}

				if (canCenterHorizontally) {
					transformValue += " translateX(" + translateX+ ")";
				}
			}

			view.style.transformOrigin = "0 0";
			view.style.transform = transformValue;

			self.viewScale = desiredScale;
			self.viewToFitWidthScale = scaleNeededToFitWidth;
			self.viewToFitHeightScale = scaleNeededToFitHeight;
			self.viewLeft = leftPosition;
			self.viewTop = topPosition;

			self.updateSliderValue(desiredScale);
			
			return desiredScale;
		}

		if (scaleToFitType=="default" || scaleToFitType=="") {
			desiredScale = 1;

			if (hasMinimumScale) {
				desiredScale = Math.max(desiredScale, Number(minimumScale));
			}
			if (hasMaximumScale) {
				desiredScale = Math.min(desiredScale, Number(maximumScale));
			}

			canCenterHorizontally = self.canCenterHorizontally(view, "none", false, desiredScale, minimumScale, maximumScale);
			canCenterVertically = self.canCenterVertically(view, "none", false, desiredScale, minimumScale, maximumScale);

			if (self.centerVertically) {
				if (canCenterVertically) {
					translateY = "-50%";
					topPosition = "50%";
				}
				else {
					translateY = "0";
					topPosition = "0";
				}
				
				if (view.style.top != topPosition) {
					view.style.top = topPosition + "";
				}

				if (canCenterVertically) {
					transformValue += " translateY(" + translateY+ ")";
				}
			}

			if (self.centerHorizontally) {
				if (canCenterHorizontally) {
					translateX = "-50%";
					leftPosition = "50%";
				}
				else {
					translateX = "0";
					leftPosition = "0";
				}

				if (view.style.left != leftPosition) {
					view.style.left = leftPosition + "";
				}

				if (canCenterHorizontally) {
					transformValue += " translateX(" + translateX+ ")";
				}
				else {
					transformValue += " translateX(" + 0 + ")";
				}
			}

			view.style.transformOrigin = "0 0";
			view.style.transform = transformValue;


			self.viewScale = desiredScale;
			self.viewToFitWidthScale = scaleNeededToFitWidth;
			self.viewToFitHeightScale = scaleNeededToFitHeight;
			self.viewLeft = leftPosition;
			self.viewTop = topPosition;

			self.updateSliderValue(desiredScale);
			
			return desiredScale;
		}
	}

	/**
	 * Returns true if view can be centered horizontally
	 * @param {HTMLElement} view view
	 * @param {String} type type of scaling - width, height, all, none
	 * @param {Boolean} scaleUp if scale up enabled 
	 * @param {Number} scale target scale value 
	 */
	self.canCenterHorizontally = function(view, type, scaleUp, scale, minimumScale, maximumScale) {
		var scaleNeededToFit = self.getViewFitToViewportScale(view, scaleUp);
		var scaleNeededToFitHeight = self.getViewFitToViewportHeightScale(view, scaleUp);
		var scaleNeededToFitWidth = self.getViewFitToViewportWidthScale(view, scaleUp);
		var canCenter = false;
		var minScale;

		type = type==null ? "none" : type;
		scale = scale==null ? scale : scaleNeededToFitWidth;
		scaleUp = scaleUp == null ? false : scaleUp;

		if (type=="width") {
	
			if (scaleUp && maximumScale==null) {
				canCenter = false;
			}
			else if (scaleNeededToFitWidth>=1) {
				canCenter = true;
			}
		}
		else if (type=="height") {
			minScale = Math.min(1, scaleNeededToFitHeight);
			if (minimumScale!="" && maximumScale!="") {
				minScale = Math.max(minimumScale, Math.min(maximumScale, scaleNeededToFitHeight));
			}
			else {
				if (minimumScale!="") {
					minScale = Math.max(minimumScale, scaleNeededToFitHeight);
				}
				if (maximumScale!="") {
					minScale = Math.max(minimumScale, Math.min(maximumScale, scaleNeededToFitHeight));
				}
			}
	
			if (scaleUp && maximumScale=="") {
				canCenter = false;
			}
			else if (scaleNeededToFitWidth>=minScale) {
				canCenter = true;
			}
		}
		else if (type=="fit") {
			canCenter = scaleNeededToFitWidth>=scaleNeededToFit;
		}
		else {
			if (scaleUp) {
				canCenter = false;
			}
			else if (scaleNeededToFitWidth>=1) {
				canCenter = true;
			}
		}

		self.horizontalScrollbarsNeeded = canCenter;
		
		return canCenter;
	}

	/**
	 * Returns true if view can be centered horizontally
	 * @param {HTMLElement} view view to scale
	 * @param {String} type type of scaling
	 * @param {Boolean} scaleUp if scale up enabled 
	 * @param {Number} scale target scale value 
	 */
	self.canCenterVertically = function(view, type, scaleUp, scale, minimumScale, maximumScale) {
		var scaleNeededToFit = self.getViewFitToViewportScale(view, scaleUp);
		var scaleNeededToFitWidth = self.getViewFitToViewportWidthScale(view, scaleUp);
		var scaleNeededToFitHeight = self.getViewFitToViewportHeightScale(view, scaleUp);
		var canCenter = false;
		var minScale;

		type = type==null ? "none" : type;
		scale = scale==null ? 1 : scale;
		scaleUp = scaleUp == null ? false : scaleUp;
	
		if (type=="width") {
			canCenter = scaleNeededToFitHeight>=scaleNeededToFitWidth;
		}
		else if (type=="height") {
			minScale = Math.max(minimumScale, Math.min(maximumScale, scaleNeededToFit));
			canCenter = scaleNeededToFitHeight>=minScale;
		}
		else if (type=="fit") {
			canCenter = scaleNeededToFitHeight>=scaleNeededToFit;
		}
		else {
			if (scaleUp) {
				canCenter = false;
			}
			else if (scaleNeededToFitHeight>=1) {
				canCenter = true;
			}
		}

		self.verticalScrollbarsNeeded = canCenter;
		
		return canCenter;
	}

	self.getViewFitToViewportScale = function(view, scaleUp) {
		var enableScaleUp = scaleUp;
		var availableWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
		var availableHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
		var elementWidth = parseFloat(getComputedStyle(view, "style").width);
		var elementHeight = parseFloat(getComputedStyle(view, "style").height);
		var newScale = 1;

		// if element is not added to the document computed values are NaN
		if (isNaN(elementWidth) || isNaN(elementHeight)) {
			return newScale;
		}

		availableWidth -= self.horizontalPadding;
		availableHeight -= self.verticalPadding;

		if (enableScaleUp) {
			newScale = Math.min(availableHeight/elementHeight, availableWidth/elementWidth);
		}
		else if (elementWidth > availableWidth || elementHeight > availableHeight) {
			newScale = Math.min(availableHeight/elementHeight, availableWidth/elementWidth);
		}
		
		return newScale;
	}

	self.getViewFitToViewportWidthScale = function(view, scaleUp) {
		// need to get browser viewport width when element
		var isParentWindow = view && view.parentNode && view.parentNode===document.body;
		var enableScaleUp = scaleUp;
		var availableWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
		var elementWidth = parseFloat(getComputedStyle(view, "style").width);
		var newScale = 1;

		// if element is not added to the document computed values are NaN
		if (isNaN(elementWidth)) {
			return newScale;
		}

		availableWidth -= self.horizontalPadding;

		if (enableScaleUp) {
			newScale = availableWidth/elementWidth;
		}
		else if (elementWidth > availableWidth) {
			newScale = availableWidth/elementWidth;
		}
		
		return newScale;
	}

	self.getViewFitToViewportHeightScale = function(view, scaleUp) {
		var enableScaleUp = scaleUp;
		var availableHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
		var elementHeight = parseFloat(getComputedStyle(view, "style").height);
		var newScale = 1;

		// if element is not added to the document computed values are NaN
		if (isNaN(elementHeight)) {
			return newScale;
		}

		availableHeight -= self.verticalPadding;

		if (enableScaleUp) {
			newScale = availableHeight/elementHeight;
		}
		else if (elementHeight > availableHeight) {
			newScale = availableHeight/elementHeight;
		}
		
		return newScale;
	}

	self.keypressHandler = function(event) {
		var rightKey = 39;
		var leftKey = 37;
		
		// listen for both events 
		if (event.type=="keypress") {
			window.removeEventListener("keyup", self.keypressHandler);
		}
		else {
			window.removeEventListener("keypress", self.keypressHandler);
		}
		
		if (self.showNavigationControls) {
			if (self.navigationOnKeypress) {
				if (event.keyCode==rightKey) {
					self.nextView();
				}
				if (event.keyCode==leftKey) {
					self.previousView();
				}
			}
		}
		else if (self.navigationOnKeypress) {
			if (event.keyCode==rightKey) {
				self.nextView();
			}
			if (event.keyCode==leftKey) {
				self.previousView();
			}
		}
	}

	///////////////////////////////////
	// GENERAL FUNCTIONS
	///////////////////////////////////

	self.getViewById = function(id) {
		id = id ? id.replace("#", "") : "";
		var view = self.viewIds.indexOf(id)!=-1 && self.getElement(id);
		return view;
	}

	self.getViewIds = function() {
		var viewIds = self.getViewPreferenceValue(document.body, self.prefix + "view-ids");
		var viewId = null;

		viewIds = viewIds!=null && viewIds!="" ? viewIds.split(",") : [];

		if (viewIds.length==0) {
			viewId = self.getViewPreferenceValue(document.body, self.prefix + "view-id");
			viewIds = viewId ? [viewId] : [];
		}

		return viewIds;
	}

	self.getInitialViewId = function() {
		var viewId = self.getViewPreferenceValue(document.body, self.prefix + "view-id");
		return viewId;
	}

	self.getApplicationStylesheet = function() {
		var stylesheetId = self.getViewPreferenceValue(document.body, self.prefix + "stylesheet-id");
		self.applicationStylesheet = document.getElementById("applicationStylesheet");
		return self.applicationStylesheet.sheet;
	}

	self.getVisibleView = function() {
		var viewIds = self.getViewIds();
		
		for (var i=0;i<viewIds.length;i++) {
			var view = self.getElement(viewId);
			var postName = "_Class";

			if (view==null && viewId && viewId.lastIndexOf(postName)!=-1) {
				view = self.getElement(viewId.replace(postName, ""));
			}
			
			if (view) {
				var display = getComputedStyle(view).display;
		
				if (display=="block" || display=="flex") {
					return view;
				}
			}
		}

		return null;
	}

	self.getVisibleViews = function() {
		var viewIds = self.getViewIds();
		var views = [];
		
		for (var i=0;i<viewIds.length;i++) {
			var view = self.getElement(viewId);
			var postName = "_Class";

			if (view==null && viewId && viewId.lastIndexOf(postName)!=-1) {
				view = self.getElement(viewId.replace(postName, ""));
			}
			
			if (view) {
				var display = getComputedStyle(view).display;
				
				if (display=="none") {
					continue;
				}

				if (display=="block" || display=="flex") {
					views.push(view);
				}
			}
		}

		return views;
	}

	self.getStateNameByViewId = function(id) {
		var state = self.viewsDictionary[id];
		return state && state.stateName;
	}

	self.getMatchingViews = function(ids) {
		var views = self.addedViews.slice(0);
		var matchingViews = [];

		if (self.showByMediaQuery) {
			for (let index = 0; index < views.length; index++) {
				var viewId = views[index];
				var state = self.viewsDictionary[viewId];
				var rule = state && state.rule; 
				var matchResults = window.matchMedia(rule.conditionText);
				var view = self.views[viewId];
				
				if (matchResults.matches) {
					if (ids==true) {
						matchingViews.push(viewId);
					}
					else {
						matchingViews.push(view);
					}
				}
			}
		}

		return matchingViews;
	}

	self.ruleMatchesQuery = function(rule) {
		var result = window.matchMedia(rule.conditionText);
		return result.matches;
	}

	self.getViewsByStateName = function(stateName, matchQuery) {
		var views = self.addedViews.slice(0);
		var matchingViews = [];

		if (self.showByMediaQuery) {

			// find state name
			for (let index = 0; index < views.length; index++) {
				var viewId = views[index];
				var state = self.viewsDictionary[viewId];
				var rule = state.rule;
				var mediaRule = state.mediaRule;
				var view = self.views[viewId];
				var viewStateName = self.getStyleRuleValue(mediaRule, self.STATE_NAME, state);
				var stateFoundAtt = view.getAttribute(self.STATE_NAME)==state;
				var matchesResults = false;
				
				if (viewStateName==stateName) {
					if (matchQuery) {
						matchesResults = self.ruleMatchesQuery(rule);

						if (matchesResults) {
							matchingViews.push(view);
						}
					}
					else {
						matchingViews.push(view);
					}
				}
			}
		}

		return matchingViews;
	}

	self.getInitialView = function() {
		var viewId = self.getInitialViewId();
		var view = self.getElement(viewId);
		var postName = "_Class";

		if (view==null && viewId && viewId.lastIndexOf(postName)!=-1) {
			view = self.getElement(viewId.replace(postName, ""));
		}

		return view;
	}

	self.getViewIndex = function(view) {
		var viewIds = self.getViewIds();
		var id = view ? view.id : null;
		var index = id && viewIds ? viewIds.indexOf(id) : -1;

		return index;
	}

	self.syncronizeViewToURL = function() {
		var fragment = self.getHashFragment();

		if (self.showByMediaQuery) {
			var stateName = fragment;
			
			if (stateName==null || stateName=="") {
				var initialView = self.getInitialView();
				stateName = initialView ? self.getStateNameByViewId(initialView.id) : null;
			}
			
			self.showMediaQueryViewsByState(stateName);
			return;
		}

		var view = self.getViewById(fragment);
		var index = view ? self.getViewIndex(view) : 0;
		if (index==-1) index = 0;
		var currentView = self.hideViews(index);

		if (self.supportsPopState && currentView) {

			if (fragment==null) {
				window.history.replaceState({name:currentView.id}, null, "#"+ currentView.id);
			}
			else {
				window.history.pushState({name:currentView.id}, null, "#"+ currentView.id);
			}
		}
		
		self.setViewVariables(view);
		return view;
	}

	/**
	 * Set the currentView or currentOverlay properties and set the lastView or lastOverlay properties
	 */
	self.setViewVariables = function(view, overlay, parentView) {
		if (view) {
			if (self.currentView) {
				self.lastView = self.currentView;
			}
			self.currentView = view;
		}

		if (overlay) {
			if (self.currentOverlay) {
				self.lastOverlay = self.currentOverlay;
			}
			self.currentOverlay = overlay;
		}
	}

	self.getViewPreferenceBoolean = function(view, property, altValue) {
		var computedStyle = window.getComputedStyle(view);
		var value = computedStyle.getPropertyValue(property);
		var type = typeof value;
		
		if (value=="true" || (type=="string" && value.indexOf("true")!=-1)) {
			return true;
		}
		else if (value=="" && arguments.length==3) {
			return altValue;
		}

		return false;
	}

	self.getViewPreferenceValue = function(view, property, defaultValue) {
		var value = window.getComputedStyle(view).getPropertyValue(property);

		if (value===undefined) {
			return defaultValue;
		}
		
		value = value.replace(/^[\s\"]*/, "");
		{ 
			return capture;
		});

		return value;
	}

	self.getStyleRuleValue = function(cssRule, property) {
		var value = cssRule ? cssRule.style.getPropertyValue(property) : null;

		if (value===undefined) {
			return null;
		}
		
		value = value.replace(/^[\s\"]*/, ""); { 
			return capture;
		});

		return value;
	}

	self.getCSSPropertyValueForElement = function(id, property) {
		var styleSheets = document.styleSheets;
		var numOfStylesheets = styleSheets.length;
		var values = [];
		var selectorIDText = "#" + id;
		var selectorClassText = "." + id + "_Class";
		var value;

		for(var i=0;i<numOfStylesheets;i++) {
			var styleSheet = styleSheets[i];
			var cssRules = self.getStylesheetRules(styleSheet);
			var numOfCSSRules = cssRules.length;
			var cssRule;
			
			for (var j=0;j<numOfCSSRules;j++) {
				cssRule = cssRules[j];
				
				if (cssRule.media) {
					var mediaRules = cssRule.cssRules;
					var numOfMediaRules = mediaRules ? mediaRules.length : 0;
					
					for(var k=0;k<numOfMediaRules;k++) {
						var mediaRule = mediaRules[k];
						
						if (mediaRule.selectorText==selectorIDText || mediaRule.selectorText==selectorClassText) {
							
							if (mediaRule.style && property in mediaRule.style) {
								value = mediaRule.style.getPropertyValue(property);
								values.push(value);
							}
						}
					}
				}
				else {

					if (cssRule.selectorText==selectorIDText || cssRule.selectorText==selectorClassText) {
						if (cssRule.style && property in cssRule.style) {
							value = cssRule.style.getPropertyValue(property);
							values.push(value);
						}
					}
				}
			}
		}
		
		return values.pop();
	}

	self.collectViews = function() {
		var viewIds = self.getViewIds();

		for (let index = 0; index < viewIds.length; index++) {
			const id = viewIds[index];
			const view = self.getElement(id);
			//view && view.addEventListener("animationend", self.animationEndHandler);
			self.views[id] = view;
		}
		
		self.viewIds = viewIds;
	}

	self.collectOverlays = function() {
		var viewIds = self.getViewIds();
		var ids = [];

		for (let index = 0; index < viewIds.length; index++) {
			const id = viewIds[index];
			const view = self.getViewById(id);
			const isOverlay = view && self.isOverlay(view);
			
			if (isOverlay) {
				ids.push(id);
				self.overlays[id] = view;
			}
		}
		
		self.overlayIds = ids;
	}

	self.collectMediaQueries = function() {
		var viewIds = self.getViewIds();
		var styleSheet = self.getApplicationStylesheet();
		var cssRules = self.getStylesheetRules(styleSheet);
		var numOfCSSRules = cssRules ? cssRules.length : 0;
		var cssRule;
		var id = viewIds.length ? viewIds[0]: ""; // single view
		var selectorIDText = "#" + id;
		var selectorClassText = "." + id + "_Class";
		var viewsNotFound = viewIds.slice();
		var viewsFound = [];
		var selectorText = null;
		var property = self.prefix + "view-id";
		var stateName = self.prefix + "state";
		var stateValue;
		
		for (var j=0;j<numOfCSSRules;j++) {
			cssRule = cssRules[j];
			
			if (cssRule.media) {
				var mediaRules = cssRule.cssRules;
				var numOfMediaRules = mediaRules ? mediaRules.length : 0;
				
				for(var k=0;k<numOfMediaRules;k++) {
					var mediaRule = mediaRules[k];
					var mediaId = null;

					selectorText = mediaRule.selectorText;
					
					if (selectorText==".mediaViewInfo") {

						mediaId = self.getStyleRuleValue(mediaRule, property);
						stateValue = self.getStyleRuleValue(mediaRule, stateName);

						// prevent duplicates from load and domcontentloaded events
						if (self.addedViews.indexOf(mediaId)==-1) {
							self.addView(mediaId, cssRule, mediaRule, stateValue);
						}

						viewsFound.push(mediaId);

						if (viewsNotFound.indexOf(mediaId)!=-1) {
							viewsNotFound.splice(viewsNotFound.indexOf(mediaId));
						}

						break;
					}
				}
			}
			else {
				selectorText = cssRule.selectorText.replace(/[#|\s|*]?/g, "");

				if (viewIds.indexOf(selectorText)!=-1) {
					//stateValue = self.getStyleRuleValue(cssRule, stateName);
					self.addView(selectorText, cssRule, null, stateValue);

					if (viewsNotFound.indexOf(selectorText)!=-1) {
						viewsNotFound.splice(viewsNotFound.indexOf(selectorText));
					}

					break;
				}
			}
		}

		if (viewsNotFound.length) {
			console.log("Could not find the following views:" + viewsNotFound.join(",") + "");
			console.log("Views found:" + viewsFound.join(",") + "");
		}
	}

	/**
	 * Adds a view. A view object contains the id of the view and the style rule
	 * Use enableMediaQuery(rule) to enable
	 * An array of view names are in self.addedViews array
	 */
	self.addView = function(viewId, cssRule, mediaRule, stateName) {
		var state = {name:viewId, rule:cssRule, id:viewId, mediaRule:mediaRule, stateName:stateName};
		self.addedViews.push(viewId);
		self.viewsDictionary[viewId] = state;
		self.mediaQueryDictionary[viewId] = cssRule;
	}

	self.hasView = function(name) {

		if (self.addedViews.indexOf(name)!=-1) {
			return true;
		}
		return false;
	}

	/**
	 * Go to view by id. Views are added in addView()
	 * @param {String} id id of view in current
	 * @param {Boolean} maintainPreviousState if true then do not hide other views
	 * @param {String} parent id of parent view
	 */
	self.goToView = function(id, maintainPreviousState, parent) {
		var state = self.viewsDictionary[id];

		if (state) {
			if (maintainPreviousState==false || maintainPreviousState==null) {
				self.hideViews();
			}
			self.enableMediaQuery(state.rule);
			self.updateViewLabel();
			self.updateURL();
		}
		else {
			var event = new Event(self.STATE_NOT_FOUND);
			self.stateName = id;
			window.dispatchEvent(event);
		}
	}

	/**
	 * Go to the view in the event targets CSS variable
	 */
	self.goToTargetView = function(event) {
		var button = event.currentTarget;
		var buttonComputedStyles = getComputedStyle(button);
		var actionTargetValue = buttonComputedStyles.getPropertyValue(self.prefix+"action-target").trim();
		var animation = buttonComputedStyles.getPropertyValue(self.prefix+"animation").trim();
		var targetType = buttonComputedStyles.getPropertyValue(self.prefix+"action-type").trim();
		var targetView = self.application ? null : self.getElement(actionTargetValue);
		var targetState = self.getStateNameByViewId(targetView.id);
		var actionTargetStyles = targetView ? targetView.style : null;
		var state = self.viewsDictionary[actionTargetValue];
		
		// navigate to page
		if (self.application==false || targetType=="page") {
			document.location.href = "./" + actionTargetValue;
			return;
		}

		// if view is found
		if (targetView) {

			if (self.currentOverlay) {
				self.removeOverlay(false);
			}

			if (self.showByMediaQuery) {
				var stateName = targetState;
				
				if (stateName==null || stateName=="") {
					var initialView = self.getInitialView();
					stateName = initialView ? self.getStateNameByViewId(initialView.id) : null;
				}
				self.showMediaQueryViewsByState(stateName, event);
				return;
			}

			// add animation set in event target style declaration
			if (animation && self.supportAnimations) {
				self.crossFade(self.currentView, targetView, false, animation);
			}
			else {
				self.setViewVariables(self.currentView);
				self.hideViews();
				self.enableMediaQuery(state.rule);
				self.scaleViewIfNeeded(targetView);
				self.centerView(targetView);
				self.updateViewLabel();
				self.updateURL();
			}
		}
		else {
			var stateEvent = new Event(self.STATE_NOT_FOUND);
			self.stateName = name;
			window.dispatchEvent(stateEvent);
		}

		event.stopImmediatePropagation();
	}

	/**
	 * Cross fade between views
	 **/
	self.crossFade = function(from, to, update, animation) {
		var targetIndex = to.parentNode
		var fromIndex = Array.prototype.slice.call(from.parentElement.children).indexOf(from);
		var toIndex = Array.prototype.slice.call(to.parentElement.children).indexOf(to);

		if (from.parentNode==to.parentNode) {
			var reverse = self.getReverseAnimation(animation);
			var duration = self.getAnimationDuration(animation, true);

			// if target view is above (higher index)
			// then fade in target view 
			// and after fade in then hide previous view instantly
			if (fromIndex<toIndex) {
				self.setElementAnimation(from, null);
				self.setElementAnimation(to, null);
				self.showViewByMediaQuery(to);
				self.fadeIn(to, update, animation);

				setTimeout(function() {
					self.setElementAnimation(to, null);
					self.setElementAnimation(from, null);
					self.hideView(from);
					self.updateURL();
					self.setViewVariables(to);
					self.updateViewLabel();
				}, duration)
			}
			// if target view is on bottom
			// then show target view instantly 
			// and fade out current view
			else if (fromIndex>toIndex) {
				self.setElementAnimation(to, null);
				self.setElementAnimation(from, null);
				self.showViewByMediaQuery(to);
				self.fadeOut(from, update, reverse);

				setTimeout(function() {
					self.setElementAnimation(to, null);
					self.setElementAnimation(from, null);
					self.hideView(from);
					self.updateURL();
					self.setViewVariables(to);
				}, duration)
			}
		}
	}

	self.fadeIn = function(element, update, animation) {
		self.showViewByMediaQuery(element);

		if (update) {
			self.updateURL(element);

			element.addEventListener("animationend", function(event) {
				element.style.animation = null;
				self.setViewVariables(element);
				self.updateViewLabel();
				element.removeEventListener("animationend", arguments.callee);
			});
		}

		self.setElementAnimation(element, null);
		
		element.style.animation = animation;
	}

	self.fadeOutCurrentView = function(animation, update) {
		if (self.currentView) {
			self.fadeOut(self.currentView, update, animation);
		}
		if (self.currentOverlay) {
			self.fadeOut(self.currentOverlay, update, animation);
		}
	}

	self.fadeOut = function(element, update, animation) {
		if (update) {
			element.addEventListener("animationend", function(event) {
				element.style.animation = null;
				self.hideView(element);
				element.removeEventListener("animationend", arguments.callee);
			});
		}

		element.style.animationPlayState = "paused";
		element.style.animation = animation;
		element.style.animationPlayState = "running";
	}

	self.getReverseAnimation = function(animation) {
		if (animation && animation.indexOf("reverse")==-1) {
			animation += " reverse";
		}

		return animation;
	}

	/**
	 * Get duration in animation string
	 * @param {String} animation animation value
	 * @param {Boolean} inMilliseconds length in milliseconds if true
	 */
	self.getAnimationDuration = function(animation, inMilliseconds) {
		var duration = 0;
		var expression = /.+(\d\.\d)s.+/;

		if (animation && animation.match(expression)) {
			if (duration && inMilliseconds) duration = duration * 1000;
		}

		return duration;
	}

	self.setElementAnimation = function(element, animation, priority) {
		element.style.setProperty("animation", animation, "important");
	}

	self.getElement = function(id) {
		var elementId = id ? id.trim() : id;
		var element = elementId ? document.getElementById(elementId) : null;

		return element;
	}

	self.resizeHandler = function(event) {
		
		if (self.showByMediaQuery) {
			if (self.enableDeepLinking) {
				var stateName = self.getHashFragment();

				if (stateName==null || stateName=="") {
					var initialView = self.getInitialView();
					stateName = initialView ? self.getStateNameByViewId(initialView.id) : null;
				}
				self.showMediaQueryViewsByState(stateName, event);
			}
		}
		else {
			var visibleViews = self.getVisibleViews();

			for (let index = 0; index < visibleViews.length; index++) {	
				self.scaleViewIfNeeded();
			}
		}

		window.dispatchEvent(new Event(self.APPLICATION_RESIZE));
	}

	self.scaleViewIfNeeded = function(view) {

		if (self.scaleViewsOnResize) {
			if (view==null) {
				view = self.getVisibleView();
			}

			var isViewScaled = view.getAttributeNS(null, self.SIZE_STATE_NAME)=="false" ? false : true;

			if (isViewScaled) {
				self.scaleViewToFit(view, true);
			}
			else {
				self.scaleViewToActualSize(view);
			}
		}
		else if (view) {
			self.centerView(view);
		}
	}

	self.centerView = function(view) {

		if (self.scaleToFit) {
			self.scaleViewToFit(view, true);
		}
		else {
			self.scaleViewToActualSize(view);  // for centering support for now
		}
	}

	self.preventDoubleClick = function(event) {
		event.stopImmediatePropagation();
	}

	self.getHashFragment = function() {
		var value = window.location.hash ? window.location.hash.replace("#", "") : "";
		return value;
	}

	self.showBlockElement = function(view) {
		view.style.display = "block";
	}

	self.hideElement = function(view) {
		view.style.display = "none";
	}

	self.showStateFunction = null;

	self.showMediaQueryViewsByState = function(state, event) {
		// browser will hide and show by media query (small, medium, large)
		// but if multiple views exists at same size user may want specific view
		// if showStateFunction is defined that is called with state fragment and user can show or hide each media matching view by returning true or false
		// if showStateFunction is not defined and state is defined and view has a defined state that matches then show that and hide other matching views
		// if no state is defined show view 
		// an viewChanging event is dispatched before views are shown or hidden that can be prevented 

		// get all matched queries
		// if state name is specified then show that view and hide other views
		// if no state name is defined then show
		var matchedViews = self.getMatchingViews();
		var matchMediaQuery = true;
		var foundViews = self.getViewsByStateName(state, matchMediaQuery);
		var showViews = [];
		var hideViews = [];

		// loop views that match media query 
		for (let index = 0; index < matchedViews.length; index++) {
			var view = matchedViews[index];
			
			// let user determine visible view
			if (self.showStateFunction!=null) {
				if (self.showStateFunction(view, state)) {
					showViews.push(view);
				}
				else {
					hideViews.push(view);
				}
			}
			// state was defined so check if view matches state
			else if (foundViews.length) {

				if (foundViews.indexOf(view)!=-1) {
					showViews.push(view);
				}
				else {
					hideViews.push(view);
				}
			}
			// if no state names are defined show view (define unused state name to exclude)
			else if (state==null || state=="") {
				showViews.push(view);
			}
		}

		if (showViews.length) {
			var viewChangingEvent = new Event(self.VIEW_CHANGING);
			viewChangingEvent.showViews = showViews;
			viewChangingEvent.hideViews = hideViews;
			window.dispatchEvent(viewChangingEvent);

			if (viewChangingEvent.defaultPrevented==false) {
				for (var index = 0; index < hideViews.length; index++) {
					var view = hideViews[index];
					self.hideElement(view);
				}

				for (var index = 0; index < showViews.length; index++) {
					var view = showViews[index];

					if (index==showViews.length-1) {
						self.clearDisplay(view);
						self.setViewOptions(view);
						self.setViewVariables(view);
						self.centerView(view);
						self.updateURLState(view, state);
					}
				}
			}

			var viewChangeEvent = new Event(self.VIEW_CHANGE);
			viewChangeEvent.showViews = showViews;
			viewChangeEvent.hideViews = hideViews;
			window.dispatchEvent(viewChangeEvent);
		}
		
	}

	self.clearDisplay = function(view) {
		view.style.setProperty("display", null);
	}

	self.hashChangeHandler = function(event) {
		var fragment = self.getHashFragment();
		var view = self.getViewById(fragment);

		if (self.showByMediaQuery) {
			var stateName = fragment;

			if (stateName==null || stateName=="") {
				var initialView = self.getInitialView();
				stateName = initialView ? self.getStateNameByViewId(initialView.id) : null;
			}
			self.showMediaQueryViewsByState(stateName);
		}
		else {
			if (view) {
				self.hideViews();
				self.showView(view);
				self.setViewVariables(view);
				self.updateViewLabel();
				
				window.dispatchEvent(new Event(self.VIEW_CHANGE));
			}
			else {
				window.dispatchEvent(new Event(self.VIEW_NOT_FOUND));
			}
		}
	}

	self.popStateHandler = function(event) {
		var state = event.state;
		var fragment = state ? state.name : window.location.hash;
		var view = self.getViewById(fragment);

		if (view) {
			self.hideViews();
			self.showView(view);
			self.updateViewLabel();
		}
		else {
			window.dispatchEvent(new Event(self.VIEW_NOT_FOUND));
		}
	}

	self.doubleClickHandler = function(event) {
		var view = self.getVisibleView();
		var scaleValue = view ? self.getViewScaleValue(view) : 1;
		var scaleNeededToFit = view ? self.getViewFitToViewportScale(view) : 1;
		var scaleNeededToFitWidth = view ? self.getViewFitToViewportWidthScale(view) : 1;
		var scaleNeededToFitHeight = view ? self.getViewFitToViewportHeightScale(view) : 1;
		var scaleToFitType = self.scaleToFitType;

		// Three scenarios
		// - scale to fit on double click
		// - set scale to actual size on double click
		// - switch between scale to fit and actual page size

		if (scaleToFitType=="width") {
			scaleNeededToFit = scaleNeededToFitWidth;
		}
		else if (scaleToFitType=="height") {
			scaleNeededToFit = scaleNeededToFitHeight;
		}

		// if scale and actual size enabled then switch between
		if (self.scaleToFitOnDoubleClick && self.actualSizeOnDoubleClick) {
			var isViewScaled = view.getAttributeNS(null, self.SIZE_STATE_NAME);
			var isScaled = false;
			
			// if scale is not 1 then view needs scaling
			if (scaleNeededToFit!=1) {

				// if current scale is at 1 it is at actual size
				// scale it to fit
				if (scaleValue==1) {
					self.scaleViewToFit(view);
					isScaled = true;
				}
				else {
					// scale is not at 1 so switch to actual size
					self.scaleViewToActualSize(view);
					isScaled = false;
				}
			}
			else {
				// view is smaller than viewport 
				// so scale to fit() is scale actual size
				// actual size and scaled size are the same
				// but call scale to fit to retain centering
				self.scaleViewToFit(view);
				isScaled = false;
			}
			
			view.setAttributeNS(null, self.SIZE_STATE_NAME, isScaled+"");
			isViewScaled = view.getAttributeNS(null, self.SIZE_STATE_NAME);
		}
		else if (self.scaleToFitOnDoubleClick) {
			self.scaleViewToFit(view);
		}
		else if (self.actualSizeOnDoubleClick) {
			self.scaleViewToActualSize(view);
		}

	}

	self.scaleViewToFit = function(view) {
		return self.setViewScaleValue(view, true);
	}

	self.scaleViewToActualSize = function(view) {
		self.setViewScaleValue(view, false, 1);
	}

	self.onloadHandler = function(event) {
		self.initialize();
	}

	self.setElementHTML = function(id, value) {
		var element = self.getElement(id);
		element.innerHTML = value;
	}

	self.getStackArray = function(error) {
		var value = "";
		
		if (error==null) {
		  try {
			 error = new Error("Stack");
		  }
		  catch (e) {
			 
		  }
		}
		
		if ("stack" in error) {
		  value = error.stack;
		  var methods = value.split(/\n/g);
	 
		  var newArray = methods ? methods.map(function (value, index, array) {
			 value = value.replace(/\@.*/,"");
			 return value;
		  }) : null;
	 
		  if (newArray && newArray[0].includes("getStackTrace")) {
			 newArray.shift();
		  }
		  if (newArray && newArray[0].includes("getStackArray")) {
			 newArray.shift();
		  }
		  if (newArray && newArray[0]=="") {
			 newArray.shift();
		  }
	 
			return newArray;
		}
		
		return null;
	}

	self.log = function(value) {
		console.log.apply(this, [value]);
	}
	
	// initialize on load
	// sometimes the body size is 0 so we call this now and again later
	window.addEventListener("load", self.onloadHandler);
	window.document.addEventListener("DOMContentLoaded", self.onloadHandler);
}

window.application = new Application();
</script>
</head>
<body>
<div id="Web_1920__1">
	<div id="Componente_1__1" class="Componente_1___1">
		<svg class="Rectngulo_21">
			<rect id="Rectngulo_21" rx="10" ry="10" x="0" y="0" width="416" height="675">
			</rect>
		</svg>
		<svg class="Rectngulo_1">
			<rect id="Rectngulo_1" rx="10" ry="10" x="0" y="0" width="998" height="127">
			</rect>
		</svg>
		<img id="logo" src="logo.png" srcset="logo.png 1x, logo@2x.png 2x">
		<svg class="Lnea_1" viewBox="0 0 1 126">
			<path id="Lnea_1" d="M 0 0 L 0 126">
			</path>
		</svg>
		<div id="HOJA_DE_CAMPO_PARA_OBSERVACION">
			<span>HOJA DE CAMPO PARA OBSERVACIONES CON GPS</span>
		</div>
		<svg class="Lnea_2" viewBox="0 0 1 126">
			<path id="Lnea_2" d="M 0 0 L 0 126">
			</path>
		</svg>
		<div id="fecha">
			<span>fecha</span>
		</div>
		<div id="AO-MES-DA">
			<span style="text-transform:uppercase;">A</span><span style="text-transform:lowercase;">ÑO-</span><span style="text-transform:uppercase;">M</span><span style="text-transform:lowercase;">ES-</span><span style="text-transform:uppercase;">D</span><span style="text-transform:lowercase;">ÍA</span>
		</div>
		<div id="ID2020-05-25">
			<span>2020-05-25</span>
		</div>
		<svg class="Lnea_3" viewBox="0 0 256 1">
			<path id="Lnea_3" d="M 0 0 L 256 0">
			</path>
		</svg>
		<svg class="Lnea_4" viewBox="0 0 256 1">
			<path id="Lnea_4" d="M 0 0 L 256 0">
			</path>
		</svg>
		<svg class="Rectngulo_2">
			<rect id="Rectngulo_2" rx="10" ry="10" x="0" y="0" width="998" height="104">
			</rect>
		</svg>
		<svg class="Lnea_5" viewBox="0 0 741 1">
			<path id="Lnea_5" d="M 0 0 L 741 0">
			</path>
		</svg>
		<div id="Nomenclatura">
			<span style="text-transform:uppercase;">Código</span><span style="text-transform:lowercase;">:</span>
		</div>
		<div id="Nomenclatura_v">
			<span>DIGAMOS QUE EL DE LA UNIVERSIDAD 20171732002</span>
		</div>
		<div id="Nomenclatura_w">
			<span style="text-transform:uppercase;">PROYECTO</span><span style="text-transform:lowercase;">:</span>
		</div>
		<div id="Nomenclatura_x">
			<span>PROYECTO CURRICULAR DE ING TOPOGRÁFICA SOCIO JAJAJA</span>
		</div>
		<svg class="Lnea_6" viewBox="0 0 1 126">
			<path id="Lnea_6" d="M 0 0 L 0 126">
			</path>
		</svg>
		<svg class="Lnea_7" viewBox="0 0 1 126">
			<path id="Lnea_7" d="M 0 0 L 0 126">
			</path>
		</svg>
		<div id="Nomenclatura_">
			<span>PUNTO:</span>
		</div>
		<div id="Nomenclatura_ba">
			<span>GPS ÑAÑAI 2 rick Sanchez rick Sanchez rick Sanchez</span>
		</div>
		<svg class="Rectngulo_3">
			<rect id="Rectngulo_3" rx="10" ry="10" x="0" y="0" width="577" height="111">
			</rect>
		</svg>
		<div id="Nomenclatura_bb">
			<span>TIPO DE LEVANTAMIENTO</span>
		</div>
		<svg class="Lnea_8" viewBox="0 0 576 1">
			<path id="Lnea_8" d="M 0 0 L 576 0">
			</path>
		</svg>
		<div id="Nomenclatura_bc">
			<span>Estático</span>
		</div>
		<svg class="Rectngulo_4">
			<rect id="Rectngulo_4" rx="0" ry="0" x="0" y="0" width="54" height="34">
			</rect>
		</svg>
		<div id="Nomenclatura_bd">
			<span>Cinemático</span>
		</div>
		<svg class="Rectngulo_5">
			<rect id="Rectngulo_5" rx="0" ry="0" x="0" y="0" width="54" height="34">
			</rect>
		</svg>
		<div id="Nomenclatura_be">
			<span>Rápido Estático</span>
		</div>
		<svg class="Rectngulo_6">
			<rect id="Rectngulo_6" rx="0" ry="0" x="0" y="0" width="54" height="34">
			</rect>
		</svg>
		<svg class="Rectngulo_7">
			<rect id="Rectngulo_7" rx="10" ry="10" x="0" y="0" width="417" height="111">
			</rect>
		</svg>
		<svg class="Lnea_9" viewBox="0 0 416 1">
			<path id="Lnea_9" d="M 0 0 L 416 0">
			</path>
		</svg>
		<div id="Nomenclatura_bf">
			<span>TIPO DE PUNTO</span>
		</div>
		<div id="Nomenclatura_bg">
			<span>Base</span>
		</div>
		<svg class="Rectngulo_8">
			<rect id="Rectngulo_8" rx="0" ry="0" x="0" y="0" width="54" height="34">
			</rect>
		</svg>
		<div id="Nomenclatura_bh">
			<span>Móvil</span>
		</div>
		<svg class="Rectngulo_9">
			<rect id="Rectngulo_9" rx="0" ry="0" x="0" y="0" width="54" height="34">
			</rect>
		</svg>
		<svg class="Rectngulo_10">
			<rect id="Rectngulo_10" rx="10" ry="10" x="0" y="0" width="577" height="148">
			</rect>
		</svg>
		<div id="Nomenclatura_bj">
			<span>EQUIPO</span>
		</div>
		<svg class="Lnea_10" viewBox="0 0 576 1">
			<path id="Lnea_10" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_11" viewBox="0 0 576 1">
			<path id="Lnea_11" d="M 0 0 L 576 0">
			</path>
		</svg>
		<div id="Nomenclatura_bm">
			<span>Marca</span>
		</div>
		<div id="Nomenclatura_bn">
			<span style="text-transform:uppercase;">R</span><span style="text-transform:capitalize;">eceptor</span>
		</div>
		<div id="Nomenclatura_bo">
			<span>Modelo</span>
		</div>
		<div id="Nomenclatura_bp">
			<span>Serial</span>
		</div>
		<svg class="Lnea_12" viewBox="0 0 576 1">
			<path id="Lnea_12" d="M 0 0 L 576 0">
			</path>
		</svg>
		<div id="Nomenclatura_br">
			<span style="text-transform:uppercase;">A</span><span style="text-transform:capitalize;">ntena</span>
		</div>
		<svg class="Lnea_13" viewBox="0 0 1 120">
			<path id="Lnea_13" d="M 0 0 L 0 120">
			</path>
		</svg>
		<svg class="Lnea_14" viewBox="0 0 1 120">
			<path id="Lnea_14" d="M 0 0 L 0 120">
			</path>
		</svg>
		<svg class="Lnea_15" viewBox="0 0 1 120">
			<path id="Lnea_15" d="M 0 0 L 0 120">
			</path>
		</svg>
		<svg class="Rectngulo_11">
			<rect id="Rectngulo_11" rx="10" ry="10" x="0" y="0" width="417" height="149">
			</rect>
		</svg>
		<div id="Nomenclatura_bw">
			<span>OPERADOR</span>
		</div>
		<svg class="Lnea_16" viewBox="0 0 416 1">
			<path id="Lnea_16" d="M 0 0 L 416 0">
			</path>
		</svg>
		<div id="Nomenclatura_by">
			<span>Nombre:</span>
		</div>
		<div id="Nomenclatura_bz">
			<span>RICK SANCHEZ</span>
		</div>
		<svg class="Rectngulo_12">
			<rect id="Rectngulo_12" rx="10" ry="10" x="0" y="0" width="577" height="675">
			</rect>
		</svg>
		<svg class="Lnea_17" viewBox="0 0 576 1">
			<path id="Lnea_17" d="M 0 0 L 576 0">
			</path>
		</svg>
		<div id="Nomenclatura_b">
			<span>REGISTRO DE FUNCIONAMIENTO EN CAMPO</span>
		</div>
		<div id="Nomenclatura_ca">
			<span>Hora</span>
		</div>
		<div id="Nomenclatura_cb">
			<span>No. de Épocas </span>
		</div>
		<div id="Nomenclatura_cc">
			<span>GDOP</span>
		</div>
		<div id="Nomenclatura_cd">
			<span>Memoria</span>
		</div>
		<div id="Nomenclatura_ce">
			<span>Baterías %</span>
		</div>
		<div id="Nomenclatura_cf">
			<span>A</span>
		</div>
		<div id="Nomenclatura_cg">
			<span>B</span>
		</div>
		<div id="Nomenclatura_ch">
			<span>EXT</span>
		</div>
		<svg class="Lnea_18" viewBox="0 0 576 1">
			<path id="Lnea_18" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Rectngulo_13">
			<rect id="Rectngulo_13" rx="10" ry="10" x="0" y="0" width="998" height="187">
			</rect>
		</svg>
		<svg class="Rectngulo_14">
			<rect id="Rectngulo_14" rx="10" ry="10" x="0" y="0" width="998" height="107">
			</rect>
		</svg>
		<svg class="Trazado_2" viewBox="-3.226 0 3.241 640.511">
			<path id="Trazado_2" d="M 0.01554107666015625 0 L -3.225654602050781 640.5111694335938">
			</path>
		</svg>
		<svg class="Trazado_3" viewBox="0 768 1 1">
			<path id="Trazado_3" d="M 0 768">
			</path>
		</svg>
		<svg class="Trazado_4" viewBox="0 768.073 1 1">
			<path id="Trazado_4" d="M 0 768.0731201171875">
			</path>
		</svg>
		<svg class="Lnea_23" viewBox="0 0 216.73 1">
			<path id="Lnea_23" d="M 0 0 L 216.7302551269531 0">
			</path>
		</svg>
		<svg class="Trazado_5" viewBox="0 745.073 1 1">
			<path id="Trazado_5" d="M 0 745.0731201171875">
			</path>
		</svg>
		<svg class="Trazado_6" viewBox="0 745 1 1">
			<path id="Trazado_6" d="M 0 745">
			</path>
		</svg>
		<svg class="Lnea_26" viewBox="0 0 576 1">
			<path id="Lnea_26" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_27" viewBox="0 0 576 1">
			<path id="Lnea_27" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_28" viewBox="0 0 576 1">
			<path id="Lnea_28" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_29" viewBox="0 0 576 1.681">
			<path id="Lnea_29" d="M 0 1.68060302734375 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_30" viewBox="0 0 576 1">
			<path id="Lnea_30" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_31" viewBox="0 0 576 1">
			<path id="Lnea_31" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_32" viewBox="0 0 576 1">
			<path id="Lnea_32" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_33" viewBox="0 0 576 1">
			<path id="Lnea_33" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_34" viewBox="0 0 576 1">
			<path id="Lnea_34" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_35" viewBox="0 0 576 1">
			<path id="Lnea_35" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_36" viewBox="0 0 576 1">
			<path id="Lnea_36" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_37" viewBox="0 0 576 1">
			<path id="Lnea_37" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_38" viewBox="0 0 576 1">
			<path id="Lnea_38" d="M 0 0 L 576 0">
			</path>
		</svg>
		<svg class="Lnea_39" viewBox="0 0 576 1">
			<path id="Lnea_39" d="M 0 0 L 576 0">
			</path>
		</svg>
		<div id="Nomenclatura_cy">
			<span>MEDICIÓN DE ALTURA</span>
		</div>
		<svg class="Lnea_41" viewBox="0 0 415 1">
			<path id="Lnea_41" d="M 0 0 L 415 0">
			</path>
		</svg>
		<img id="Imagen_1" src="Imagen_1.png" srcset="Imagen_1.png 1x, Imagen_1@2x.png 2x">
		<svg class="Lnea_42" viewBox="0 0 415 1">
			<path id="Lnea_42" d="M 0 0 L 415 0">
			</path>
		</svg>
		<div id="Nomenclatura_c">
			<span>Trípode</span>
		</div>
		<div id="Nomenclatura_da">
			<span>Topcon</span>
		</div>
		<div id="Nomenclatura_db">
			<span style="text-transform:uppercase;">I</span><span style="text-transform:capitalize;">nicio</span>
		</div>
		<div id="Nomenclatura_dc">
			<span style="text-transform:uppercase;">F</span><span style="text-transform:capitalize;">inal</span>
		</div>
		<img id="Imagen_4" src="Imagen_4.png" srcset="Imagen_4.png 1x, Imagen_4@2x.png 2x">
		<svg class="Lnea_45" viewBox="0 0 415 1">
			<path id="Lnea_45" d="M 0 0 L 415 0">
			</path>
		</svg>
		<svg class="Lnea_46" viewBox="0 0 415 1">
			<path id="Lnea_46" d="M 0 0 L 415 0">
			</path>
		</svg>
		<div id="Nomenclatura_dd">
			<span>Bastón</span>
		</div>
		<svg class="Lnea_47" viewBox="0 0 415 1">
			<path id="Lnea_47" d="M 0 0 L 415 0">
			</path>
		</svg>
		<svg class="Lnea_48" viewBox="0 0 415 1">
			<path id="Lnea_48" d="M 0 0 L 415 0">
			</path>
		</svg>
		<div id="Nomenclatura_de">
			<span>Pilastra</span>
		</div>
		<img id="Imagen_5" src="Imagen_5.png" srcset="Imagen_5.png 1x, Imagen_5@2x.png 2x">
		<svg class="Lnea_50" viewBox="0 0 165 1">
			<path id="Lnea_50" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_df">
			<span>m</span>
		</div>
		<svg class="Lnea_51" viewBox="0 0 165 1">
			<path id="Lnea_51" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_dh">
			<span>m</span>
		</div>
		<div id="Nomenclatura_di">
			<span style="text-transform:uppercase;">I</span><span style="text-transform:capitalize;">nicio</span>
		</div>
		<div id="Nomenclatura_dj">
			<span style="text-transform:uppercase;">F</span><span style="text-transform:capitalize;">inal</span>
		</div>
		<svg class="Lnea_52" viewBox="0 0 165 1">
			<path id="Lnea_52" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_dl">
			<span>m</span>
		</div>
		<svg class="Lnea_53" viewBox="0 0 165 1">
			<path id="Lnea_53" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_dn">
			<span>m</span>
		</div>
		<div id="Nomenclatura_do">
			<span style="text-transform:uppercase;">I</span><span style="text-transform:capitalize;">nicio</span>
		</div>
		<div id="Nomenclatura_dp">
			<span style="text-transform:uppercase;">F</span><span style="text-transform:capitalize;">inal</span>
		</div>
		<svg class="Lnea_54" viewBox="0 0 165 1">
			<path id="Lnea_54" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_dr">
			<span>m</span>
		</div>
		<svg class="Lnea_55" viewBox="0 0 165 1">
			<path id="Lnea_55" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_dt">
			<span>m</span>
		</div>
		<svg class="Lnea_56" viewBox="0 0 415 1">
			<path id="Lnea_56" d="M 0 0 L 415 0">
			</path>
		</svg>
		<div id="Nomenclatura_dv">
			<span>Otro</span>
		</div>
		<svg class="Lnea_58" viewBox="0 0 415 1">
			<path id="Lnea_58" d="M 0 0 L 415 0">
			</path>
		</svg>
		<div id="Nomenclatura_dx">
			<span style="text-transform:uppercase;">I</span><span style="text-transform:capitalize;">nicio</span>
		</div>
		<div id="Nomenclatura_dy">
			<span style="text-transform:uppercase;">F</span><span style="text-transform:capitalize;">inal</span>
		</div>
		<svg class="Lnea_59" viewBox="0 0 165 1">
			<path id="Lnea_59" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_d">
			<span>m</span>
		</div>
		<svg class="Lnea_60" viewBox="0 0 165 1">
			<path id="Lnea_60" d="M 0 0 L 165 0">
			</path>
		</svg>
		<div id="Nomenclatura_ea">
			<span>m</span>
		</div>
		<svg class="Lnea_62" viewBox="0 0 415 1">
			<path id="Lnea_62" d="M 0 0 L 415 0">
			</path>
		</svg>
		<div id="Nomenclatura_eb">
			<span>Tipo de medición</span>
		</div>
		<svg class="Lnea_63" viewBox="0 0 415 1">
			<path id="Lnea_63" d="M 0 0 L 415 0">
			</path>
		</svg>
		<div id="Nomenclatura_ec">
			<span style="text-transform:uppercase;">I</span><span style="text-transform:capitalize;">nclinada</span>
		</div>
		<div id="Nomenclatura_ed">
			<span style="text-transform:uppercase;">V</span><span style="text-transform:capitalize;">ertical</span>
		</div>
		<div id="Nomenclatura_ee">
			<span style="text-transform:uppercase;">V</span><span style="text-transform:capitalize;">ertical GHM007</span>
		</div>
		<svg class="Rectngulo_16">
			<rect id="Rectngulo_16" rx="0" ry="0" x="0" y="0" width="45" height="25">
			</rect>
		</svg>
		<svg class="Rectngulo_17">
			<rect id="Rectngulo_17" rx="0" ry="0" x="0" y="0" width="45" height="25">
			</rect>
		</svg>
		<svg class="Rectngulo_18">
			<rect id="Rectngulo_18" rx="0" ry="0" x="0" y="0" width="45" height="25">
			</rect>
		</svg>
		<div id="Nomenclatura_ef">
			<span>POSICIÓN NAVEGADA</span>
		</div>
		<div id="Nomenclatura_eg">
			<span>OBSERVACIONES:</span>
		</div>
		<svg class="Lnea_64" viewBox="0 0 1 186">
			<path id="Lnea_64" d="M 0 0 L 0 186">
			</path>
		</svg>
		<div id="Nomenclatura_eh">
			<span>LATITUD </span>
		</div>
		<div id="Nomenclatura_ei">
			<span>LONGITUD (W)</span>
		</div>
		<div id="Nomenclatura_ej">
			<span style="text-transform:uppercase;">ALTURA (</span><span style="text-transform:lowercase;">M</span><span style="text-transform:uppercase;">)</span>
		</div>
		<svg class="Lnea_65" viewBox="0 0 1 185.73">
			<path id="Lnea_65" d="M 0 0 L 0 185.730224609375">
			</path>
		</svg>
		<svg class="Trazado_1" viewBox="-2 0 997.341 0.5">
			<path id="Trazado_1" d="M -2 0.5 L 995.3412475585938 0">
			</path>
		</svg>
		<svg class="Lnea_67" viewBox="0 0 1 185.73">
			<path id="Lnea_67" d="M 0 0 L 0 185.730224609375">
			</path>
		</svg>
		<svg class="Lnea_68" viewBox="0 0 997 1">
			<path id="Lnea_68" d="M 0 0 L 997 0">
			</path>
		</svg>
		<div id="Nomenclatura_em">
			<span>Inicial</span>
		</div>
		<div id="Nomenclatura_en">
			<span>Final</span>
		</div>
		<svg class="Lnea_69" viewBox="0 0 604 1">
			<path id="Lnea_69" d="M 0 0 L 604 0">
			</path>
		</svg>
		<div id="Nomenclatura_ep">
			<span>G°</span>
		</div>
		<svg class="Lnea_70" viewBox="0 0 1 152">
			<path id="Lnea_70" d="M 0 0 L 0 152">
			</path>
		</svg>
		<svg class="Lnea_71" viewBox="0 0 1 152">
			<path id="Lnea_71" d="M 0 0 L 0 152">
			</path>
		</svg>
		<svg class="Lnea_72" viewBox="0 0 1 122">
			<path id="Lnea_72" d="M 0 0 L 0 122">
			</path>
		</svg>
		<div id="Nomenclatura_et">
			<span>M'</span>
		</div>
		<div id="Nomenclatura_eu">
			<span>S"</span>
		</div>
		<div id="Nomenclatura_ev">
			<span>G°</span>
		</div>
		<svg class="Lnea_73" viewBox="0 0 1 152">
			<path id="Lnea_73" d="M 0 0 L 0 152">
			</path>
		</svg>
		<svg class="Lnea_74" viewBox="0 0 1 152">
			<path id="Lnea_74" d="M 0 0 L 0 152">
			</path>
		</svg>
		<div id="Nomenclatura_ey">
			<span>M'</span>
		</div>
		<div id="Nomenclatura_ez">
			<span>S"</span>
		</div>
		<div id="Nomenclatura_e">
			<span>N</span>
		</div>
		<div id="Nomenclatura_fa">
			<span>N</span>
		</div>
		<svg class="Rectngulo_19">
			<rect id="Rectngulo_19" rx="0" ry="0" x="0" y="0" width="28" height="25">
			</rect>
		</svg>
		<svg class="Rectngulo_20">
			<rect id="Rectngulo_20" rx="0" ry="0" x="0" y="0" width="28" height="25">
			</rect>
		</svg>
		<div id="Nomenclatura_fb">
			<span>S</span>
		</div>
		<div id="Nomenclatura_fc">
			<span>S</span>
		</div>
		<div id="X">
			<span>X</span>
		</div>
		<div id="X_e">
			<span>X</span>
		</div>
		<div id="X_fa">
			<span>X</span>
		</div>
		<div id="X_fb">
			<span>X</span>
		</div>
		<div id="X_fc">
			<span>X</span>
		</div>
		<div id="Nomenclatura_fd">
			<span>Topcon</span>
		</div>
		<div id="Nomenclatura_fe">
			<span>Topcon</span>
		</div>
		<div id="Nomenclatura_ff">
			<span>Topcon</span>
		</div>
		<div id="Nomenclatura_fg">
			<span>Topcon</span>
		</div>
		<div id="Nomenclatura_fh">
			<span>Topcon</span>
		</div>
		<div id="Nomenclatura_fi">
			<span>1.2344</span>
		</div>
		<div id="Nomenclatura_fj">
			<span>1.2344</span>
		</div>
		<div id="Nomenclatura_fk">
			<span>1.2344</span>
		</div>
		<div id="Nomenclatura_fl">
			<span>1.2344</span>
		</div>
		<div id="Nomenclatura_fm">
			<span>1.2344</span>
		</div>
		<div id="Nomenclatura_fn">
			<span>1.2344</span>
		</div>
		<div id="Grupo_2">
			<div id="Grupo_1">
				<div id="Nomenclatura_fo">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Nomenclatura_fp">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_fq">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_fr">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_fs">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_ft">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_fu">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_fv">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_fw">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_fx">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_fy">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_fz">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_f">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_ga">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_gb">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_gc">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_gd">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_ge">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_gf">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_gg">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_gh">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_gi">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_gj">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_gk">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_gl">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_gm">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_gn">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_go">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_gp">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_gq">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_gr">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_gs">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_gt">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_gu">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_gv">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_gw">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_gx">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_gy">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_gz">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_g">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_ha">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_hb">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_hc">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_hd">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_he">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_hf">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_hg">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_hh">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_hi">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_hj">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_hk">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_hl">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_hm">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_hn">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_ho">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_hp">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_hq">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_hr">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_hs">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_ht">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_hu">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_hv">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_hw">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_hx">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_hy">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_hz">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_h">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_ia">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_ib">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_ic">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_id">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_ie">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_if">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_ig">
			<span>12345678</span>
		</div>
		<div id="Nomenclatura_ih">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_ii">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_ij">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_ik">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_il">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_im">
			<span>12345678</span><br>
		</div>
		<div id="Nomenclatura_in">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_io">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_ip">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_iq">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_ir">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_is">
			<span>12345678</span><br>
		</div>
		<div id="Nomenclatura_it">
			<span>4.584</span>
		</div>
		<div id="Nomenclatura_iu">
			<span>100%</span>
		</div>
		<div id="Nomenclatura_iv">
			<span>80%</span>
		</div>
		<div id="Nomenclatura_iw">
			<span>50%</span>
		</div>
		<div id="Nomenclatura_ix">
			<span>10%</span>
		</div>
		<div id="Nomenclatura_iy">
			<span>4</span>
		</div>
		<div id="Nomenclatura_iz">
			<span>26</span>
		</div>
		<div id="Nomenclatura_i">
			<span>22.12</span>
		</div>
		<div id="Nomenclatura_ja">
			<span>4</span>
		</div>
		<div id="Nomenclatura_jb">
			<span>26</span>
		</div>
		<div id="Nomenclatura_jc">
			<span>22.12</span>
		</div>
		<div id="Nomenclatura_jd">
			<span>X</span>
		</div>
		<div id="Nomenclatura_je">
			<span>X</span>
		</div>
		<div id="Nomenclatura_jf">
			<span>-74</span>
		</div>
		<div id="Nomenclatura_jg">
			<span>26</span>
		</div>
		<div id="Nomenclatura_jh">
			<span>22.12</span>
		</div>
		<div id="Nomenclatura_ji">
			<span>-74</span>
		</div>
		<div id="Nomenclatura_jj">
			<span>26</span>
		</div>
		<div id="Nomenclatura_jk">
			<span>22.12</span>
		</div>
		<div id="Nomenclatura_jl">
			<span>2547</span>
		</div>
		<div id="Nomenclatura_jm">
			<span>2547</span>
		</div>
		<div id="Nomenclatura_jn">
			<span>1.2344</span>
		</div>
		<div id="Nomenclatura_jo">
			<span>1.2344</span>
		</div>
		<div id="Nomenclatura_jp">
			<span>X</span>
		</div>
		<div id="Nomenclatura_jq">
			<span>X</span>
		</div>
		<div id="Nomenclatura_jr">
			<span>X</span>
		</div>
		<div id="Grupo_3">
			<div id="Grupo_1_it">
				<div id="Nomenclatura_js">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_4">
			<div id="Grupo_1_iw">
				<div id="Nomenclatura_jt">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_5">
			<div id="Grupo_1_iz">
				<div id="Nomenclatura_ju">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_6">
			<div id="Grupo_1_i">
				<div id="Nomenclatura_jv">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_7">
			<div id="Grupo_1_ja">
				<div id="Nomenclatura_jw">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_8">
			<div id="Grupo_1_jb">
				<div id="Nomenclatura_jx">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_9">
			<div id="Grupo_1_jc">
				<div id="Nomenclatura_jy">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_10">
			<div id="Grupo_1_je">
				<div id="Nomenclatura_jz">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_11">
			<div id="Grupo_1_jh">
				<div id="Nomenclatura_j">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_12">
			<div id="Grupo_1_jk">
				<div id="Nomenclatura_ka">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_13">
			<div id="Grupo_1_jn">
				<div id="Nomenclatura_kb">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_14">
			<div id="Grupo_1_jq">
				<div id="Nomenclatura_kc">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_15">
			<div id="Grupo_1_jt">
				<div id="Nomenclatura_kd">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Grupo_16">
			<div id="Grupo_1_jw">
				<div id="Nomenclatura_ke">
					<span>10:20 am</span>
				</div>
			</div>
		</div>
		<div id="Nomenclatura_kf">
			<span>LA LA LA LA ALNSDJHSDJFH MARIA AKJSDKAJSDLKJSADLKJAS JUANA SJDSALHDALSKHDASHSDSKAJDLASJDLSAKJDLKJSALDJASLDJLSAJDLKSAJDLKSAJDLKJSD JULIANA JASDHAJSKDHAKJSDHKJSADH BLA ASKJDHASJKDHKAJHSDJKASHDJKSA</span>
		</div>
		<svg class="Trazado_7" viewBox="-3.226 34.143 3.076 640.469">
			<path id="Trazado_7" d="M -0.1498565673828125 34.143310546875 L -3.225654602050781 674.612548828125">
			</path>
		</svg>
		<svg class="Trazado_8" viewBox="-3.226 34.143 3.076 640.469">
			<path id="Trazado_8" d="M -0.1498565673828125 34.143310546875 L -3.225654602050781 674.612548828125">
			</path>
		</svg>
		<svg class="Trazado_9" viewBox="-3.226 34.143 3.076 640.469">
			<path id="Trazado_9" d="M -0.1498565673828125 34.143310546875 L -3.225654602050781 674.612548828125">
			</path>
		</svg>
		<svg class="Trazado_10" viewBox="-3.226 34.143 3.076 623.12">
			<path id="Trazado_10" d="M -0.1498565673828125 34.143310546875 L -3.225654602050781 657.263427734375">
			</path>
		</svg>
		<svg class="Trazado_11" viewBox="-3.226 34.143 3.076 623.12">
			<path id="Trazado_11" d="M -0.1498565673828125 34.143310546875 L -3.225654602050781 657.263427734375">
			</path>
		</svg>
	</div>
</div>
</body>
</html>
    ''';

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = "ejemplo";
    var pdfGenerado = await FlutterHtmlToPdf.convertFromHtmlContent(descripcionHTML, targetPath, targetFileName);
  
    String pdfGeneradoRuta = pdfGenerado.path;

    return pdfGeneradoRuta;
  }
}