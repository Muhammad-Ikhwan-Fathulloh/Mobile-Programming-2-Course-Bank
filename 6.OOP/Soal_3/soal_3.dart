import 'dart:io';

import 'armor_titan.dart';
import 'attack_titan.dart';
import 'beast_titan.dart';
import 'human.dart';

void main() {
  print('--------------------------------');
  question_3();
  print('--------------------------------');
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