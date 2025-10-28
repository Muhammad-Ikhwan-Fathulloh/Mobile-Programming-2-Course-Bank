# Materi: Membangun Aplikasi To-Do Sederhana dengan Flutter BLoC

## Tujuan Pembelajaran

Setelah mengikuti sesi ini, peserta dapat:

* Memahami konsep **state management** dengan **Cubit (BLoC pattern)**.
* Membangun aplikasi to-do sederhana dengan **flutter_bloc**.
* Mengelola state daftar tugas (add, remove, toggle selesai).
* Memisahkan logika bisnis dari tampilan (UI clean architecture).

---

## 1. Persiapan Awal

### a. Instalasi Paket

Buka file `pubspec.yaml`, lalu tambahkan:

```yaml
dependencies:
  flutter_bloc: ^9.1.1
  equatable: ^2.0.5
```

Lalu jalankan:

```bash
flutter pub get
```

### b. Struktur Folder

```
lib/
 ┣ blocs/
 ┃ ┗ todo_cubit.dart
 ┣ models/
 ┃ ┗ todo_model.dart
 ┣ pages/
 ┃ ┗ todo_page.dart
 ┗ main.dart
```

---

## 2. Membuat Model Data

Buat file `models/todo_model.dart`:

```dart
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  Todo copyWith({String? id, String? title, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, title, isDone];
}
```

---

## 3. Membuat Cubit (Logika Bisnis)

Buat file `blocs/todo_cubit.dart`:

```dart
import 'package:bloc/bloc.dart';
import '../models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title) {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    emit([...state, newTodo]);
  }

  void toggleTodo(String id) {
    emit(state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isDone: !todo.isDone);
      }
      return todo;
    }).toList());
  }

  void removeTodo(String id) {
    emit(state.where((todo) => todo.id != id).toList());
  }
}
```

Penjelasan:

* `emit()` digunakan untuk memperbarui state daftar todo.
* `addTodo`, `toggleTodo`, dan `removeTodo` mengatur logika utama aplikasi.

---

## 4. Membuat UI (Halaman To-Do)

Buat file `pages/todo_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_cubit.dart';
import '../models/todo_model.dart';

class TodoPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 To-Do List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input tambah todo
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Tambahkan tugas baru...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<TodoCubit>().addTodo(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: const Text('Tambah'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Daftar To-Do
            Expanded(
              child: BlocBuilder<TodoCubit, List<Todo>>(
                builder: (context, todos) {
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text('Belum ada tugas'),
                    );
                  }
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (_) =>
                                context.read<TodoCubit>().toggleTodo(todo.id),
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                context.read<TodoCubit>().removeTodo(todo.id),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

Penjelasan:

* `BlocBuilder<TodoCubit, List<Todo>>` membangun ulang tampilan setiap kali daftar berubah.
* Checkbox untuk menandai todo selesai.
* Tombol hapus untuk menghapus todo.

---

## 5. Menjalankan Aplikasi

Buat `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/todo_cubit.dart';
import 'pages/todo_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BLoC To-Do',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TodoPage(),
      ),
    );
  }
}
```

---

## 6. Penjelasan Alur

1. `BlocProvider` membuat instance `TodoCubit` dan menyediakan ke seluruh widget.
2. Pengguna menulis teks → klik tombol **Tambah**.
3. `addTodo()` dipanggil → `emit()` state baru (todo bertambah).
4. `BlocBuilder` rebuild otomatis dengan daftar terbaru.
5. Pengguna bisa menandai todo selesai atau menghapusnya.