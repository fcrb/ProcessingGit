void setup() {
  size(210,1000);
  // Draw points
int n = 0;
for (int j = 0; j < height; j++) {
  for (int i = 0; i < width; i++) {
    n += 1;
    stroke(isPrime(n) ? 255 : 0);
    point(i,j);
  }
}
}

 boolean isPrime(int n) {
  if(n == 2)
    return true;
  if(n < 2 || n % 2 == 0)
    return false;
  int factor = 3;
  while(factor * factor <= n) {
    if ( n % factor == 0)
      return false;
    factor += 2;
  }
  return true;
} 


