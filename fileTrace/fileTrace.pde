import processing.pdf.*;
EdgeCalculator edgeCalculator;
String inputFileName = "witchFoot1";
float[] widthsInInches =  new float[] {
  11.75
};

void setup() {
  size(713, 338);//  size(32, 39);
  initializeNeighborPixelArray();
  edgeCalculator = new EdgeCalculator(inputFileName);

  for (float w : widthsInInches) {
    int wholePart = (int) w;
    String wString = ""+wholePart + '_' + nf( round(100 * (w - wholePart)), 2);
    createEdgeOnlyPDF(inputFileName+'/'+inputFileName+'_'+wString+"in.pdf", 72 * w );
    ////    createEdgeOnlyPDFSheet(inputFileName+'/'+inputFileName+'_'+wString+"inSheet.pdf", 72 * w, 1,2);
  }
}

void draw() {
  image(edgeCalculator.img, 0, 0);
  loadPixels();
  int zoomRadius = 5;

  if (mouseX < zoomRadius || mouseX > width - zoomRadius) return;
  if (mouseY < zoomRadius || mouseY > height - zoomRadius) return;

  int zoomScale = 10;

  //  translate(mouseX, mouseY);
  rectMode(CENTER);
  stroke(220, 100);
  for (int dx = -zoomRadius; dx <= zoomRadius; ++dx) {
    for (int dy = -zoomRadius; dy <= zoomRadius; ++dy) {
      int x = mouseX + dx;
      int y = mouseY + dy;
      int pxlIndex = x + y * width;
      if (pxlIndex >= 0 && pxlIndex < pixels.length) { 
        int pxl = pixels[x + y * width];
        fill(pxl);
        rect(mouseX + dx * zoomScale, mouseY + dy * zoomScale, zoomScale, zoomScale);
      }
    }
  }
}
