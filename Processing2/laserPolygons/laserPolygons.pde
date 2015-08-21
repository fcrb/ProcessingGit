import processing.pdf.*;
float sideLengthPixels = 72;

void setup() {
  size(1728, 1296);
  background(255);
  PGraphics pdf = createGraphics(width, height, PDF, "hexagons18_24.pdf");
  pdf.beginDraw();
  pdf.strokeWeight(0.072);

  hexagons(pdf);
  pdf.dispose();
  pdf.endDraw();
}

void triangles(PGraphics pdf) {
  float rowSep = sideLengthPixels *sqrt(3) /2 ;
  //horizontals
  float yInset = sideLengthPixels/4;
  for (float y = yInset; y < height; y += rowSep) {
    pdf.line(5, y, width -5, y);
  }
  //slants
  rowSep = sideLengthPixels;
  float xOffset = (height - 2 * yInset)/sqrt(3);
  for (float x = sideLengthPixels/2 - xOffset; x < width + xOffset; x += rowSep) {
    float toX = x + xOffset;
    float toY =  height - yInset;
    pdf.line(x, yInset, x + xOffset, height - yInset);
    pdf.line(x, yInset, x - xOffset, height - yInset);
  }
}


void parallelograms(PGraphics pdf) {
  float rowSep = sideLengthPixels *sqrt(3) /2 ;
  //horizontals
  float yInset = sideLengthPixels/4;
  for (float y = yInset; y < height; y += rowSep) {
    pdf.line(5, y, width -5, y);
  }
  //slants
  rowSep = sideLengthPixels * 2;
  float xOffset = (height - 2 * yInset)/sqrt(3);
  for (float x = sideLengthPixels/2 - xOffset; x < width + xOffset; x += rowSep) {
    float toX = x + xOffset;
    float toY =  height - yInset;
    pdf.line(x, yInset, x + xOffset, height - yInset);
  }
}

void truncatedLine(PGraphics pdf, float x0, float y0, float x1, float y1, float inset) {
}

void squares(PGraphics pdf) {
  float rowSep = sideLengthPixels;
  for (float x = rowSep/2; x < width; x += rowSep) {
    pdf.line(x, 30, x, height-30);
  }
  //horizontals
  for (float y = rowSep/2; y < height; y += rowSep) {
    pdf.line(30, y, width -30, y);
  }
}

void hexagons(PGraphics pdf) {
  //horizontals
  float rowSep = sideLengthPixels * sqrt(3);
  float xSlantOffset = rowSep * 2 / sqrt(3);
  float xStart = 5;
  for (int y = 12; y < height; y += rowSep) {
    pdf.line(xStart, y, width -xStart, y);
    //crosses
    if (y + rowSep < height) {
      for (float x = xStart; x < width; x += sideLengthPixels * 2) {
        pdf.line(x, y, x + sideLengthPixels, y + rowSep);
        pdf.line(x + sideLengthPixels, y, x, y + rowSep);
      }
    }
  }
}

void octagons(PGraphics pdf) {
  //These fit on a square grid, so skip right and bottom edge
  // on all but last column and row to avoid duplicate lines
  float rowSep = sideLengthPixels * (1 + sqrt(2));
  for (float x = sideLengthPixels ; x + rowSep < width; x += rowSep) {
    for (float y = sideLengthPixels * 0.5; y + rowSep < height; y += rowSep) {
      pdf.pushMatrix();
      pdf.translate(x, y);
      for (int i = 0; i < 8; ++i) {
        if (i != 2 && i != 4) {
          pdf.line(0, 0, sideLengthPixels, 0);
        } 
        else {
          if (( i == 2  && x + rowSep * 2 >= width) || ( i == 4 && y + rowSep * 2 >= height) )
            pdf.line(0, 0, sideLengthPixels, 0);
        }
        pdf.translate(sideLengthPixels, 0);
        pdf.rotate(PI/4);
      }
      pdf.popMatrix();
    }
  }
}

void dodecagons(PGraphics pdf) {
  //These fit on a square grid, so skip right and bottom edge
  // on all but last column and row to avoid duplicate lines
  float rowSep = sideLengthPixels /tan(PI / 12);
  for (float x = - rowSep * 0.4; x  < width + rowSep; x += rowSep) {
    for (float y = - rowSep * 0.5 ; y  < height; y += rowSep) {
      pdf.pushMatrix();
      pdf.translate(x, y);
      for (int i = 0; i < 12; ++i) {
        if (i != 3 && i != 6) {
          pdf.line(0, 0, sideLengthPixels, 0);
        } 
        else {
          if (( i == 3  && x - rowSep >= width) || ( i == 6 && y  >= height) )
            pdf.line(0, 0, sideLengthPixels, 0);
        }
        if (i == 5) {
          //add a square
          float rotation =  10 * PI /12;
          pdf.rotate(-rotation);
          for (int j = 0; j < 4; ++j) {
            pdf.line(0, 0, sideLengthPixels, 0);
            pdf.translate(sideLengthPixels, 0);
            pdf.rotate(PI/2);
          }
          pdf.rotate(rotation);
        }
        pdf.translate(sideLengthPixels, 0);
        pdf.rotate(PI/6);
      }
      pdf.popMatrix();
    }
  }
}
