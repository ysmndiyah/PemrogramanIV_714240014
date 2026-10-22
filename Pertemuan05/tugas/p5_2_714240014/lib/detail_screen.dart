import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String name;
  final String npm;

  const DetailScreen({
    super.key,
    required this.name,
    required this.npm,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> galleryImages = [
      'images/listview1.jpeg', 
      'images/listview5.jpeg',
      'images/listview3.jpeg',
      'images/listview4.jpeg',
      'images/listview2.jpeg',
      'images/listview6.jpeg',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Staatliches',
                fontSize: 28,
              ),
            ),
            Text(
              'NPM: $npm',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Deskripsi Singkat:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Mahasiswi D4 Teknik Informatika ULBI yang berminat di dunia IT, khususnya pada pengembangan website dan aplikasi mobile. Memiliki pengalaman dalam pengembangan aplikasi menggunakan Flutter dan React, serta aktif berorganisasi. Tentunya suka naik gunung juga, walaupun nggak galau ya',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              'Galeri Aktivitas:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: galleryImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        galleryImages[index],
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}