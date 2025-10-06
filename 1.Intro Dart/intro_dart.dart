import 'dart:io';

void main() {
  print('--------------------------------');
  question_1();
  print('--------------------------------');
  question_2();
  print('--------------------------------');
  question_3();
  print('--------------------------------');
  question_4(10, 5);
  print('--------------------------------');
}
// Soal No. 1 (Membuat kalimat),
// Terdapat kumpulan variable dengan data string sebagai berikut
void question_1(){
  print('Soal No.1');
  var word = 'dart';
  var second = 'is';
  var third = 'awesome';
  var fourth = 'and';
  var fifth = 'I';
  var sixth = 'love';
  var seventh = 'it!';
  print('${word} ${second} ${third} ${fourth} ${fifth} ${sixth} ${seventh}');
}


// Buatlah agar kata-kata di atas menjadi satu kalimat . Output: Dart is awesome and I love it!

// Soal No.2 Mengurai kalimat (Akses karakter dalam string),
// Terdapat satu kalimat seperti berikut: 
void question_2(){
  print('Soal No.2');
  var sentence = "I am going to be Flutter Developer";

  var exampleFirstWord = sentence[0] ;
  var exampleSecondWord = sentence[2] + sentence[3] ;
  var thirdWord = sentence[5] + sentence[6] + sentence[7] + sentence[8] + sentence[9]; // lakukan sendiri
  var fourthWord = sentence[11] + sentence[12]; // lakukan sendiri
  var fifthWord = sentence[14] + sentence[15]; // lakukan sendiri
  var sixthWord = sentence[17] + sentence[18] + sentence[19] + sentence[20] + sentence[21] + sentence[22] + sentence[23]; // lakukan sendiri
  var seventhWord = sentence[25] + sentence[26] + sentence[27] + sentence[28] + sentence[29] + sentence[30] + sentence[31] + sentence[32] + sentence[33]; // lakukan sendiri


  print('First Word: ' + exampleFirstWord);
  print('Second Word: ' + exampleSecondWord);
  print('Third Word: ' + thirdWord);
  print('Fourth Word: ' + fourthWord);
  print('Fifth Word: ' + fifthWord);
  print('Sixth Word: ' + sixthWord);
  print('Seventh Word: ' + seventhWord);

}

// Buat menjadi Output berikut: 
// First word: I
// Second word: am
// Third word: going
// Fourth word: to
// Fifth word: be
// Sixth word: Flutter
// Seventh word: Developer


// Dengan menggunakan I/O pada dart buatlah input dinamis yang akan menginput nama depan dan belakang dan jika di enter
// akan menggabungkan nama depan dan belakang

// contoh :

// masukan nama depan :
// hilmy
// masukan nama belakang :
// firdaus

// nama lengkap anda adalah:
// hilmy firdaus

void question_3(){
  print('Soal No.3');
  print('Masukan nama depan :');
  String? input_nama_depan = stdin.readLineSync()!;
  print('Masukan nama belakang :');
  String? input_nama_belakang = stdin.readLineSync()!;

  print('${input_nama_depan} ${input_nama_belakang}');
}

// Dengan menggunakan operator operasikan variable berikut ini menjadi bentuk operasi perkalian, penjumlahan, pengurangan dan pembagian a = 5,  b = 10 jadi misal a * b = 5 * 10 = 50 dst.

// perkalian : 50
// pembagian : 0.5
// penambahan : 15
// pengurangan : -5

void question_4(int a, int b){
  print('Soal No.4');
  int penambahan = a + b;
  int pengurangan = a - b;
  double pembagian = a / b;
  int perkalian = a * b;

  print('Penambahan: ${penambahan}');
  print('Pengurangan: ${pengurangan}');
  print('Pembagian: ${pembagian}');
  print('Perkalian : ${perkalian}');
}