import 'package:flutter/material.dart';
import 'form.dart'; // Import form.dart untuk akses ke FormPage
import 'cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry Go.Sok',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromRGBO(0, 38, 74, 1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Perbarui fungsi navigasi dengan memperbaiki parameter

  void navigateToForm(String paket) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            FormPage(paket: paket), // Menyertakan paket sebagai parameter
      ),
    );
  }

  // Metode untuk mengambil gambar berdasarkan paket
  String getImageForTab(int index) {
    switch (index) {
      case 0:
        return 'assets/gambar1.jpg'; // Gambar untuk Paket A
      case 1:
        return 'assets/gambar2.jpg'; // Gambar untuk Paket B
      case 2:
        return 'assets/gambar3.jpg'; // Gambar untuk Paket C
      default:
        return 'assets/gambar1.jpg'; // Default Gambar jika terjadi kesalahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian AppBar Custom
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            color: const Color.fromRGBO(0, 38, 74, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Laundry Go.Sok',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Laundry Murah dan Kekinian',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      color: Colors.white,
                      onPressed: () {
                        // Navigasi ke halaman keranjang belanja
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
                          ), // Pastikan CartPage tersedia
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Isi halaman
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Layanan Kami',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 38, 74, 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TabBar(
                    controller: _tabController,
                    labelColor: const Color.fromRGBO(0, 38, 74, 1),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color.fromRGBO(0, 38, 74, 1),
                    tabs: const [
                      Tab(text: 'Paket A'),
                      Tab(text: 'Paket B'),
                      Tab(text: 'Paket C'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        buildPackageView('Paket A', 0),
                        buildPackageView('Paket B', 1),
                        buildPackageView('Paket C', 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPackageView(String paket, int index) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                getImageForTab(index),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            navigateToForm(paket);
          },
          icon: const Icon(
            Icons.shopping_bag,
            color: Colors.white,
          ),
          label: const Text(
            'Pesan Paket Ini',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 38, 74, 1),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 100),
          ),
        ),
      ],
    );
  }
}
