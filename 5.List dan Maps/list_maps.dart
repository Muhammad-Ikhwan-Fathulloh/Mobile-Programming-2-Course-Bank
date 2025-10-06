import 'dart:io';

void main() {
  print('--------------------------------');
  range(1, 10);
  print('--------------------------------');
  rangeWithStep(1, 10, 2);
  print('--------------------------------');
  var input = [
    ["0001", "Roman Alamsyah", "Bandar Lampung", "21/05/1989", "Membaca"],
    ["0002", "Dita Sembiring", "Medan", "10/10/1992", "Bermain Gitar"],
    ["0003", "Winona", "Ambon", "25/12/1965", "Memasak"],
    ["0004", "Bintang Senjaya", "Martapura", "6/4/1970", "Berkebun"],
  ];
  dataHandling(input);
  print('--------------------------------');
}

void range(start, finish){
  print('Soal No.1');
  var range = [];
  for (int i = start; i <= finish; i++) {
    range.add(i);
  }
  print(range);
}

void rangeWithStep(start, finish, step){
  print('Soal No.2');
  var range = [];
  for (int i = start; i <= finish; i++) {
    if(i % step != 0) {
      range.add(i);
    }
  }
  print(range);
}

void dataHandling(input){
  print('Soal No.3');
  input.forEach((data)=>
  print('Nomor ID : ${data[0]} \nNama Lengkap : ${data[1]} \nTTL : ${data[2]} ${data[3]} \nHobi : ${data[4]} \n'));
}