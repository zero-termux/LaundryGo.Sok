import 'package:flutter/material.dart';
import 'cart.dart'; // Import halaman CartPage

class FormPage extends StatelessWidget {
  final String paket;

  const FormPage({super.key, required this.paket});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController teleponController = TextEditingController();
    final TextEditingController alamatController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulir Pemesanan',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(0, 38, 74, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesanan: $paket',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 38, 74, 1),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: teleponController,
              decoration: const InputDecoration(
                labelText: 'No Telepon',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: alamatController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    // Menentukan gambar berdasarkan paket
                    String gambar;
                    if (paket == 'paket a') {
                      gambar = 'assets/gambar1.jpg';
                    } else if (paket == 'paket b') {
                      gambar = 'assets/gambar2.jpg';
                    } else {
                      gambar = 'assets/gambar3.jpg';
                    }

                    // Kirim data ke halaman Cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                          pesananBaru: {
                            'status': 'diproses',
                            'nama': namaController.text,
                            'paket': paket,
                            'gambar': gambar,
                          },
                        ),
                      ),
                    );
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 38, 74, 1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                ),
                child: const Text(
                  'Kirim',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
