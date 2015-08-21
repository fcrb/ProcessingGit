ArrayList<Range> ranges;
int numMountainRanges = 5;

void setup() {
  size(1000, 150);
  ranges = new ArrayList<Range>(numMountainRanges);
  for (int rangeCtr = 0; rangeCtr < numMountainRanges; ++rangeCtr) {
    int greyLevel = 256 - (rangeCtr + 1) * 256 / numMountainRanges;
    int rangeColor = color(greyLevel, greyLevel, greyLevel); 
    ranges.add(new Range(rangeColor, 3 * (numMountainRanges - rangeCtr)));
  }
}

void draw() {
  background(255);
  for(Range range: ranges) {
    range.draw();
    range.scroll();
  }
}
