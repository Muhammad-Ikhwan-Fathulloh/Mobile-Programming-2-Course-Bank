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
  print('Masukan input y/t :');
  String? input = stdin.readLineSync()!;

  if (input == 'y') {
    print('anda akan menginstall aplikasi dart');
  }else{
    print('aborted');
  }
}

void question_2(){
  print('Soal No.2');
  print('Masukan nama :');
  String? nama = stdin.readLineSync()!;

  print('Masukan peran :');
  String? peran = stdin.readLineSync()!;

  if (nama == '' && peran == '') {
    print('Nama harus diisi!');
    question_2();
  }else if(nama != '' && peran == ''){
    print('Halo ${nama}, Pilih peranmu untuk memulai game!');
    question_2();
  }else if(nama != '' && peran != ''){
    if(peran.toLowerCase() == 'penyihir'){
      print('Selamat datang di Dunia Werewolf, ${nama}" "Halo Penyihir ${nama}, kamu dapat melihat siapa yang menjadi werewolf!');
    }else if(peran.toLowerCase() == 'guard'){
      print('Selamat datang di Dunia Werewolf, ${nama}" "Halo Guard ${nama}, kamu akan membantu melindungi temanmu dari serangan werewolf.');
    }else if(peran.toLowerCase() == 'werewolf'){
      print('Selamat datang di Dunia Werewolf, ${nama}" "Halo Werewolf ${nama}, Kamu akan memakan mangsa setiap malam!');
    }
  }
}

void question_3(){
  print('Soal No.3');
  print('Masukan Hari :');
  String? hari = stdin.readLineSync()!;
  switch(hari) {
    case 'Senin':{ 
      print('Segala sesuatu memiliki kesudahan, yang sudah berakhir biarlah berlalu dan yakinlah semua akan baik-baik saja.'); 
      break; 
    }
    case 'Selasa':{ 
      print('Setiap detik sangatlah berharga karena waktu mengetahui banyak hal, termasuk rahasia hati.'); 
      break; 
    }
    case 'Rabu':{ 
      print('Jika kamu tak menemukan buku yang kamu cari di rak, maka tulislah sendiri.'); 
      break;
    }
    case 'Kamis':{ 
      print('Jika hatimu banyak merasakan sakit, maka belajarlah dari rasa sakit itu untuk tidak memberikan rasa sakit pada orang lain.');
      break;
    }
    case 'Jumat':{ 
      print('Hidup tak selamanya tentang pacar.');
      break;
    }
    case 'Sabtu':{ 
      print('Rumah bukan hanya sebuah tempat, tetapi itu adalah perasaan.');
      break;
    }
    case 'Minggu':{ 
      print('Hanya seseorang yang takut yang bisa bertindak berani. Tanpa rasa takut itu tidak ada apapun yang bisa disebut berani.');
      break;
    }
    default:{ 
      print('Input tidak sesuai'); 
    }
  }
}

void question_4(){
  print('Soal No.4');
  var hari = 21; 
  var bulan = 1; 
  var tahun = 1945;

  if(hari >= 1 && hari <= 31){
    if(bulan >= 1 && bulan <= 12){
      if(tahun >= 1900 && tahun <= 2200){
        switch(bulan) {
          case 1:{ 
            print('${hari} Januari ${tahun}');
            break; 
          }
          case 2:{ 
            print('${hari} Februari ${tahun}');
            break; 
          }
          case 3:{ 
            print('${hari} Maret ${tahun}');
            break;
          }
          case 4:{ 
            print('${hari} April ${tahun}');
            break;
          }
          case 5:{ 
            print('${hari} Mei ${tahun}');
            break;
          }
          case 6:{ 
            print('${hari} Juni ${tahun}');
            break;
          }
          case 7:{ 
            print('${hari} Juli ${tahun}');
            break;
          }
          case 8:{ 
            print('${hari} Agustus ${tahun}');
            break;
          }
          case 9:{ 
            print('${hari} September ${tahun}');
            break;
          }
          case 10:{ 
            print('${hari} Oktober ${tahun}');
            break;
          }
          case 11:{ 
            print('${hari} November ${tahun}');
            break;
          }
          case 12:{ 
            print('${hari} Desember ${tahun}');
            break;
          }
          default:{ 
            print('Input tidak sesuai'); 
          }
        }
      }else{
        print('Input tahun tidak sesuai');
      }
    }else{
      print('Input bulan tidak sesuai');
    }
  }else{
    print('Input hari tidak sesuai');
  }

  

}