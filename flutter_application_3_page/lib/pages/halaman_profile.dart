import 'package:flutter/material.dart';

class HalamanProfile extends StatelessWidget {
  const HalamanProfile({super.key});

  final List<Map<String, String>> anggota = const [
    {
      'nama': 'Daniel Daud Alberthus',
      'ttl': 'Magelang, 14 Februari 2003',
      'alamat': 'Jl. Pondok Pesantren No. 4b, Cimanggis',
      'gambar': 'assets/images/Daniel.jpg',
    },
    {
      'nama': 'Siti Intan Nia',
      'ttl': 'Bandung, 17 Agustus 1998',
      'alamat': 'Jl. Dago Atas No. 7, Bandung',
      'gambar': 'assets/images/Intan.jpg',
    },
    {
      'nama': 'Ihsan Adi Putra',
      'ttl': 'Yogyakarta, 5 Mei 1997',
      'alamat': 'Jl. Kaliurang Km. 10, Sleman',
      'gambar': 'assets/images/Esan.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Profil Anggota'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: anggota.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final member = anggota[index];

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 200)),
            tween: Tween(begin: 0, end: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // kotak dengan rounded corner
                      child: Image.asset(
                        member['gambar']!,
                        width: 140,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      member['nama']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tempat, Tanggal Lahir:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(member['ttl']!, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(
                      'Alamat/Kota Asal:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(member['alamat']!, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
