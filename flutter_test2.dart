void main() {
  // Program yang mencetak angka dari 1 sampai 100
  // Kelipatan 3: "Developer"
  // Kelipatan 5: "Indonesia"
  // Kelipatan 3 dan 5: "Developer Indonesia"

  for (int i = 1; i <= 100; i++) {
    if (i % 3 == 0 && i % 5 == 0) {
      print('Developer Indonesia');
    } else if (i % 3 == 0) {
      print('Developer');
    } else if (i % 5 == 0) {
      print('Indonesia');
    } else {
      print(i);
    }
  }
}
