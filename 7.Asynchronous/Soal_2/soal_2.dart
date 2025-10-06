import 'dart:io';

void main() {
  print('--------------------------------');
  question_2();
}

Future delayedPrint(int seconds, String message) {
  final duration = Duration(seconds: seconds);
  return Future.delayed(duration).then((value) => message);
}

void question_2(){
  print('Soal No.2');
  print('Life');
  // print('never flat');
  delayedPrint(2, 'never flat').then((status){
    print(status);
  });
  print('is');
}