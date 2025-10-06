import 'dart:io';

void main() {
  print('--------------------------------');
  question_3();
}

void question_3() async {
  print('Soal No.3');
  print('Ready. Sing');
  await line1();
  await line2();
  await line3();
  await line4();
}

Future<void> line1() async {
  return await Future.delayed(Duration(seconds: 5), () => (
    print('pernahkan kau merasa')
  ));
}

Future<void> line2() async {
  return await Future.delayed(Duration(seconds: 3), () => (
    print('pernahkan kau merasa.....')
  ));
}

Future<void> line3() async {
   return await Future.delayed(Duration(seconds: 2), () => (
    print('pernahkan kau merasa')
  ));
}

Future<void> line4() async {
   return await Future.delayed(Duration(seconds: 1), () => (
    print('Hatimu hampa, pernahkan kau merasa hati mu kosong....')
  ));
}