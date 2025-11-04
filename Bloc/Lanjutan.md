# **Membangun Aplikasi To-Do dengan Flutter BLoC (Advanced Widgets Edition)**

## **Tujuan Pembelajaran**

Setelah sesi ini, peserta dapat:

1. Memahami konsep **state management** dengan Cubit (BLoC Pattern).
2. Membangun aplikasi **To-Do multi-halaman** dengan **navigasi dan detail tugas**.
3. Menggunakan widget lanjutan: **ListView, GridView, Stack, dan Custom Widget**.
4. Memisahkan logika bisnis, data model, dan UI secara modular (clean architecture).

---

## **Konsep Dasar**

### 🔹 Apa yang Berbeda dari Versi Dasar?

| Fitur           | Versi Dasar          | Versi Advanced                         |
| --------------- | -------------------- | -------------------------------------- |
| Manajemen State | Cubit sederhana      | Cubit modular multi-page               |
| Navigasi        | 1 halaman            | Multi halaman (Home, Detail, Grid)     |
| Model Todo      | Hanya title & status | Tambah deskripsi, tanggal, prioritas   |
| Widget          | ListView sederhana   | ListView, GridView, Stack, Custom Card |
| UI              | Flat                 | Material + Hero Animation + Responsive |

---

## **1. Struktur Folder Proyek**

```
lib/
 ┣ blocs/
 ┃ ┗ todo_cubit.dart
 ┣ models/
 ┃ ┗ todo_model.dart
 ┣ pages/
 ┃ ┣ todo_home_page.dart
 ┃ ┣ todo_detail_page.dart
 ┃ ┗ todo_grid_page.dart
 ┣ widgets/
 ┃ ┗ todo_card.dart
 ┗ main.dart
```

---

## **2. Model Data Lengkap**

**File:** `models/todo_model.dart`

```dart
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isDone;
  final String priority; // low, medium, high

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
    this.priority = 'medium',
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isDone,
    String? priority,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [id, title, description, date, isDone, priority];
}
```

---

## **3. Logika Bisnis (Cubit)**

**File:** `blocs/todo_cubit.dart`

```dart
import 'package:bloc/bloc.dart';
import '../models/todo_model.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title, String description, String priority) {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      date: DateTime.now(),
      priority: priority,
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

---

## **4. Membuat Custom Widget (TodoCard)**

**File:** `widgets/todo_card.dart`

```dart
import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onDelete,
    required this.onToggle,
  });

  Color get priorityColor {
    switch (todo.priority) {
      case 'high': return Colors.redAccent;
      case 'low': return Colors.green;
      default: return Colors.orangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: todo.id,
      child: Stack(
        children: [
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              onTap: onTap,
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (_) => onToggle(),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                todo.priority.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

**Widget ini menggunakan Stack** untuk menampilkan label prioritas di atas card.

---

## **5. Halaman Utama (Home Page)**

**File:** `pages/todo_home_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_cubit.dart';
import '../models/todo_model.dart';
import '../widgets/todo_card.dart';
import 'todo_detail_page.dart';
import 'todo_grid_page.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  String priority = 'medium';

  void _addTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Tugas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Judul')),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Deskripsi')),
            DropdownButtonFormField<String>(
              value: priority,
              items: const [
                DropdownMenuItem(value: 'low', child: Text('Low')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'high', child: Text('High')),
              ],
              onChanged: (value) => setState(() => priority = value!),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                context.read<TodoCubit>().addTodo(
                      titleController.text,
                      descController.text,
                      priority,
                    );
                titleController.clear();
                descController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TodoGridPage()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodoDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('Belum ada tugas'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoCard(
                todo: todo,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TodoDetailPage(todo: todo),
                  ),
                ),
                onDelete: () =>
                    context.read<TodoCubit>().removeTodo(todo.id),
                onToggle: () =>
                    context.read<TodoCubit>().toggleTodo(todo.id),
              );
            },
          );
        },
      ),
    );
  }
}
```

---

## **6. Halaman Detail**

**File:** `pages/todo_detail_page.dart`

```dart
import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo todo;
  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Hero(
        tag: todo.id,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text('Prioritas: ${todo.priority.toUpperCase()}'),
              const SizedBox(height: 10),
              Text('Tanggal dibuat: ${todo.date}'),
              const Divider(),
              Text(todo.description),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## **7. Halaman GridView**

**File:** `pages/todo_grid_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_cubit.dart';
import '../models/todo_model.dart';
import '../widgets/todo_card.dart';
import 'todo_detail_page.dart';

class TodoGridPage extends StatelessWidget {
  const TodoGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid View')),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('Tidak ada tugas'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.1,
            ),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoCard(
                todo: todo,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TodoDetailPage(todo: todo),
                  ),
                ),
                onDelete: () =>
                    context.read<TodoCubit>().removeTodo(todo.id),
                onToggle: () =>
                    context.read<TodoCubit>().toggleTodo(todo.id),
              );
            },
          );
        },
      ),
    );
  }
}
```

---

## **8. Main Entry**

**File:** `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/todo_cubit.dart';
import 'pages/todo_home_page.dart';

void main() => runApp(const AdvancedTodoApp());

class AdvancedTodoApp extends StatelessWidget {
  const AdvancedTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Advanced Flutter BLoC To-Do',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blueAccent,
        ),
        home: const TodoHomePage(),
      ),
    );
  }
}
```