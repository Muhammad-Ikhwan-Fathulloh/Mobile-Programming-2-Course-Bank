## **Latihan 1 — Text dan Image**

**Tujuan:** memahami penggunaan dasar widget `Text` dan `Image`.

### Langkah-langkah:

1. Buat project baru:

   ```bash
   flutter create latihan_basic_widgets
   ```
2. Buka file `lib/main.dart` dan ubah isinya menjadi:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(LatihanSatu());
}

class LatihanSatu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Latihan 1 - Text & Image')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://flutter.dev/images/flutter-logo-sharing.png',
                width: 120,
              ),
              SizedBox(height: 16),
              Text(
                'Halo Flutter!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
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

**Tujuan hasil:** Menampilkan logo Flutter dan teks di tengah layar.

---

## **Latihan 2 — Layout Menggunakan Container, Column, dan Row**

**Tujuan:** memahami bagaimana mengatur tata letak elemen di Flutter.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(LatihanDua());
}

class LatihanDua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Latihan 2 - Layout')),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data Mahasiswa',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Nama: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Tekno'),
                ],
              ),
              Row(
                children: [
                  Text('NIM: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('2101001'),
                ],
              ),
              Row(
                children: [
                  Text('Jurusan: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Teknologi Informasi'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Tujuan hasil:** Tampilan data mahasiswa dalam bentuk teks rapi secara vertikal.

---

## **Latihan 3 — ListTile Tanpa Ikon**

**Tujuan:** menampilkan daftar data dengan struktur teks.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(LatihanTiga());
}

class LatihanTiga extends StatelessWidget {
  final List<Map<String, String>> kontak = [
    {'nama': 'Tekno', 'email': 'tekno@test.com'},
    {'nama': 'Tekni', 'email': 'tekni@test.com'},
    {'nama': 'Tekna', 'email': 'tekna@test.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Latihan 3 - ListTile')),
        body: ListView(
          children: kontak.map((data) {
            return ListTile(
              title: Text(data['nama']!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(data['email']!),
            );
          }).toList(),
        ),
      ),
    );
  }
}
```

**Tujuan hasil:** Daftar nama dan email tersusun rapi tanpa ikon tambahan.

---

## **Latihan 4 — Custom Theme dan Font**

**Tujuan:** menerapkan font dan warna tema secara global.

1. Tambahkan font ke folder `assets/fonts/Poppins-Regular.ttf`
2. Ubah file `pubspec.yaml`:

   ```yaml
   flutter:
     fonts:
       - family: Poppins
         fonts:
           - asset: assets/fonts/Poppins-Regular.ttf
   ```
3. Ubah file `main.dart`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(LatihanEmpat());
}

class LatihanEmpat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Latihan 4 - Theme & Font')),
        body: Center(
          child: Text('Belajar Flutter dengan Font Kustom!'),
        ),
      ),
    );
  }
}
```

**Tujuan hasil:** Teks ditampilkan dengan font Poppins dan tema warna teal.

---

# **MINI PROJEK: PROFILE CARD APP**

---

## Tujuan:

Menggabungkan semua konsep — widget dasar, layout, font, dan theme — dengan logika `StatefulWidget`.

---

## **1. Struktur Project**

```
lib/
 ├── main.dart
 ├── screens/
 │    └── profile_page.dart
 └── theme/
      └── app_theme.dart
```

---

## **2. File `app_theme.dart`**

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    fontFamily: 'Poppins',
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    fontFamily: 'Poppins',
  );
}
```

---

## **3. File `profile_page.dart`**

```dart
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name = 'Tekno';
  final String title = 'Scrolling Engineer';
  final String description = 'Scrol Fesnuk, Yapping';
  final String email = 'tekno@test.com';
  final String phone = '+62 812 3456 7890';
  final String imageUrl = 'https://flutter.dev/images/flutter-logo-sharing.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 3,
          margin: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(imageUrl, width: 100),
                SizedBox(height: 16),
                Text(name, style: Theme.of(context).textTheme.titleLarge),
                Text(title, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Text(description, textAlign: TextAlign.center),
                Divider(height: 30),
                Text('Email: $email'),
                Text('Telepon: $phone'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## **4. File `main.dart`**

```dart
import 'package:flutter/material.dart';
import 'screens/profile_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(ProfileCardApp());
}

class ProfileCardApp extends StatefulWidget {
  @override
  State<ProfileCardApp> createState() => _ProfileCardAppState();
}

class _ProfileCardAppState extends State<ProfileCardApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card App',
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Card App'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
              child: Text(
                isDark ? 'Light' : 'Dark',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: ProfilePage(),
      ),
    );
  }
}
```

---

## **Penjelasan Alur**

| Konsep              | Penjelasan                                                       |
| ------------------- | ---------------------------------------------------------------- |
| **StatelessWidget** | `ProfilePage` → tidak berubah, hanya menampilkan data.           |
| **StatefulWidget**  | `ProfileCardApp` → bisa mengganti tema saat tombol ditekan.      |
| **Theme & Font**    | Didefinisikan di `AppTheme` agar konsisten di seluruh aplikasi.  |
| **Layout**          | Menggunakan `Column`, `Padding`, dan `Card` untuk tampilan rapi. |

---

## **Tugas Akhir**

Kembangkan mini proyek dengan fitur:

1. Tambahkan form sederhana (nama, email, telepon) yang dapat diubah menggunakan `TextField` dan `setState()`.
2. Tambahkan halaman "Tentang" dengan deskripsi aplikasi (navigasi menggunakan `Navigator.push()`).
3. Tambahkan pilihan tema otomatis dengan `ThemeMode.system`.