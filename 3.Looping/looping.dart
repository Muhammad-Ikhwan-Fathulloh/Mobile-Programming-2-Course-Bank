import 'dart:io';

void main() {
  print('--------------------------------');
  question_1();
  print('--------------------------------');
  question_2();
  print('--------------------------------');
  question_3();
  print('--------------------------------');
  question_4();
  print('--------------------------------');
}

void question_1(){
  print('Soal No.1');
  var maju = 0;
  while(maju <= 20) { 
    if((maju%2) == 0){
      print('${maju} - I love coding');
    }
    maju++; 
  } 

  var mundur = 20;
  while(mundur >= 0) { 
    if((mundur%2) == 0){
      print('${mundur} - I will become a mobile developer');
    }
    mundur--; 
  } 
}

void question_2(){
  print('Soal No.2');
  for(int i = 1; i <= 20; i++) {
    if((i % 3) != 0){
      if((i % 2) == 1) {
        print('${i} Santai');
      }else if((i % 2) == 0) {
        print('${i} Berkualitas');
      }
    }else if((i % 2) == 0) {
      print('${i} Berkualitas');
    }else if((i % 3) == 0) {
      print('${i} I Love Coding');
    }
  }
}

void question_3(){
  print('Soal No.3');
  var hasil = '';
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 8; j++){
      hasil += '* ';
    }
    hasil += '\n';
  }
  print(hasil);
}

void question_4(){
  print('Soal No.4');
  var hasil = '';
  for(int i = 0; i < 8; i++){
    for(int j = 0; j < i; j++){
      hasil += '* ';
    }
    hasil += '\n';
  }
  print(hasil);
}