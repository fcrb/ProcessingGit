import processing.pdf.*;

String inputFileName = "GoThrones_bw";
float[] widthsInInches =  new float[]{11.75};

void setup() {
  size(1436, 1444);//  size(32, 39);
  initializeEdgeCalculator();
  background(255);
  noSmooth();
  PImage img = loadImage("input/"+inputFileName+".png");
  image(img, 0, 0);

  for(float w : widthsInInches) {
    int wholePart = (int) w;
    String wString = ""+wholePart + '_' + nf( round(100 * (w - wholePart)), 2);
    createEdgeOnlyPDF(inputFileName+'/'+inputFileName+'_'+wString+"in.pdf", 72 * w );
//    createEdgeOnlyPDFSheet(inputFileName+'/'+inputFileName+'_'+wString+"inSheet.pdf", 72 * w, 1,2);
  }
}
