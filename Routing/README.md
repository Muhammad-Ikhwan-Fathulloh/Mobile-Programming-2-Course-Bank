# Flutter Navigation & Routing - Tutorial Lengkap

> 📚 Panduan lengkap untuk memahami Navigation & Routing di Flutter
> 
> **Referensi Proyek:** [READ.Y - Flutter Learning Platform](https://github.com/Muhammad-Ikhwan-Fathulloh/read_y)

---

## 📑 Daftar Isi

1. [Pengenalan Navigation & Routing](#1-pengenalan-navigation--routing)
2. [Anonymous Routes (Basic Navigation)](#2-anonymous-routes-basic-navigation)
3. [Named Routes (Advanced)](#3-named-routes-advanced)
4. [Passing & Returning Data](#4-passing--returning-data)
5. [Bottom Navigation & Tabs](#5-bottom-navigation--tabs)
6. [Drawer Navigation](#6-drawer-navigation)
7. [Advanced Navigation Patterns](#7-advanced-navigation-patterns)
8. [Contoh Implementasi READ.Y](#8-contoh-implementasi-ready)
9. [Best Practices](#9-best-practices)

---

## 1. Pengenalan Navigation & Routing

### Apa itu Navigation?

Navigation adalah proses berpindah dari satu layar (screen/page) ke layar lainnya dalam aplikasi Flutter. Flutter menggunakan konsep **Stack** untuk mengelola halaman-halaman aplikasi.

### Konsep Stack Navigation

```
┌─────────────────┐
│   Page 3        │ ← Top (Current)
├─────────────────┤
│   Page 2        │
├─────────────────┤
│   Page 1 (Home) │ ← Bottom
└─────────────────┘
```

**Operasi Dasar:**
- **Push**: Menambah halaman baru ke atas stack
- **Pop**: Menghapus halaman teratas dari stack
- **Replace**: Mengganti halaman saat ini

### Jenis-jenis Navigation

| Jenis | Deskripsi | Kapan Digunakan |
|-------|-----------|-----------------|
| **Anonymous Routes** | Navigasi langsung tanpa nama route | Aplikasi sederhana, prototype |
| **Named Routes** | Navigasi menggunakan nama route | Aplikasi kompleks, maintainable |
| **Generated Routes** | Route dibuat secara dinamis | Aplikasi dengan routing kompleks |

---

## 2. Anonymous Routes (Basic Navigation)

### 2.1 Push - Navigasi ke Halaman Baru

```dart
// Navigasi sederhana
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => HalamanKedua()),
);
```

### 2.2 Pop - Kembali ke Halaman Sebelumnya

```dart
// Kembali ke halaman sebelumnya
Navigator.pop(context);

// Atau gunakan tombol back otomatis dengan AppBar
AppBar(
  title: Text('Halaman Kedua'),
  // leading otomatis muncul tombol back
)
```

### 2.3 Mengirim Data antar Halaman

```dart
// ======================================
// Halaman Pengirim
// ======================================
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          nama: 'John Doe',
          email: 'john@example.com',
          umur: 25,
        ),
      ),
    );
  },
  child: Text('Lihat Detail'),
);

// ======================================
// Halaman Penerima
// ======================================
class DetailPage extends StatelessWidget {
  final String nama;
  final String email;
  final int umur;
  
  const DetailPage({
    Key? key,
    required this.nama,
    required this.email,
    required this.umur,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail User')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: $nama', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Umur: $umur tahun', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
```

### 2.4 Custom Page Transitions

```dart
// Slide Transition
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HalamanKedua(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );
      
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ),
);

// Fade Transition
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HalamanKedua(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
);
```

---

## 3. Named Routes (Advanced)

### 3.1 Setup Named Routes

```dart
// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Route awal aplikasi
      initialRoute: '/',
      // Daftar semua routes
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/detail': (context) => DetailPage(),
      },
      // Route untuk handle unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => NotFoundPage(),
        );
      },
    );
  }
}
```

### 3.2 Navigasi dengan Named Routes

```dart
// Push named route
Navigator.pushNamed(context, '/profile');

// Push dan hapus route sebelumnya
Navigator.pushReplacementNamed(context, '/home');

// Push dan hapus semua route sebelumnya
Navigator.pushNamedAndRemoveUntil(
  context,
  '/home',
  (route) => false, // Hapus semua
);

// Push dengan kondisi
Navigator.pushNamedAndRemoveUntil(
  context,
  '/home',
  ModalRoute.withName('/login'), // Hapus sampai '/login'
);
```

### 3.3 Passing Arguments dengan Named Routes

```dart
// ======================================
// Mengirim Arguments
// ======================================
Navigator.pushNamed(
  context,
  '/detail',
  arguments: {
    'id': 123,
    'nama': 'John Doe',
    'email': 'john@example.com',
  },
);

// ======================================
// Menerima Arguments - Cara 1
// ======================================
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    final int id = args['id'];
    final String nama = args['nama'];
    final String email = args['email'];
    
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Column(
        children: [
          Text('ID: $id'),
          Text('Nama: $nama'),
          Text('Email: $email'),
        ],
      ),
    );
  }
}

// ======================================
// Menerima Arguments - Cara 2 (Type-safe)
// ======================================
// 1. Buat class untuk arguments
class DetailArguments {
  final int id;
  final String nama;
  final String email;
  
  DetailArguments({
    required this.id,
    required this.nama,
    required this.email,
  });
}

// 2. Kirim arguments dengan class
Navigator.pushNamed(
  context,
  '/detail',
  arguments: DetailArguments(
    id: 123,
    nama: 'John Doe',
    email: 'john@example.com',
  ),
);

// 3. Terima dengan type-safe
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailArguments;
    
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Column(
        children: [
          Text('ID: ${args.id}'),
          Text('Nama: ${args.nama}'),
          Text('Email: ${args.email}'),
        ],
      ),
    );
  }
}
```

### 3.4 Generated Routes (Dynamic Routing)

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Parse route name
        final uri = Uri.parse(settings.name ?? '/');
        
        // Handle berbagai routes
        if (uri.pathSegments.isEmpty) {
          return MaterialPageRoute(builder: (_) => HomePage());
        }
        
        // Route: /detail/:id
        if (uri.pathSegments.first == 'detail') {
          final id = uri.pathSegments.length > 1 
            ? int.tryParse(uri.pathSegments[1]) 
            : null;
            
          return MaterialPageRoute(
            builder: (_) => DetailPage(id: id ?? 0),
          );
        }
        
        // Route: /user/:username
        if (uri.pathSegments.first == 'user') {
          final username = uri.pathSegments.length > 1 
            ? uri.pathSegments[1] 
            : '';
            
          return MaterialPageRoute(
            builder: (_) => UserPage(username: username),
          );
        }
        
        // Unknown route
        return MaterialPageRoute(builder: (_) => NotFoundPage());
      },
    );
  }
}

// Penggunaan
Navigator.pushNamed(context, '/detail/123');
Navigator.pushNamed(context, '/user/johndoe');
```

---

## 4. Passing & Returning Data

### 4.1 Mengembalikan Data dari Halaman

```dart
// ======================================
// Halaman Pertama - Menunggu Data
// ======================================
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _result = 'Belum ada data';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Result: $_result', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Tunggu data dari halaman lain
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormPage()),
                );
                
                // Update state jika ada data
                if (result != null) {
                  setState(() {
                    _result = result;
                  });
                }
              },
              child: Text('Buka Form'),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================
// Halaman Kedua - Mengirim Data Kembali
// ======================================
class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Input')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kirim data kembali dan tutup halaman
                Navigator.pop(context, _nameController.text);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
```

### 4.2 Dialog dengan Return Value

```dart
// Menampilkan dialog dan menunggu hasil
Future<void> _showConfirmDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda yakin?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Ya'),
          ),
        ],
      );
    },
  );
  
  if (result == true) {
    print('User memilih Ya');
  } else {
    print('User memilih Batal');
  }
}
```

### 4.3 Bottom Sheet dengan Return Value

```dart
Future<void> _showOptionsBottomSheet(BuildContext context) async {
  final option = await showModalBottomSheet<String>(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    },
  );
  
  if (option != null) {
    print('Selected: $option');
  }
}
```

---

## 5. Bottom Navigation & Tabs

### 5.1 BottomNavigationBar

```dart
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  
  // Daftar halaman
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    FavoritePage(),
    ProfilePage(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Untuk >3 items
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

### 5.2 Persistent BottomNavigationBar dengan Multiple Navigators

```dart
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  
  // GlobalKey untuk setiap Navigator
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Pop dari navigator yang aktif
        final isFirstRouteInCurrentTab = 
          !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
        
        if (isFirstRouteInCurrentTab) {
          // Jika di route pertama, kembali ke Home tab
          if (_selectedIndex != 0) {
            setState(() => _selectedIndex = 0);
            return false;
          }
        }
        // Jika sudah di Home tab dan route pertama, exit app
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => _getPage(index),
          );
        },
      ),
    );
  }
  
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return SearchPage();
      case 2:
        return FavoritePage();
      case 3:
        return ProfilePage();
      default:
        return HomePage();
    }
  }
}
```

### 5.3 TabBar dengan TabBarView

```dart
class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Navigation'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.star), text: 'Favorites'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            FavoritesTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}

// Custom TabBar dengan Controller
class CustomTabPage extends StatefulWidget {
  @override
  _CustomTabPageState createState() => _CustomTabPageState();
}

class _CustomTabPageState extends State<CustomTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print('Tab changed to: ${_tabController.index}');
      }
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Tab'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.star), text: 'Favorites'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTab(),
          FavoritesTab(),
          SettingsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Pindah ke tab tertentu
          _tabController.animateTo(1);
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
```

---

## 6. Drawer Navigation

### 6.1 Basic Drawer

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'john@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            
            // Menu Items
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Navigate ke home
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
```

### 6.2 Drawer dengan Selected Item

```dart
class ResponsiveDrawer extends StatefulWidget {
  @override
  _ResponsiveDrawerState createState() => _ResponsiveDrawerState();
}

class _ResponsiveDrawerState extends State<ResponsiveDrawer> {
  int _selectedIndex = 0;
  
  final List<DrawerItem> _items = [
    DrawerItem(icon: Icons.home, title: 'Home', route: '/'),
    DrawerItem(icon: Icons.search, title: 'Search', route: '/search'),
    DrawerItem(icon: Icons.favorite, title: 'Favorites', route: '/favorites'),
    DrawerItem(icon: Icons.person, title: 'Profile', route: '/profile'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
            ),
            child: Center(
              child: Text(
                'My App',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final isSelected = index == _selectedIndex;
                
                return ListTile(
                  selected: isSelected,
                  selectedTileColor: Colors.blue.withOpacity(0.1),
                  leading: Icon(
                    item.icon,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, item.route);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  final String route;
  
  DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });
}
```

---

## 7. Advanced Navigation Patterns

### 7.1 Deep Linking

```dart
// Konfigurasi di AndroidManifest.xml
// <intent-filter>
//   <action android:name="android.intent.action.VIEW" />
//   <category android:name="android.intent.category.DEFAULT" />
//   <category android:name="android.intent.category.BROWSABLE" />
//   <data android:scheme="myapp" android:host="detail" />
// </intent-filter>

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Link Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '/');
        
        // Handle: myapp://detail/123
        if (uri.scheme == 'myapp' && uri.host == 'detail') {
          final id = int.tryParse(uri.pathSegments.first) ?? 0;
          return MaterialPageRoute(
            builder: (_) => DetailPage(id: id),
          );
        }
        
        return MaterialPageRoute(builder: (_) => HomePage());
      },
    );
  }
}
```

### 7.2 Navigation Guard (Authentication)

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Check authentication status
        final isLoggedIn = AuthService.instance.isLoggedIn;
        
        // Protected routes
        final protectedRoutes = ['/profile', '/settings', '/dashboard'];
        
        if (protectedRoutes.contains(settings.name) && !isLoggedIn) {
          // Redirect to login
          return MaterialPageRoute(
            builder: (_) => LoginPage(),
          );
        }
        
        // Normal routing
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginPage());
          case '/profile':
            return MaterialPageRoute(builder: (_) => ProfilePage());
          case '/settings':
            return MaterialPageRoute(builder: (_) => SettingsPage());
          default:
            return MaterialPageRoute(builder: (_) => NotFoundPage());
        }
      },
    );
  }
}

// Auth Service (Dummy)
class AuthService {
  static final instance = AuthService._();
  AuthService._();
  
  bool _isLoggedIn = false;
  
  bool get isLoggedIn => _isLoggedIn;
  
  void login() => _isLoggedIn = true;
  void logout() => _isLoggedIn = false;
}
```

### 7.3 Nested Navigation

```dart
// Nested Navigation untuk complex app structure
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Setiap tab punya Navigator sendiri
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => HomeNavigator(),
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => SearchNavigator(),
              );
            },
          ),
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => ProfileNavigator(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

### 7.4 Hero Animation

```dart
// Halaman Pertama
class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List')),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: 'avatar-$index',
              child: CircleAvatar(
                child: Text('${index + 1}'),
              ),
            ),
            title: Text('Item $index'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailHeroPage(index: index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Halaman Detail dengan Hero
class DetailHeroPage extends StatelessWidget {
  final int index;
  
  const DetailHeroPage({required this.index});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail $index')),
      body: Center(
        child: Hero(
          tag: 'avatar-$index',
          child: CircleAvatar(
            radius: 100,
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 60),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 8. Contoh Implementasi READ.Y

Berikut contoh implementasi navigation berdasarkan struktur proyek [READ.Y](https://github.com/Muhammad-Ikhwan-Fathulloh/read_y):

### 8.1 Struktur Folder

```
lib/
├── main.dart
├── models/
│   └── course.dart
├── screens/
│   ├── home_screen.dart
│   ├── course_list_screen.dart
│   ├── course_detail_screen.dart
│   ├── simulation_screen.dart
│   └── profile_screen.dart
├── widgets/
│   ├── course_card.dart
│   └── bottom_nav_bar.dart
└── routes/
    └── app_routes.dart
```

### 8.2 Model Course

```dart
// models/course.dart
class Course {
  final int id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String simulationUrl;
  final double rating;
  
  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.simulationUrl,
    required this.rating,
  });
  
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      simulationUrl: json['simulationUrl'],
      rating: json['rating'].toDouble(),
    );
  }
}
```

### 8.3 App Routes

```dart
// routes/app_routes.dart
class AppRoutes {
  static const String home = '/';
  static const String courseList = '/courses';
  static const String courseDetail = '/course-detail';
  static const String simulation = '/simulation';
  static const String profile = '/profile';
  static const String about = '/about';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => MainNavigationPage());
        
      case courseDetail:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(course: course),
        );
        
      case simulation:
        final url = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => SimulationScreen(url: url),
        );
        
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
        
      case about:
        return MaterialPageRoute(builder: (_) => AboutScreen());
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Page not found: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
```

### 8.4 Main App

```dart
// main.dart
import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(ReadYApp());
}

class ReadYApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'READ.Y',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
```

### 8.5 Main Navigation dengan Bottom Bar

```dart
// screens/main_navigation_page.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'course_list_screen.dart';
import 'profile_screen.dart';

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    HomeScreen(),
    CourseListScreen(),
    ProfileScreen(),
  ];
  
  final List<String> _titles = [
    'READ.Y',
    'Courses',
    'Profile',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.about);
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

### 8.6 Home Screen

```dart
// screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../widgets/course_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Course> featuredCourses = [
    // Data dummy courses
  ];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, size: 60, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Belajar dengan Simulasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Read to be Ready!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Categories
            Text(
              'Kategori',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard(context, 'Fisika', Icons.science, Colors.blue),
                  _buildCategoryCard(context, 'Kimia', Icons.biotech, Colors.green),
                  _buildCategoryCard(context, 'Biologi', Icons.nature, Colors.orange),
                  _buildCategoryCard(context, 'Matematika', Icons.calculate, Colors.purple),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // Featured Courses
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rekomendasi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.courseList);
                  },
                  child: Text('Lihat Semua'),
                ),
              ],
            ),
            SizedBox(height: 12),
            
            // Course Grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: featuredCourses.length,
              itemBuilder: (context, index) {
                return CourseCard(
                  course: featuredCourses[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.courseDetail,
                      arguments: featuredCourses[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.courseList,
          arguments: {'category': title},
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 8.7 Course Detail Screen

```dart
// screens/course_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../routes/app_routes.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  
  const CourseDetailScreen({required this.course});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar dengan Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                course.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: 'course-${course.id}',
                child: Image.network(
                  course.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: Icon(Icons.image, size: 80, color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating & Category
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          course.category,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '${course.rating}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Description
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    course.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Features
                  Text(
                    'Fitur Pembelajaran',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildFeatureItem(Icons.science, 'Simulasi Interaktif'),
                  _buildFeatureItem(Icons.quiz, 'Quiz & Latihan'),
                  _buildFeatureItem(Icons.video_library, 'Video Pembelajaran'),
                  _buildFeatureItem(Icons.assessment, 'Progress Tracking'),
                  
                  SizedBox(height: 80), // Space for button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.simulation,
              arguments: course.simulationUrl,
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow, size: 28),
              SizedBox(width: 8),
              Text(
                'Mulai Simulasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
```

### 8.8 Simulation Screen (WebView)

```dart
// screens/simulation_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimulationScreen extends StatefulWidget {
  final String url;
  
  const SimulationScreen({required this.url});
  
  @override
  _SimulationScreenState createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  late WebViewController _controller;
  bool _isLoading = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulasi Pembelajaran'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onPageFinished: (url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text('Bantuan'),
                      onTap: () {
                        Navigator.pop(context);
                        _showHelpDialog(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Bagikan'),
                      onTap: () {
                        Navigator.pop(context);
                        // Implement share
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.bookmark),
                      title: Text('Simpan'),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Simulasi disimpan!')),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.more_vert),
      ),
    );
  }
  
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bantuan Simulasi'),
        content: Text(
          'Gunakan mouse atau touch untuk berinteraksi dengan simulasi.\n\n'
          'Tips:\n'
          '• Drag untuk memindahkan objek\n'
          '• Klik tombol untuk mengubah parameter\n'
          '• Gunakan slider untuk adjust nilai',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
```

---

## 9. Best Practices

### 9.1 DO's ✅

1. **Gunakan Named Routes untuk aplikasi besar**
   ```dart
   // Good
   Navigator.pushNamed(context, '/profile');
   
   // Avoid untuk app besar
   Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
   ```

2. **Selalu dispose controller dan listener**
   ```dart
   @override
   void dispose() {
     _tabController.dispose();
     _textController.dispose();
     super.dispose();
   }
   ```

3. **Gunakan const constructor untuk performa**
   ```dart
   const DetailPage({Key? key, required this.data}) : super(key: key);
   ```

4. **Handle back button dengan WillPopScope**
   ```dart
   WillPopScope(
     onWillPop: () async {
       // Custom back button behavior
       return true; // atau false untuk prevent
     },
     child: Scaffold(...),
   )
   ```

5. **Validate arguments sebelum digunakan**
   ```dart
   final args = ModalRoute.of(context)?.settings.arguments;
   if (args == null) {
     // Handle error
     return ErrorPage();
   }
   ```

### 9.2 DON'Ts ❌

1. **Jangan hardcode route strings**
   ```dart
   // Bad
   Navigator.pushNamed(context, '/profile/settings');
   
   // Good
   Navigator.pushNamed(context, AppRoutes.profileSettings);
   ```

2. **Jangan lupa pop dialog/bottomsheet**
   ```dart
   // Always pop
   showDialog(...).then((result) {
     if (result != null) {
       // Handle result
     }
   });
   ```

3. **Jangan gunakan BuildContext setelah async**
   ```dart
   // Bad
   Future<void> loadData() async {
     await someAsyncOperation();
     Navigator.push(context, ...); // Context might be disposed
   }
   
   // Good
   Future<void> loadData() async {
     await someAsyncOperation();
     if (mounted) {
       Navigator.push(context, ...);
     }
   }
   ```

4. **Jangan stack terlalu banyak routes**
   ```dart
   // Bad - bisa memory leak
   while (condition) {
     Navigator.push(context, ...);
   }
   
   // Good - hapus route lama
   Navigator.pushReplacementNamed(context, '/next');
   ```

### 9.3 Performance Tips

1. **Gunakan lazy loading untuk routes**
   ```dart
   onGenerateRoute: (settings) {
     // Route hanya dibuat saat dibutuhkan
     return MaterialPageRoute(builder: (_) => getPage(settings.name));
   }
   ```

2. **Cache Navigator keys**
   ```dart
   static final navigatorKey = GlobalKey<NavigatorState>();
   
   MaterialApp(
     navigatorKey: navigatorKey,
     ...
   )
   ```

3. **Gunakan Hero animation bijak**
   ```dart
   // Hanya untuk transition penting
   Hero(
     tag: 'unique-tag',
     child: YourWidget(),
   )
   ```

### 9.4 Code Organization

```
lib/
├── main.dart
├── routes/
│   ├── app_routes.dart          # Route constants
│   ├── route_generator.dart     # Route logic
│   └── route_guards.dart        # Auth guards
├── screens/
│   ├── home/
│   ├── profile/
│   └── settings/
├── widgets/
│   └── navigation/
│       ├── bottom_nav_bar.dart
│       └── drawer_menu.dart
└── utils/
    └── navigation_helper.dart   # Helper functions
```

---

## 📚 Referensi

- [Flutter Navigation Documentation](https://docs.flutter.dev/development/ui/navigation)
- [Material Design Navigation](https://m3.material.io/components/navigation-drawer/overview)
- [READ.Y Project](https://github.com/Muhammad-Ikhwan-Fathulloh/read_y)
- [PhET Simulations](https://phet.colorado.edu/in/)

---

## 🎓 Latihan

1. Buat aplikasi dengan 5 halaman menggunakan Named Routes
2. Implementasikan Bottom Navigation dengan 4 tabs
3. Buat drawer navigation dengan authentication guard
4. Implementasikan Hero animation untuk list ke detail
5. Buat custom page transition (slide, fade, scale)
6. Implementasikan deep linking untuk detail page
7. Buat nested navigation dengan multiple navigators

---

## 📝 Kesimpulan

Navigation & Routing adalah fondasi penting dalam aplikasi Flutter. Dengan memahami konsep stack-based navigation, anonymous routes, named routes, dan berbagai pattern navigation, Anda dapat membuat aplikasi yang user-friendly dan maintainable.

**Key Takeaways:**
- Anonymous Routes untuk prototype dan app sederhana
- Named Routes untuk aplikasi production
- Bottom Navigation untuk main features
- Drawer untuk secondary navigation
- Hero animation untuk smooth transitions
- Proper state management untuk complex navigation