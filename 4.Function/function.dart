import 'dart:io';

void main() {
  print('--------------------------------');
  teriak();
  print('--------------------------------');
  var num1 = 12;
  var num2 = 4;
  
  var hasilKali = kalikan(num1, num2);
  print('${hasilKali}');
  print('--------------------------------');
  var name = "Muhammad Ikhwan Fathulloh";
  var age = 21;
  var address = "Bandung";
  var hobby = "Ngerakit Sesuatu";

  var kenalan = perkenalan(name, age, address, hobby);
  print(kenalan);
  print('--------------------------------');
  faktorial();
  print('--------------------------------');
}

void teriak(){
  print('Soal No.1');
  print('Halo Sanbers!');
}

kalikan(num1, num2){
  return num1 * num2;
}

perkenalan(name, age, address, hobby){
  print('Soal No.2');
  return 'Nama saya ${name}, umur saya ${age} tahun, alamat saya di ${address}, dan saya punya hobby yaitu ${hobby}!';
}

void faktorial(){
  print('Soal No.3');
  var hasil = 1;
  print('Masukkan input :');
  int? input = int.parse(stdin.readLineSync()!);

  if(input <= 0){
    print('1');
  }else{
    for(int i = 1; i <= input; i++) { 
      hasil *= i;
    }
    print(hasil);
  }
}