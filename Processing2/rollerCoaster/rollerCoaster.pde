void setup() {
  int n = 1;
  while (n <= 100000000) {
    int max = 0;
    for (int i = 1; i <= n; ++i) {
      int r = roller(i);
      if (r > max) {
        max = r;
      }
    }
    println("max roller coaster value for n<= " + n + " is "+max);
    n *= 10;
  }
}

int roller(int j) {
  if ( j <= 1) return 0;
  if (j % 2 == 0) {
    return 1 + roller(j / 2);
  }
  return 1 + roller(3*j+ 1);
}
