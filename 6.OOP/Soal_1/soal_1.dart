import 'dart:io';

void main() {
  print('--------------------------------');
  question_1();
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