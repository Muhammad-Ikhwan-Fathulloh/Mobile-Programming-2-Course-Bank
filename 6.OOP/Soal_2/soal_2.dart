import 'dart:io';

import 'lingkaran.dart';
void main() {
  print('--------------------------------');
  question_2();
  print('--------------------------------');
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