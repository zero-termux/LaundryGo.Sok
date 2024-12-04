import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic>? pesananBaru; // Data pesanan baru dari form

  const CartPage({Key? key, this.pesananBaru}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> pesananList = [
    {
      'status': 'diproses',
      'nama': 'abid',
      'paket': 'paket a',
      'gambar': 'assets/gambar1.jpg'
    },
    {
      'status': 'selesai',
      'nama': 'aldo',
      'paket': 'paket b',
      'gambar': 'assets/gambar2.jpg'
    },
    {
      'status': 'dibatalkan',
      'nama': 'agus',
      'paket': 'paket c',
      'gambar': 'assets/gambar3.jpg'
    },
  ];

  String selectedFilter = 'semua';

  @override
  void initState() {
    super.initState();
    // Tambahkan data baru jika ada
    if (widget.pesananBaru != null) {
      pesananList.add(widget.pesananBaru!);
    }
  }

  List<Map<String, dynamic>> get filteredPesananList {
    if (selectedFilter == 'semua') {
      return pesananList;
    } else {
      return pesananList
          .where((pesanan) => pesanan['status'] == selectedFilter)
          .toList();
    }
  }

  void setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 38, 74, 1),
        title: const Text(
          'Rincian pesanan',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFilterButton('semua'),
                buildFilterButton('diproses'),
                buildFilterButton('selesai'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPesananList.length,
              itemBuilder: (context, index) {
                final pesanan = filteredPesananList[index];
                return buildPesananCard(pesanan);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterButton(String filter) {
    return TextButton(
      onPressed: () => setFilter(filter),
      child: Text(filter),
      style: TextButton.styleFrom(
        backgroundColor: selectedFilter == filter
            ? const Color.fromRGBO(0, 38, 74, 1)
            : Colors.grey[300],
        foregroundColor:
            selectedFilter == filter ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

Widget buildPesananCard(Map<String, dynamic> pesanan) {
  // Menentukan warna berdasarkan status
  Color statusColor;
  if (pesanan['status'] == 'diproses') {
    statusColor = Colors.yellow;
  } else if (pesanan['status'] == 'selesai') {
    statusColor = Colors.green;
  } else {
    statusColor = Colors.red;
  }

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              pesanan['gambar'], // Gambar dari data
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pesanan['status'],
                  style: TextStyle(
                    color: statusColor, // Warna teks status
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pesanan['paket'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(pesanan['nama']),
              ],
            ),
          ),
          // Tombol Rincian dan Sampah
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.info, color: Colors.blue),
                onPressed: () {
                  // Logika untuk tombol rincian
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Logika untuk tombol hapus
                  setState(() {
                    pesananList.remove(pesanan);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
