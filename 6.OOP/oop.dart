import 'dart:io';

import 'lingkaran.dart';

import 'armor_titan.dart';
import 'attack_titan.dart';
import 'beast_titan.dart';
import 'human.dart';

import 'employee.dart';

void main() {
  print('--------------------------------');
  // question_1();
  print('--------------------------------');
  // question_2();
  print('--------------------------------');
  question_3();
  print('--------------------------------');
  // question_4();
  print('--------------------------------');
}

void question_1(){
  print('Soal No.1');
  LuasSegitiga segitiga;
  double luasSegitiga;

  segitiga = new LuasSegitiga();
  segitiga.setengah = 0.5;
  segitiga.alas = 20.0;
  segitiga.tinggi = 30.0;

  luasSegitiga = segitiga.hitungLuas();
  print('Luas Segitiga: ${luasSegitiga}');
}

class LuasSegitiga{
  late double setengah;
  late double alas;
  late double tinggi;

  double hitungLuas(){
    return this.setengah * alas * tinggi;
  }
}

void question_2(){
  print('Soal No.2');
  Lingkaran bulat;
  double luasBulat;

  bulat = new Lingkaran();
  bulat.setJari_jari(4);

  luasBulat = bulat.getLuas();
  print('Luas Lingkaran : ${luasBulat}');
}

void question_3(){
  print('Soal No.3');
  Armor_Titan art = Armor_Titan();
  Attack_Titan att = Attack_Titan();
  Beast_Titan bat = Beast_Titan();
  Human h = Human();

  art.powerPoint = 8;
  att.powerPoint = 9;
  bat.powerPoint = 10;
  h.powerPoint = 11;

  print('Power Point Armor Titan : ${art.powerPoint}');
  print('Power Point Attack Titan : ${att.powerPoint}');
  print('Power Point Beast Titan : ${bat.powerPoint}');
  print('Power Point Human : ${h.powerPoint}');

  print('Sifat dari Armor Titan : ${art.terjang()}');
  print('Sifat dari Attack Titan : ${att.punch()}');
  print('Sifat dari Beast Titan : ${bat.lempar()}');
  print('Sifat dari Human : ${h.killAlltitan()}');
}

void question_4(){
  print('Soal No.4');

  var id = new Employee.id(1);
  var name = new Employee.name('Muhammad Ikhwan Fathulloh');
  var departement = new Employee.departement('Technology');

  print('ID : ${id.id}');
  print('Name : ${name.name}');
  print('Departement : ${departement.departement}');
}