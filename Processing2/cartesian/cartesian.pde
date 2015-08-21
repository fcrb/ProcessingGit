void setup() {
  size(480, 480);
  background(255);
  xLimits(-5, 5);
  yLimits(-5, 5);
  drawGrid();
  drawAxes();

  //  drawLineSegment (-3, -3, 3, 9);
  //  for (int r = 1; r < 11; ++r ) {
  //    drawCircle(-5, 0, r);
  //    drawCircle(5, 0, r);
  //  }  

  Function parabola = new Function() {
    public float value(float x) {
      return x * x * (x-1);
    };
  };

  drawFunction(parabola, 100);
  drawTitle("My drawing");
}
