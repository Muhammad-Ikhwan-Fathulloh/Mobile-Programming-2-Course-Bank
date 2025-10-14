import 'dart:io';

void main() {
  print('--------------------------------');
  // question_1();
  print('--------------------------------');
  // question_2();
  print('--------------------------------');
  question_3();
  print('--------------------------------');
}

question_1() async {
  print('Soal No.1');
  var h = Human();

  print('Luffy');
  print('Zoro');
  print('Killer');
  print(h.name);
  await h.getData();
  print(h.name);
}

class Human {
  String name = "nama character one piece";

  Future<void> getData() async{
    await Future.delayed(Duration(seconds: 3));
    name = "Hilmy";
    print('get data [done]');
  }
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

void question_3() async {
  print('Soal No.3');
  print('Ready. Sing');
  await line1();
  line2();
  line3();
  line4();
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