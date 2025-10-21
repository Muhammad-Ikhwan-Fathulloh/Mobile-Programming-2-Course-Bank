# **Teori: Flutter Basic Widgets dan Theme**

## 1. **Pengantar Widget di Flutter**

Flutter menggunakan **widget** sebagai elemen dasar untuk membangun antarmuka.
Segala sesuatu di layar (teks, gambar, tombol, tata letak, dll.) adalah **widget**.

### Jenis widget:

* **StatelessWidget** → tidak memiliki perubahan (tidak menyimpan state).
* **StatefulWidget** → dapat berubah sesuai interaksi pengguna.

---

## 2. **Perbedaan Stateless vs Stateful Widget**

| Aspek               | StatelessWidget                                                | StatefulWidget                                                     |
| ------------------- | -------------------------------------------------------------- | ------------------------------------------------------------------ |
| Definisi            | Widget yang tampilannya **tetap**, tidak berubah saat runtime. | Widget yang bisa **berubah**, tergantung input pengguna atau data. |
| Contoh penggunaan   | Teks statis, gambar tetap, layout sederhana.                   | Tombol dengan counter, switch tema, input form.                    |
| Struktur kode       | Hanya `build()` method.                                        | Memiliki `State` class yang berisi `setState()`.                   |
| Fungsi `setState()` | Tidak ada.                                                     | Digunakan untuk memperbarui UI saat data berubah.                  |

**Contoh sederhana:**

### Stateless Widget

```dart
class HaloFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Halo Flutter!');
  }
}
```

### Stateful Widget

```dart
class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Nilai counter: $counter'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              counter++;
            });
          },
          child: Text('Tambah'),
        ),
      ],
    );
  }
}
```

---

## 3. **Widget Dasar Flutter**

### a. Text

Widget `Text` menampilkan teks di layar.

```dart
Text(
  'Halo Flutter!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blueAccent,
  ),
)
```

### b. Image

Menampilkan gambar dari:

1. **URL (Network)**
2. **Lokal (Assets)**

#### **Gambar dari URL**

```dart
Image.network('https://flutter.dev/images/flutter-logo-sharing.png', width: 100);
```

#### **Gambar dari lokal (assets)**

1. Simpan gambar di folder `assets/images/flutter_logo.png`.
2. Tambahkan di `pubspec.yaml`:

   ```yaml
   flutter:
     assets:
       - assets/images/flutter_logo.png
   ```
3. Gunakan widget:

   ```dart
   Image.asset('assets/images/flutter_logo.png', width: 100);
   ```

---

## 4. **Widget Layout**

Layout digunakan untuk mengatur posisi elemen di layar.

### a. Column

Menyusun widget **secara vertikal**.

```dart
Column(
  children: [
    Text('Baris 1'),
    Text('Baris 2'),
  ],
)
```

### b. Row

Menyusun widget **secara horizontal**.

```dart
Row(
  children: [
    Text('Kiri'),
    Text('Kanan'),
  ],
)
```

### c. Container

Membungkus widget lain dengan properti tambahan seperti warna, padding, margin, dan ukuran.

```dart
Container(
  padding: EdgeInsets.all(16),
  color: Colors.grey[200],
  child: Text('Ini dalam Container'),
)
```

---

## 5. **Widget ListTile**

`ListTile` digunakan untuk menampilkan data daftar sederhana seperti kontak atau item list.

```dart
ListTile(
  title: Text('Tekno'),
  subtitle: Text('tekno@test.com'),
)
```

---

## 6. **Theme dan Font**

### a. ThemeData

Mendefinisikan warna, gaya teks, dan bentuk komponen global dalam aplikasi.

```dart
theme: ThemeData(
  primarySwatch: Colors.teal,
  fontFamily: 'Poppins',
),
```

### b. Custom Font

1. Tambahkan font di folder `assets/fonts/Poppins-Regular.ttf`
2. Daftarkan di `pubspec.yaml`:

   ```yaml
   flutter:
     fonts:
       - family: Poppins
         fonts:
           - asset: assets/fonts/Poppins-Regular.ttf
   ```
3. Gunakan:

   ```dart
   Text('Halo Flutter', style: TextStyle(fontFamily: 'Poppins'))
   ```

---

## 7. **Contoh Implementasi Lengkap Gambar Lokal**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(LatihanGambarLokal());
}

class LatihanGambarLokal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Latihan - Gambar Lokal')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/flutter_logo.png',
                width: 120,
              ),
              SizedBox(height: 16),
              Text(
                'Ini gambar dari lokal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Tujuan hasil:** menampilkan gambar dari folder lokal (`assets/images`) dan teks di bawahnya.