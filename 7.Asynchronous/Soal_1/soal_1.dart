import 'dart:io';

void main() {
  print('--------------------------------');
  question_1();
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