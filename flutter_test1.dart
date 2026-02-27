import 'dart:io';

void main() {
  // Program untuk mengecek apakah sebuah angka adalah bilangan ganjil atau genap

  stdout.write('Masukkan angka: ');
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print('Error: Input tidak valid');
    return;
  }

  try {
    int angka = int.parse(input);

    if (angka % 2 == 0) {
      print('$angka adalah bilangan genap');
    } else {
      print('$angka adalah bilangan ganjil');
    }
  } catch (e) {
    print('Error: Masukkan angka yang valid');
  }
}
