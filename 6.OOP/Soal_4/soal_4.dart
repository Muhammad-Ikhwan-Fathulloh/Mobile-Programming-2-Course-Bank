import 'dart:io';

import 'employee.dart';

void main() {
  print('--------------------------------');
  question_4();
  print('--------------------------------');
}

void question_4(){
  print('Soal No.4');

  var id = new Employee.id(1);
  var name = new Employee.name('Muhammad Ikhwan Fathulloh');
  var departement = new Employee.departement('Technology');

  print('ID : ${id.id}');
  print('Name : ${name.name}');
  print('Departement : ${departement.departement}');
}