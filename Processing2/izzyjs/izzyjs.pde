int izzyNumber = 0;
int uniqueCombinations = 0;
void setup() {
  size(320, 320);
  frameRate(2);
  background(0);
}

void draw() {
  //stop drawing once all combinations are shown
  if (izzyNumber > 255) return;
  background(0);
  translate(width/2, height/2);
  strokeWeight(1.5);
  stroke(255);
  fill(255);
  int izzyCopy = izzyNumber;
  //draw up to 8 triangles
  for (int i = 0; i < 8; ++i ) {
    if (izzyCopy % 2 == 1) {
      triangle(0, 0, sin(i * PI /4) * width, -cos(i * PI /4) * width
        , sin((i+1) * PI /4) * width, -cos((i+1) * PI /4) * width);
    }
    izzyCopy = (int) (izzyCopy / 2);
  }
  textSize(32);
  fill(128);

  //is this izzy new?
  int testNumber = izzyNumber;
  boolean isNew = true;
  for (int i = 0; i < 3; ++i) {
    //rotateByTwoBits
    testNumber = ((int)(testNumber / 4))  + ((testNumber % 4) * 64);
    if (testNumber < izzyNumber) {
      isNew = false;
    }
  }
  if (isNew) {
    ++uniqueCombinations;
    String izzyString = "" + uniqueCombinations;
    text(izzyString, -textWidth(izzyString)/2, height*0.3);
  }

  ++izzyNumber;
} 

int rotateByTwoBits(int n) {
  return (n >> 2) + (n << 6);
}

