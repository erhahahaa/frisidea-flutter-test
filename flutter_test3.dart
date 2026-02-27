import 'dart:io';

// Fungsi untuk menghitung bilangan Fibonacci menggunakan metode iterasi
int fibonacci(int n) {
  if (n < 0) {
    throw ArgumentError('Input harus bilangan non-negatif');
  }

  if (n <= 1) {
    return n;
  }

  int a = 0;
  int b = 1;

  for (int i = 2; i <= n; i++) {
    int temp = a + b;
    a = b;
    b = temp;
  }

  return b;
}

void main() {
  // Program untuk menghitung bilangan Fibonacci
  // Indeks dimulai dari 0: F(0)=0, F(1)=1, F(2)=1, F(3)=2, dst.

  stdout.write('Masukkan angka: ');
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print('Error: Input tidak valid');
    return;
  }

  try {
    int n = int.parse(input);

    if (n < 0) {
      print('Error: Masukkan angka non-negatif');
      return;
    }

    int hasil = fibonacci(n);
    print('Bilangan Fibonacci ke-$n adalah: $hasil');

    // Menampilkan beberapa contoh untuk referensi
    if (n <= 10) {
      print('\nContoh urutan Fibonacci:');
      for (int i = 0; i <= 10; i++) {
        print('F($i) = ${fibonacci(i)}');
      }
    }
  } catch (e) {
    print('Error: Masukkan angka yang valid');
  }
}
