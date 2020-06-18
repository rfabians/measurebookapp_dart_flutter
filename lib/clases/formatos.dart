import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

class Formatos {
  Future<String> descripcionPunto() async {
    String descripcionHTML = """
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
		--web-enable-deep-linking: true;
	}
	#Componente_1__1 {
		position: absolute;
		width: 998px;
		height: 1485px;
		left: 36px;
		top: 41px;
		overflow: visible;
	}
	#Nomenclatura {
		transform: translate(0px, 0px) matrix(1,0,0,1,726,222) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 199px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_i {
		transform: translate(0px, 0px) matrix(1,0,0,1,779.5,237.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 37px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_j {
		transform: translate(0px, 0px) matrix(1,0,0,1,784,404) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 27px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 11px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_k {
		transform: translate(0px, 0px) matrix(1,0,0,1,715.5,235.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 118px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_l {
		transform: translate(0px, 0px) matrix(1,0,0,1,707,402) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 138px;
		height: 13px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_12 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_12 {
		width: 494px;
		height: 115px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,452.5,190.5) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_n {
		transform: translate(0px, 0px) matrix(1,0,0,1,702.5,232.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 75px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_o {
		transform: translate(0px, 0px) matrix(1,0,0,1,699.5,173.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 29px;
		height: 15px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_p {
		transform: translate(0px, 0px) matrix(1,0,0,1,653.5,174.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 89px;
		height: 13px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_q {
		transform: translate(0px, 0px) matrix(1,0,0,1,641,355) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 146px;
		height: 15px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_r {
		transform: translate(0px, 0px) matrix(1,0,0,1,589,364) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 219px;
		height: 14px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_s {
		transform: translate(0px, 0px) matrix(1,0,0,1,652.5,170.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 41px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_t {
		transform: translate(0px, 0px) matrix(1,0,0,1,615,178) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 82px;
		height: 13px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_u {
		transform: translate(0px, 0px) matrix(1,0,0,1,653.5,292.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 39px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_v {
		transform: translate(0px, 0px) matrix(1,0,0,1,619,299) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 74px;
		height: 13px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_w {
		transform: translate(0px, 0px) matrix(1,0,0,1,645.5,415.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 55px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_x {
		transform: translate(0px, 0px) matrix(1,0,0,1,604.5,422.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 103px;
		height: 13px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_22 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_22 {
		width: 251px;
		height: 29px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,499,355) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_z {
		transform: translate(0px, 0px) matrix(1,0,0,1,603.5,357.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 43px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_25 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_25 {
		width: 251px;
		height: 304px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,332.5,217.5) rotate(90deg);
		transform-origin: center;
	}
	#Rectngulo_26 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_26 {
		width: 494px;
		height: 189px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,-39.5,153.5) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_ {
		transform: translate(0px, 0px) matrix(1,0,0,1,159,217) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 261px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ba {
		transform: translate(0px, 0px) matrix(1,0,0,1,242,333) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 33px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_bb {
		transform: translate(0px, 0px) matrix(1,0,0,1,227,426) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 63px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_52 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_52 {
		width: 494px;
		height: 110px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,-192,193) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_bc {
		transform: translate(0px, 0px) matrix(1,0,0,1,-108,269) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 398px;
		height: 15px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_bd {
		transform: translate(0px, 0px) matrix(1,0,0,1,-452,972) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 962px;
		height: 47px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_54 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_54 {
		width: 491px;
		height: 353px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,386,569) rotate(90deg);
		transform-origin: center;
	}
	#Rectngulo_55 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_55 {
		width: 985px;
		height: 76px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,-454.5,954.5) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_be {
		transform: translate(0px, 0px) matrix(1,0,0,1,-5,574) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 133px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_56 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_56 {
		width: 491px;
		height: 346px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,7.5,572.5) rotate(90deg);
		transform-origin: center;
	}
	#Rectngulo_57 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_57 {
		width: 494px;
		height: 353px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,384.5,1061.5) rotate(90deg);
		transform-origin: center;
	}
	#Rectngulo_58 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_58 {
		width: 494px;
		height: 346px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,6,1065) rotate(90deg);
		transform-origin: center;
	}
	#Rectngulo_59 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_59 {
		width: 491px;
		height: 29px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,577,731) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_bf {
		transform: translate(0px, 0px) matrix(1,0,0,1,725,719) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 199px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_60 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_60 {
		width: 494px;
		height: 29px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,575.5,1223.5) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_bh {
		transform: translate(0px, 0px) matrix(1,0,0,1,725,1212) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 199px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_61 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_61 {
		width: 491px;
		height: 29px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,195,731) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_bj {
		transform: translate(0px, 0px) matrix(1,0,0,1,343,720) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 199px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_62 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_62 {
		width: 494px;
		height: 29px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,193.5,1223.5) rotate(90deg);
		transform-origin: center;
	}
	#Nomenclatura_bl {
		transform: translate(0px, 0px) matrix(1,0,0,1,342,1213) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 199px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
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
		width: 493.953px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,562.3994,247.3691) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		height: 49.428px;
		transform: translate(0px, 0px) matrix(1,0,0,1,784.6621,305.5044) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Lnea_7 {
		fill: transparent;
		stroke: rgba(112,112,112,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_7 {
		overflow: visible;
		position: absolute;
		width: 42.406px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,738.7452,269.7501) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Rectngulo_66 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_66 {
		width: 495px;
		height: 78px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,550.5,208.5) rotate(90deg);
		transform-origin: center;
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
		width: 493.168px;
		height: 0.727px;
		transform: translate(0px, 0px) matrix(1,0,0,1,437.406,247.3983) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 1px;
		height: 85.044px;
		transform: translate(0px, 0px) matrix(1,0,0,1,683.9897,201.313) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 1px;
		height: 42.159px;
		transform: translate(0px, 0px) matrix(1,0,0,1,662.547,340.5507) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 493.168px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,479.9281,247.7618) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Rectngulo_67 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: round;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_67 {
		width: 243px;
		height: 304px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,336.5,-29.5) rotate(90deg);
		transform-origin: center;
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
		height: 162.82px;
		transform: translate(0px, 0px) matrix(1,0,0,1,195.893,211.899) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 1px;
		height: 163.547px;
		transform: translate(0px, 0px) matrix(1,0,0,1,195.5295,316.7656) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 493.168px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,-25.9771,247.7618) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Lnea_22 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_22 {
		overflow: visible;
		position: absolute;
		width: 493.168px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,0.1904,247.7618) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Lnea_24 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_24 {
		overflow: visible;
		position: absolute;
		width: 493.168px;
		height: 2.181px;
		transform: translate(0px, 0px) matrix(1,0,0,1,30.3557,246.6715) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 493.168px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,-53.5984,247.7618) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 493.168px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,-79.7659,247.7618) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 493.168px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,-105.9334,247.7618) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Lnea_25 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Lnea_25 {
		overflow: visible;
		position: absolute;
		width: 494.738px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,-170.6837,247.7618) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Rectngulo_68 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_68 {
		width: 243px;
		height: 29px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,503,108) rotate(90deg);
		transform-origin: center;
	}
	#SE_NOS_ATRAVEZ_TODO_ {
		transform: translate(0px, 0px) matrix(1,0,0,1,113.5,148.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 239px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
	}
	#SE_NOS_ATRAVEZ_TODO__b {
		transform: translate(0px, 0px) matrix(1,0,0,1,87.5,148.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 239px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
	}
	#SE_NOS_ATRAVEZ_TODO__ca {
		transform: translate(0px, 0px) matrix(1,0,0,1,61.5,148.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 239px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
	}
	#SE_NOS_ATRAVEZ_TODO__cb {
		transform: translate(0px, 0px) matrix(1,0,0,1,35.5,148.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 239px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
	}
	#SE_NOS_ATRAVEZ_TODO__cc {
		transform: translate(0px, 0px) matrix(1,0,0,1,9.5,148.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 239px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
	}
	#Nomenclatura_ca {
		transform: translate(0px, 0px) matrix(1,0,0,1,185.5,339.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 92px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cb {
		transform: translate(0px, 0px) matrix(1,0,0,1,160.5,339.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 92px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cc {
		transform: translate(0px, 0px) matrix(1,0,0,1,133.5,339.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 92px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cd {
		transform: translate(0px, 0px) matrix(1,0,0,1,108.5,339.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 92px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ce {
		transform: translate(0px, 0px) matrix(1,0,0,1,80.5,339.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 92px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cf {
		transform: translate(0px, 0px) matrix(1,0,0,1,194,438) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 75px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cg {
		transform: translate(0px, 0px) matrix(1,0,0,1,169,436) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 75px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ch {
		transform: translate(0px, 0px) matrix(1,0,0,1,142,436) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 75px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ci {
		transform: translate(0px, 0px) matrix(1,0,0,1,117,436) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 75px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cj {
		transform: translate(0px, 0px) matrix(1,0,0,1,89,436) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 75px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#PUES_RESULTA_QUE_RAFITA_ERA_UN {
		transform: translate(0px, 0px) matrix(1,0,0,1,-202,222) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 464px;
		height: 43px;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
	}
	#Imagen_12x {
		position: absolute;
		width: 316px;
		height: 427px;
		left: 483px;
		top: 504px;
		overflow: visible;
	}
	#Imagen_12x_cm {
		position: absolute;
		width: 314px;
		height: 425px;
		left: 107px;
		top: 504px;
		overflow: visible;
	}
	#Imagen_12x_cn {
		position: absolute;
		width: 314px;
		height: 425px;
		left: 107px;
		top: 996px;
		overflow: visible;
	}
	#Imagen_12x_co {
		position: absolute;
		width: 315px;
		height: 425px;
		left: 484px;
		top: 996px;
		overflow: visible;
	}
	#Imagen_5 {
		position: absolute;
		width: 224px;
		height: 205px;
		left: 351px;
		top: 5px;
		overflow: visible;
	}
	#Imagen_5_cq {
		position: absolute;
		width: 224px;
		height: 205px;
		left: 351px;
		top: 254px;
		overflow: visible;
	}
	#fecha {
		transform: translate(0px, 0px) matrix(1,0,0,1,968,1337) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 33px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 11px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#AO-MES-DA {
		transform: translate(0px, 0px) matrix(1,0,0,1,926,1335) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 59px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_ct {
		transform: translate(0px, 0px) matrix(1,0,0,1,855.5,36.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 70px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cu {
		transform: translate(0px, 0px) matrix(1,0,0,1,783.5,74.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 29px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cv {
		transform: translate(0px, 0px) matrix(1,0,0,1,711,74) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 127px;
		height: 16px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cw {
		transform: translate(0px, 0px) matrix(1,0,0,1,702,54) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 27px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 11px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cx {
		transform: translate(0px, 0px) matrix(1,0,0,1,655,55) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 87px;
		height: 14px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cy {
		transform: translate(0px, 0px) matrix(1,0,0,1,615,56) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 116px;
		height: 13px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_cz {
		transform: translate(0px, 0px) matrix(1,0,0,1,613.5,55.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 87px;
		height: 13px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 16px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_c {
		transform: translate(0px, 0px) matrix(1,0,0,1,577.5,103.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 95px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 10px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_da {
		transform: translate(0px, 0px) matrix(1,0,0,1,251.5,3.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 13px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 13px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_db {
		transform: translate(0px, 0px) matrix(1,0,0,1,242,141) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 33px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dc {
		transform: translate(0px, 0px) matrix(1,0,0,1,69,29) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 55px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dd {
		transform: translate(0px, 0px) matrix(1,0,0,1,21,45) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 87px;
		white-space: nowrap;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
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
		width: 1px;
		height: 49.428px;
		transform: translate(0px, 0px) matrix(1,0,0,1,784.6621,140.5916) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 0.785px;
		height: 85.044px;
		transform: translate(0px, 0px) matrix(1,0,0,1,683.5971,80.7697) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		height: 161.366px;
		transform: translate(0px, 0px) matrix(1,0,0,1,195.166,-57.5169) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#ID1 {
		transform: translate(0px, 0px) matrix(1,0,0,1,228,3) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 14px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 21px;
		color: rgba(0,0,0,1);
	}
	#ID1_c {
		transform: translate(0px, 0px) matrix(1,0,0,1,200,3) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 14px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 21px;
		color: rgba(0,0,0,1);
	}
	#ID1_da {
		transform: translate(0px, 0px) matrix(1,0,0,1,172,3) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 14px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 21px;
		color: rgba(0,0,0,1);
	}
	#ID1_db {
		transform: translate(0px, 0px) matrix(1,0,0,1,147,3) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 14px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 21px;
		color: rgba(0,0,0,1);
	}
	#ID1_dc {
		transform: translate(0px, 0px) matrix(1,0,0,1,122,3) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 14px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 21px;
		color: rgba(0,0,0,1);
	}
	#logo {
		position: absolute;
		width: 52px;
		height: 147px;
		left: 930px;
		top: 53px;
		overflow: visible;
	}
	#DESCRIPCIN_DE_PUNTO_GEODSICO {
		transform: translate(0px, 0px) matrix(1,0,0,1,768,722) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 412px;
		height: 17px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 20px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#ID2020-05-25 {
		transform: translate(0px, 0px) matrix(1,0,0,1,845,1341) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 164px;
		height: 15px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dg {
		transform: translate(0px, 0px) matrix(1,0,0,1,869,353) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 139px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dh {
		transform: translate(0px, 0px) matrix(1,0,0,1,755,633) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 362px;
		height: 19px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_di {
		transform: translate(0px, 0px) matrix(1,0,0,1,889.5,898.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 98px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dj {
		transform: translate(0px, 0px) matrix(1,0,0,1,825,1081) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 222px;
		height: 19px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dk {
		transform: translate(0px, 0px) matrix(1,0,0,1,865.5,395.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 50px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dl {
		transform: translate(0px, 0px) matrix(1,0,0,1,856,777) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 69px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dm {
		transform: translate(0px, 0px) matrix(1,0,0,1,877.5,1132.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: visible;
		width: 26px;
		white-space: nowrap;
		text-align: left;
		font-family: Arial;
		font-style: normal;
		font-weight: bold;
		font-size: 12px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dn {
		transform: translate(0px, 0px) matrix(1,0,0,1,690,178) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 354px;
		height: 15px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_do {
		transform: translate(0px, 0px) matrix(1,0,0,1,693.5,545.5) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 350px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dp {
		transform: translate(0px, 0px) matrix(1,0,0,1,698,921) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 338px;
		height: 15px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Nomenclatura_dq {
		transform: translate(0px, 0px) matrix(1,0,0,1,696,1289) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
		position: absolute;
		overflow: hidden;
		width: 345px;
		height: 20px;
		text-align: center;
		font-family: Arial;
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		color: rgba(0,0,0,1);
		text-transform: uppercase;
	}
	#Rectngulo_63 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: round;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_63 {
		width: 1485px;
		height: 87px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,212,699) rotate(90deg);
		transform-origin: center;
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
		height: 55.243px;
		transform: translate(0px, 0px) matrix(1,0,0,1,874.7946,343.4324) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		height: 55.243px;
		transform: translate(0px, 0px) matrix(1,0,0,1,874.7946,713.3081) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 1px;
		height: 55.243px;
		transform: translate(0px, 0px) matrix(1,0,0,1,874.7946,1085.5397) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
	#Rectngulo_65 {
		fill: transparent;
		stroke: rgba(0,0,0,1);
		stroke-width: 1px;
		stroke-linejoin: miter;
		stroke-linecap: butt;
		stroke-miterlimit: 4;
		shape-rendering: auto;
	}
	.Rectngulo_65 {
		width: 1485px;
		height: 56px;
		position: absolute;
		overflow: visible;
		transform: translate(0px, 0px) matrix(1,0,0,1,132.5,714.5) rotate(90deg);
		transform-origin: center;
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
		width: 1px;
		height: 86.498px;
		transform: translate(0px, 0px) matrix(1,0,0,1,954.3875,1168.0743) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 273.284px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,833.3733,1347.9653) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 273.284px;
		height: 1px;
		transform: translate(0px, 0px) matrix(1,0,0,1,804.2983,1347.9653) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
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
		width: 1px;
		height: 86.498px;
		transform: translate(0px, 0px) matrix(1,0,0,1,954.3875,230.4275) rotate(90deg);
		transform-origin: center;
		left: 0px;
		top: 0px;
	}
</style>
</head>
<body>
<div id="Web_1920__1">
	<div id="Componente_1__1" class="Componente_1___1">
		<div id="Nomenclatura">
			<span style="text-transform:uppercase;">c</span><span style="text-transform:lowercase;">oordenadas</span><span style="text-transform:uppercase;"> n</span><span style="text-transform:lowercase;">avegadas</span><span style="text-transform:uppercase;"> magna-sirgas</span>
		</div>
		<div id="Nomenclatura_i">
			<span style="text-transform:uppercase;">L</span><span style="text-transform:lowercase;">ongitud</span>
		</div>
		<div id="Nomenclatura_j">
			<span style="text-transform:uppercase;">A</span><span style="text-transform:lowercase;">ltura</span>
		</div>
		<div id="Nomenclatura_k">
			<span>-74°32'45.2154"</span>
		</div>
		<div id="Nomenclatura_l">
			<span>2560.325</span>
		</div>
		<svg class="Rectngulo_12">
			<rect id="Rectngulo_12" rx="10" ry="10" x="0" y="0" width="494" height="115">
			</rect>
		</svg>
		<div id="Nomenclatura_n">
			<span>monumentación</span>
		</div>
		<div id="Nomenclatura_o">
			<span style="text-transform:uppercase;">t</span><span style="text-transform:lowercase;">ipo</span>
		</div>
		<div id="Nomenclatura_p">
			<span style="text-transform:uppercase;">M</span><span style="text-transform:lowercase;">ojón</span>
		</div>
		<div id="Nomenclatura_q">
			<span style="text-transform:uppercase;">m</span><span>onumentado por</span>
		</div>
		<div id="Nomenclatura_r">
			<span>RAfael Fabian Sanchez Osorio</span>
		</div>
		<div id="Nomenclatura_s">
			<span style="text-transform:uppercase;">a</span><span style="text-transform:lowercase;">ncho (m)</span>
		</div>
		<div id="Nomenclatura_t">
			<span>1.2345</span>
		</div>
		<div id="Nomenclatura_u">
			<span style="text-transform:uppercase;">l</span><span style="text-transform:lowercase;">argo (m)</span>
		</div>
		<div id="Nomenclatura_v">
			<span>1.2345</span>
		</div>
		<div id="Nomenclatura_w">
			<span style="text-transform:uppercase;">s</span><span style="text-transform:lowercase;">obresale (M)</span>
		</div>
		<div id="Nomenclatura_x">
			<span>2.3456</span>
		</div>
		<svg class="Rectngulo_22">
			<rect id="Rectngulo_22" rx="10" ry="10" x="0" y="0" width="251" height="29">
			</rect>
		</svg>
		<div id="Nomenclatura_z">
			<span style="text-transform:uppercase;">f</span><span style="text-transform:lowercase;">oto placa</span>
		</div>
		<svg class="Rectngulo_25">
			<rect id="Rectngulo_25" rx="10" ry="10" x="0" y="0" width="251" height="304">
			</rect>
		</svg>
		<svg class="Rectngulo_26">
			<rect id="Rectngulo_26" rx="10" ry="10" x="0" y="0" width="494" height="189">
			</rect>
		</svg>
		<div id="Nomenclatura_">
			<span>referencias medidas de los objetos al punto</span>
		</div>
		<div id="Nomenclatura_ba">
			<span style="text-transform:uppercase;">a</span><span style="text-transform:lowercase;">zimut</span>
		</div>
		<div id="Nomenclatura_bb">
			<span style="text-transform:uppercase;">d</span><span style="text-transform:lowercase;">istancia (M)</span>
		</div>
		<svg class="Rectngulo_52">
			<rect id="Rectngulo_52" rx="10" ry="10" x="0" y="0" width="494" height="110">
			</rect>
		</svg>
		<div id="Nomenclatura_bc">
			<span>Rafael Fabian Sanchez Osorio Y RICK SANCHEZ </span>
		</div>
		<div id="Nomenclatura_bd">
			<span>horizonte despejado, apto para observación gnss aksdjhaksdjhaksdhasjdaksdjhakjdshaasdaskdjalsdjalsdjalskdjl askdjals kjdasdasda jks dljalskdjalskdjalskdjalksdjalksdjlaksdjasdkjshdakjdhsasd aksjdhakjdhakjdhakjdhaksdjh kjadhs kajhsdkajd aksdh kajsdkja asjd aks dkjas dkahs dk haskdj hasjdh akjs dkajs dhkajs dkajs dkajsh dkaj </span>
		</div>
		<svg class="Rectngulo_54">
			<rect id="Rectngulo_54" rx="10" ry="10" x="0" y="0" width="491" height="353">
			</rect>
		</svg>
		<svg class="Rectngulo_55">
			<rect id="Rectngulo_55" rx="10" ry="10" x="0" y="0" width="985" height="76">
			</rect>
		</svg>
		<div id="Nomenclatura_be">
			<span>descripción detallada</span>
		</div>
		<svg class="Rectngulo_56">
			<rect id="Rectngulo_56" rx="10" ry="10" x="0" y="0" width="491" height="346">
			</rect>
		</svg>
		<svg class="Rectngulo_57">
			<rect id="Rectngulo_57" rx="10" ry="10" x="0" y="0" width="494" height="353">
			</rect>
		</svg>
		<svg class="Rectngulo_58">
			<rect id="Rectngulo_58" rx="10" ry="10" x="0" y="0" width="494" height="346">
			</rect>
		</svg>
		<svg class="Rectngulo_59">
			<rect id="Rectngulo_59" rx="10" ry="10" x="0" y="0" width="491" height="29">
			</rect>
		</svg>
		<div id="Nomenclatura_bf">
			<span style="text-transform:uppercase;">c</span><span style="text-transform:lowercase;">oordenadas</span><span style="text-transform:uppercase;"> n</span><span style="text-transform:lowercase;">avegadas</span><span style="text-transform:uppercase;"> magna-sirgas</span>
		</div>
		<svg class="Rectngulo_60">
			<rect id="Rectngulo_60" rx="10" ry="10" x="0" y="0" width="494" height="29">
			</rect>
		</svg>
		<div id="Nomenclatura_bh">
			<span style="text-transform:uppercase;">c</span><span style="text-transform:lowercase;">oordenadas</span><span style="text-transform:uppercase;"> n</span><span style="text-transform:lowercase;">avegadas</span><span style="text-transform:uppercase;"> magna-sirgas</span>
		</div>
		<svg class="Rectngulo_61">
			<rect id="Rectngulo_61" rx="10" ry="10" x="0" y="0" width="491" height="29">
			</rect>
		</svg>
		<div id="Nomenclatura_bj">
			<span style="text-transform:uppercase;">c</span><span style="text-transform:lowercase;">oordenadas</span><span style="text-transform:uppercase;"> n</span><span style="text-transform:lowercase;">avegadas</span><span style="text-transform:uppercase;"> magna-sirgas</span>
		</div>
		<svg class="Rectngulo_62">
			<rect id="Rectngulo_62" rx="10" ry="10" x="0" y="0" width="494" height="29">
			</rect>
		</svg>
		<div id="Nomenclatura_bl">
			<span style="text-transform:uppercase;">c</span><span style="text-transform:lowercase;">oordenadas</span><span style="text-transform:uppercase;"> n</span><span style="text-transform:lowercase;">avegadas</span><span style="text-transform:uppercase;"> magna-sirgas</span>
		</div>
		<svg class="Lnea_4" viewBox="0 0 493.953 1">
			<path id="Lnea_4" d="M 0 0 L 493.9529418945313 0">
			</path>
		</svg>
		<svg class="Lnea_6" viewBox="0 0 1 49.428">
			<path id="Lnea_6" d="M 0 0 L 0 49.42752838134766">
			</path>
		</svg>
		<svg class="Lnea_7" viewBox="0 0 42.406 1">
			<path id="Lnea_7" d="M 0 0 L 42.40613555908203 0">
			</path>
		</svg>
		<svg class="Rectngulo_66">
			<rect id="Rectngulo_66" rx="10" ry="10" x="0" y="0" width="495" height="78">
			</rect>
		</svg>
		<svg class="Lnea_8" viewBox="0 0 493.168 0.727">
			<path id="Lnea_8" d="M 0 0 L 493.1676330566406 0.7268754243850708">
			</path>
		</svg>
		<svg class="Lnea_10" viewBox="0 0 1 85.044">
			<path id="Lnea_10" d="M 0 0 L 0 85.04443359375">
			</path>
		</svg>
		<svg class="Lnea_11" viewBox="0 0 1 42.159">
			<path id="Lnea_11" d="M 0 0 L 0 42.15877532958984">
			</path>
		</svg>
		<svg class="Lnea_12" viewBox="0 0 493.168 1">
			<path id="Lnea_12" d="M 0 0 L 493.1676330566406 0">
			</path>
		</svg>
		<svg class="Rectngulo_67">
			<rect id="Rectngulo_67" rx="10" ry="10" x="0" y="0" width="243" height="304">
			</rect>
		</svg>
		<svg class="Lnea_15" viewBox="0 0 1 162.82">
			<path id="Lnea_15" d="M 0 0 L 0 162.8200988769531">
			</path>
		</svg>
		<svg class="Lnea_16" viewBox="0 0 1 163.547">
			<path id="Lnea_16" d="M 0 0 L 0 163.5469665527344">
			</path>
		</svg>
		<svg class="Lnea_17" viewBox="0 0 493.168 1">
			<path id="Lnea_17" d="M 0 0 L 493.1676330566406 0">
			</path>
		</svg>
		<svg class="Lnea_22" viewBox="0 0 493.168 1">
			<path id="Lnea_22" d="M 0 0 L 493.1676330566406 0">
			</path>
		</svg>
		<svg class="Lnea_24" viewBox="0 0 493.168 2.181">
			<path id="Lnea_24" d="M 493.1676330566406 0 L 0 2.180626392364502">
			</path>
		</svg>
		<svg class="Trazado_1" viewBox="0 0 493.168 1">
			<path id="Trazado_1" d="M 0 0 L 493.1676330566406 0">
			</path>
		</svg>
		<svg class="Trazado_2" viewBox="0 0 493.168 1">
			<path id="Trazado_2" d="M 0 0 L 493.1676330566406 0">
			</path>
		</svg>
		<svg class="Trazado_3" viewBox="0 0 493.168 1">
			<path id="Trazado_3" d="M 0 0 L 493.1676330566406 0">
			</path>
		</svg>
		<svg class="Lnea_25" viewBox="0 0 494.738 1">
			<path id="Lnea_25" d="M 0 0 L 494.7382202148438 0">
			</path>
		</svg>
		<svg class="Rectngulo_68">
			<rect id="Rectngulo_68" rx="10" ry="10" x="0" y="0" width="243" height="29">
			</rect>
		</svg>
		<div id="SE_NOS_ATRAVEZ_TODO_">
			<span>SE NOS ATRAVEZÓ TODO </span>
		</div>
		<div id="SE_NOS_ATRAVEZ_TODO__b">
			<span>SE NOS ATRAVEZÓ TODO </span>
		</div>
		<div id="SE_NOS_ATRAVEZ_TODO__ca">
			<span>SE NOS ATRAVEZÓ TODO </span>
		</div>
		<div id="SE_NOS_ATRAVEZ_TODO__cb">
			<span>SE NOS ATRAVEZÓ TODO </span>
		</div>
		<div id="SE_NOS_ATRAVEZ_TODO__cc">
			<span>SE NOS ATRAVEZÓ TODO </span>
		</div>
		<div id="Nomenclatura_ca">
			<span>234°32'45.2154"</span>
		</div>
		<div id="Nomenclatura_cb">
			<span>234°32'45.2154"</span>
		</div>
		<div id="Nomenclatura_cc">
			<span>234°32'45.2154"</span>
		</div>
		<div id="Nomenclatura_cd">
			<span>234°32'45.2154"</span>
		</div>
		<div id="Nomenclatura_ce">
			<span>234°32'45.2154"</span>
		</div>
		<div id="Nomenclatura_cf">
			<span>123.345</span>
		</div>
		<div id="Nomenclatura_cg">
			<span>123.345</span>
		</div>
		<div id="Nomenclatura_ch">
			<span>123.345</span>
		</div>
		<div id="Nomenclatura_ci">
			<span>123.345</span>
		</div>
		<div id="Nomenclatura_cj">
			<span>123.345</span>
		</div>
		<div id="PUES_RESULTA_QUE_RAFITA_ERA_UN">
			<span>PUES RESULTA QUE RAFITA ERA UN FÍSICO Y ENTONCES PODRÍA VIAJAR POR TODAS LAS GALAXIAS Y LAS DIMENSIONES. EN ESTA DIMENSIÓN ESTÁ CON LA CHIQUITA, Y NO HAY CACHORROS.</span>
		</div>
		<img id="Imagen_12x" src="Imagen_12x.png" srcset="Imagen_12x.png 1x">
		<img id="Imagen_12x_cm" src="Imagen_12x_cm.png" srcset="Imagen_12x_cm.png 1x">
		<img id="Imagen_12x_cn" src="Imagen_12x_cn.png" srcset="Imagen_12x_cn.png 1x">
		<img id="Imagen_12x_co" src="Imagen_12x_co.png" srcset="Imagen_12x_co.png 1x">
		<img id="Imagen_5" src="Imagen_5.png" srcset="Imagen_5.png 1x">
		<img id="Imagen_5_cq" src="Imagen_5_cq.png" srcset="Imagen_5_cq.png 1x">
		<div id="fecha">
			<span>fecha</span>
		</div>
		<div id="AO-MES-DA">
			<span style="text-transform:uppercase;">A</span><span style="text-transform:lowercase;">ÑO-</span><span style="text-transform:uppercase;">M</span><span style="text-transform:lowercase;">ES-</span><span style="text-transform:uppercase;">D</span><span style="text-transform:lowercase;">ÍA</span>
		</div>
		<div id="Nomenclatura_ct">
			<span style="text-transform:uppercase;">D</span><span style="text-transform:lowercase;">epartamento:</span>
		</div>
		<div id="Nomenclatura_cu">
			<span style="text-transform:uppercase;">L</span><span style="text-transform:lowercase;">atitud</span>
		</div>
		<div id="Nomenclatura_cv">
			<span>4°35'58.4586"</span>
		</div>
		<div id="Nomenclatura_cw">
			<span style="text-transform:uppercase;">F</span><span style="text-transform:lowercase;">echa</span>
		</div>
		<div id="Nomenclatura_cx">
			<span>2015/24/03</span>
		</div>
		<div id="Nomenclatura_cy">
			<span style="text-transform:uppercase;">E</span><span style="text-transform:lowercase;">stado del punto:</span>
		</div>
		<div id="Nomenclatura_cz">
			<span>EXCELENTE </span>
		</div>
		<div id="Nomenclatura_c">
			<span style="text-transform:uppercase;">d</span><span style="text-transform:lowercase;">iagrama de obstaculos</span>
		</div>
		<div id="Nomenclatura_da">
			<span>n°</span>
		</div>
		<div id="Nomenclatura_db">
			<span style="text-transform:uppercase;">o</span><span style="text-transform:lowercase;">bjeto</span>
		</div>
		<div id="Nomenclatura_dc">
			<span>describió</span>
		</div>
		<div id="Nomenclatura_dd">
			<span>observaciones</span>
		</div>
		<svg class="Lnea_5" viewBox="0 0 1 49.428">
			<path id="Lnea_5" d="M 0 0 L 0 49.42752838134766">
			</path>
		</svg>
		<svg class="Lnea_9" viewBox="0 0 0.785 85.044">
			<path id="Lnea_9" d="M 0 0 L 0.785298764705658 85.04443359375">
			</path>
		</svg>
		<svg class="Lnea_14" viewBox="0 0 1 161.366">
			<path id="Lnea_14" d="M 0 0 L 0 161.3663635253906">
			</path>
		</svg>
		<div id="ID1">
			<span>1</span>
		</div>
		<div id="ID1_c">
			<span>1</span>
		</div>
		<div id="ID1_da">
			<span>1</span>
		</div>
		<div id="ID1_db">
			<span>1</span>
		</div>
		<div id="ID1_dc">
			<span>1</span>
		</div>
		<img id="logo" src="logo.png" srcset="logo.png 1x">
		<div id="DESCRIPCIN_DE_PUNTO_GEODSICO">
			<span>DESCRIPCIÓN DE PUNTO GEODÉSICO</span>
		</div>
		<div id="ID2020-05-25">
			<span>2020-05-25</span>
		</div>
		<div id="Nomenclatura_dg">
			<span style="text-transform:uppercase;">n</span><span style="text-transform:lowercase;">omenclatura</span><span style="text-transform:uppercase;"> e</span><span style="text-transform:lowercase;">standarizada</span><span style="text-transform:uppercase;">:</span>
		</div>
		<div id="Nomenclatura_dh">
			<span style="text-transform:uppercase;">n</span><span style="text-transform:lowercase;">omenclatura</span><span style="text-transform:uppercase;"> e</span><span style="text-transform:lowercase;">standarizada 12345678910</span>
		</div>
		<div id="Nomenclatura_di">
			<span style="text-transform:uppercase;">n</span><span style="text-transform:lowercase;">omenclatura</span><span style="text-transform:uppercase;"> p</span><span style="text-transform:lowercase;">laca</span><span style="text-transform:uppercase;">:</span>
		</div>
		<div id="Nomenclatura_dj">
			<span style="text-transform:uppercase;">n</span><span style="text-transform:lowercase;">omenclatura</span><span style="text-transform:uppercase;"> Placa 12345678910</span>
		</div>
		<div id="Nomenclatura_dk">
			<span style="text-transform:uppercase;">M</span><span style="text-transform:lowercase;">unicipio</span><span style="text-transform:uppercase;">:</span>
		</div>
		<div id="Nomenclatura_dl">
			<span style="text-transform:uppercase;">B</span><span style="text-transform:lowercase;">arrio</span><span style="text-transform:uppercase;">/v</span><span style="text-transform:lowercase;">ereda:</span>
		</div>
		<div id="Nomenclatura_dm">
			<span style="text-transform:uppercase;">s</span><span style="text-transform:lowercase;">itio:</span>
		</div>
		<div id="Nomenclatura_dn">
			<span>SON LAS GALAXIAS Y LAS OTRAS DIMENSIONES </span>
		</div>
		<div id="Nomenclatura_do">
			<span>CUNDINAMARCA META Y SAN VICENTE DEL CHUCURI</span>
		</div>
		<div id="Nomenclatura_dp">
			<span>barrio/vereda ES MUY LEJOS ENTONCES FAR </span>
		</div>
		<div id="Nomenclatura_dq">
			<span>LAS AVENTURAS DE RICK Y MORTI  POR LAS GALAXIAS</span>
		</div>
		<svg class="Rectngulo_63">
			<rect id="Rectngulo_63" rx="10" ry="10" x="0" y="0" width="1485" height="87">
			</rect>
		</svg>
		<svg class="Lnea_1" viewBox="0 0 1 55.243">
			<path id="Lnea_1" d="M 0 0 L 0 55.24253463745117">
			</path>
		</svg>
		<svg class="Lnea_2" viewBox="0 0 1 55.243">
			<path id="Lnea_2" d="M 0 0 L 0 55.24253463745117">
			</path>
		</svg>
		<svg class="Lnea_3" viewBox="0 0 1 55.243">
			<path id="Lnea_3" d="M 0 0 L 0 55.24253463745117">
			</path>
		</svg>
		<svg class="Rectngulo_65">
			<rect id="Rectngulo_65" rx="10" ry="10" x="0" y="0" width="1485" height="56">
			</rect>
		</svg>
		<svg class="Lnea_26" viewBox="0 0 1 86.498">
			<path id="Lnea_26" d="M 0 86.49818420410156 L 0 0">
			</path>
		</svg>
		<svg class="Lnea_27" viewBox="0 0 273.284 1">
			<path id="Lnea_27" d="M 0 0 L 273.2839660644531 0">
			</path>
		</svg>
		<svg class="Lnea_28" viewBox="0 0 273.284 1">
			<path id="Lnea_28" d="M 0 0 L 273.2839660644531 0">
			</path>
		</svg>
		<svg class="Lnea_29" viewBox="0 0 1 86.498">
			<path id="Lnea_29" d="M 0 86.49818420410156 L 0 0">
			</path>
		</svg>
	</div>
</div>
</body>
</html>
    """;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = "ejemplo";
    var pdfGenerado = await FlutterHtmlToPdf.convertFromHtmlContent(descripcionHTML, targetPath, targetFileName);
  
    String pdfGeneradoRuta = pdfGenerado.path;

    return pdfGeneradoRuta;
  }
}