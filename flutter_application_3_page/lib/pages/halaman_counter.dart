import 'package:flutter/material.dart';

class HalamanCounter extends StatefulWidget {
  const HalamanCounter({super.key});

  @override
  State<HalamanCounter> createState() => _HalamanCounterState();
}

class _HalamanCounterState extends State<HalamanCounter> {
  int _counter = 0;

  void increment() {
    setState(() {
      _counter++;
    });
  }

  void decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Utama'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Jumlah angka sekarang:'),
            const SizedBox(height: 12),

            // ANIMATED SWITCHER BAGIAN ANGKA
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 120),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                '$_counter',
                key: ValueKey<int>(_counter),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BUTTON KURANG
                ElevatedButton(
                  onPressed: decrement,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 4,
                    shadowColor: Colors.black,
                  ),
                  child: const Text('−', style: TextStyle(fontSize: 24)),
                ),

                const SizedBox(width: 20),

                // BUTTON TAMBAH
                ElevatedButton(
                  onPressed: increment,

                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 4,
                    shadowColor: Colors.black,
                  ),
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
