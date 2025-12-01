# Flutter Animations & Transitions

## Implicit & Explicit Animations

Animasi adalah salah satu elemen UI paling penting dalam Flutter karena membuat aplikasi terasa lebih hidup, natural, dan interaktif. Flutter menyediakan dua pendekatan inti:

1. Implicit Animation
2. Explicit Animation

Dokumen ini akan menjelaskan secara detail konsep dasar animasi, contoh implementasi, dan praktikum lengkap untuk dipraktikkan langsung.

---

# 1. Implicit Animation

## 1.1 Pengertian Implicit Animation

Implicit Animation adalah animasi yang berubah secara otomatis ketika sebuah nilai (misalnya: ukuran, warna, margin, alignment) diubah. Developer cukup memanggil `setState` untuk mengubah nilai, dan Flutter akan meng-handle animasinya.

Tidak memerlukan:

* AnimationController
* Tween
* AnimatedBuilder

Implicit Animation cocok untuk UI sederhana hingga menengah.

---

## 1.2 Widget Implicit Animation yang Penting

| Widget                   | Fungsi                                         |
| ------------------------ | ---------------------------------------------- |
| AnimatedContainer        | Animasi ukuran, warna, border, margin, padding |
| AnimatedOpacity          | Animasi transparansi                           |
| AnimatedAlign            | Animasi perpindahan posisi                     |
| AnimatedPadding          | Animasi padding                                |
| AnimatedPositioned       | Untuk Stack                                    |
| AnimatedCrossFade        | Pergantian antar dua widget                    |
| AnimatedDefaultTextStyle | Animasi style text                             |
| TweenAnimationBuilder    | Paling fleksibel, tidak perlu controller       |

---

## 1.3 Contoh Dasar AnimatedContainer

### Penjelasan:

* Saat tombol ditekan, size, color, dan borderRadius berubah.
* Flutter menganimasikannya secara otomatis.

### Contoh Kode Lengkap

```dart
import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  double size = 100;
  Color color = Colors.blue;
  double radius = 20;

  void animateBox() {
    setState(() {
      size = size == 100 ? 200 : 100;
      color = color == Colors.blue ? Colors.red : Colors.blue;
      radius = radius == 20 ? 50 : 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Implicit Animation")),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: animateBox,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
```

---

## 1.4 Contoh Lanjutan: TweenAnimationBuilder

TweenAnimationBuilder memberi lebih banyak fleksibilitas tanpa membuat controller.

### Contoh

```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0, end: 1),
  duration: Duration(seconds: 1),
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: Transform.scale(
        scale: value,
        child: child,
      ),
    );
  },
  child: Text(
    "Hello Tween!",
    style: TextStyle(fontSize: 24),
  ),
);
```

---

# 2. Explicit Animation

## 2.1 Pengertian Explicit Animation

Explicit Animation memberi kontrol penuh kepada developer, seperti:

* Mengatur kapan animasi dimulai
* Reverse, repeat, stop
* Menggabungkan banyak animasi
* Membuat animasi kompleks

Membutuhkan komponen:

* AnimationController
* Tween
* Animation
* AnimatedBuilder

---

## 2.2 Komponen Utama

### 1. AnimationController

Mengatur durasi, repeat, reverse, dll.

### 2. Tween

Rentang nilai (misalnya dari 0 → 1, atau 100 → 300).

### 3. CurvedAnimation

Memberi efek kurva (easeInOut, bounce, elastic).

### 4. AnimatedBuilder

Widget yang mendengarkan nilai animasi.

---

## 2.3 Contoh Explicit Animation dengan AnimationController

### Contoh Kode Lengkap

```dart
import 'package:flutter/material.dart';

class ExplicitAnimationExample extends StatefulWidget {
  @override
  _ExplicitAnimationExampleState createState() =>
      _ExplicitAnimationExampleState();
}

class _ExplicitAnimationExampleState extends State<ExplicitAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    sizeAnimation = Tween<double>(begin: 100, end: 200)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    controller.forward();
  }

  void reverseAnimation() {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explicit Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: sizeAnimation,
          builder: (context, child) {
            return Container(
              width: sizeAnimation.value,
              height: sizeAnimation.value,
              color: Colors.green,
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: startAnimation,
            child: Icon(Icons.arrow_forward),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: reverseAnimation,
            child: Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
```

---

# 3. Transition Animation

Transition Animation adalah animasi perpindahan seperti:

* FadeTransition
* SlideTransition
* ScaleTransition
* SizeTransition
* RotationTransition

Biasanya digunakan pada PageRouteBuilder atau widget dinamis.

---

## 3.1 Contoh FadeTransition + AnimationController

```dart
FadeTransition(
  opacity: controller,
  child: Text(
    "Fade Text",
    style: TextStyle(fontSize: 30),
  ),
);
```

---

# 4. Praktikum Lengkap

Berikut 3 praktikum lengkap beserta output dan kode contoh.

---

## Praktikum 1: Implicit Animation (AnimatedContainer)

### Tujuan

* Menganimasi ukuran, warna, dan border radius.

### Langkah Pengerjaan

1. Buat project Flutter baru.
2. Buat file `animated_container_praktikum.dart`.
3. Implementasikan perubahan nilai pada `setState`.

### Contoh Output

Kotak berubah bentuk, warna, dan ukuran setiap tombol ditekan.

### Contoh Kode Praktikum

```dart
import 'package:flutter/material.dart';

class PraktikumAnimatedContainer extends StatefulWidget {
  @override
  _PraktikumAnimatedContainerState createState() =>
      _PraktikumAnimatedContainerState();
}

class _PraktikumAnimatedContainerState
    extends State<PraktikumAnimatedContainer> {
  double size = 120;
  Color color = Colors.orange;
  double radius = 10;

  void animate() {
    setState(() {
      size = size == 120 ? 200 : 120;
      color = color == Colors.orange ? Colors.purple : Colors.orange;
      radius = radius == 10 ? 50 : 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Praktikum 1: Implicit Animation")),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: animate,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
```

---

## Praktikum 2: Explicit Animation – ScaleTransition

### Tujuan

* Membuat animasi membesar–mengecil menggunakan controller.

### Langkah

1. Buat AnimationController
2. Buat Tween 1 → 2
3. Gunakan ScaleTransition
4. Tambahkan tombol forward dan reverse

### Contoh Kode Praktikum

```dart
import 'package:flutter/material.dart';

class PraktikumScaleTransition extends StatefulWidget {
  @override
  _PraktikumScaleTransitionState createState() =>
      _PraktikumScaleTransitionState();
}

class _PraktikumScaleTransitionState extends State<PraktikumScaleTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    scale = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void forwardAnim() => controller.forward();
  void reverseAnim() => controller.reverse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Praktikum 2: Scale Transition")),
      body: Center(
        child: ScaleTransition(
          scale: scale,
          child: Container(
            width: 120,
            height: 120,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: forwardAnim,
            child: Icon(Icons.arrow_forward),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: reverseAnim,
            child: Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
```

---

## Praktikum 3: Fade Page Transition (Navigator)

### Tujuan

* Membuat navigasi halaman dengan animasi fade.

### Langkah

1. Buat dua halaman
2. Navigasi memakai PageRouteBuilder
3. Gunakan FadeTransition

### Contoh Kode Praktikum

#### main.dart

```dart
import 'package:flutter/material.dart';
import 'fade_page_1.dart';

void main() => runApp(MaterialApp(home: FadePage1()));
```

#### fade_page_1.dart

```dart
import 'package:flutter/material.dart';
import 'fade_page_2.dart';

class FadePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Praktikum 3: Page 1")),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to Page 2"),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 700),
                pageBuilder: (_, __, ___) => FadePage2(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
```

#### fade_page_2.dart

```dart
import 'package:flutter/material.dart';

class FadePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Praktikum 3: Page 2")),
      body: Center(
        child: Text("Halaman Kedua", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
```

---

# Kesimpulan

Implicit Animation:

* Mudah digunakan
* Ideal untuk perubahan nilai sederhana

Explicit Animation:

* Kontrol penuh
* Cocok untuk animasi kompleks

Transition Animation:

* Digunakan untuk perpindahan widget dan navigasi