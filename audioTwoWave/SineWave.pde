class SineWave {
  float amplitude;
  //  float phaseShift;
  float frequency;
  int clr;
  WavePlayer wavePlayer;

  SineWave(float amp, int freq, int clr_) {
    amplitude = amp;
    clr = clr_;
    frequency = freq;
    wavePlayer = new WavePlayer(ac, freq, Buffer.SINE);
  }

  void draw(float yStart, float dy) {
    pushMatrix();
    translate(0, yStart + dy / 2);

    //vertical lines to indicate periods
    strokeWeight(0.5);
    stroke(100);
    float periodInPixels = 1/frequency/secondsPerPixel;
    float x=0;
    while (x < width) {
      line(x, -dy/2+2, x, dy/2-2);
      x += periodInPixels;
    }

    //horizontal line to indicate ambient pressure
    stroke(150);
    line(1, 0, width-1, 0);
    stroke(100);
    int numberHorizontalGridLines = 5;
    float verticalGridSpace = dy / numberHorizontalGridLines/2;
    for (int i = 1; i < numberHorizontalGridLines;++i) {
      line(1, i * verticalGridSpace, width-1, i * verticalGridSpace);
      line(1, -i * verticalGridSpace, width-1, -i * verticalGridSpace);
    }

    //draw wave
    float prevY =  - amplitude;
    stroke(clr);
    strokeWeight(waveStrokeWeight);
    for ( x = 1; x <= width; x += 1) {
      float y =  - y(x);
      line(x - 1, prevY, x, y);
      prevY = y;
    }
    popMatrix();
  }

  void setFrequency(int freq) {
    frequency = freq;
    wavePlayer.setFrequency(freq );
  }

  float y(float x) {
    //    println(frequency());
    return amplitude * cos(frequency * x * secondsPerPixel * 2 * PI);// + phaseShift);
  }
}

class SumWave {
  ArrayList<SineWave> sineWaves = new ArrayList<SineWave>();
  Gain gain = new Gain(ac, 2, 0.2); 
  ;

  void addWave(SineWave wave) {
    sineWaves.add(wave);
    gain.addInput(wave.wavePlayer);
  }

  void draw() {
    float waveFrameHeight = height / (sineWaves.size() + 1);

    int waveCtr = 0;
    float waveSeparator = 0;
    // wave separators
    for (SineWave sineWave : sineWaves) {
      sineWave.draw(waveSeparator, waveFrameHeight);
      ++waveCtr;
      waveSeparator = waveCtr * waveFrameHeight;
      strokeWeight(0.5);
      line(0, waveSeparator, width, waveSeparator);
    }

    float yMid = height - waveFrameHeight /  2;
    boolean firstPointFound = false;
    float prevY = 0;
    stroke(color(255, 0, 255));
    strokeWeight(waveStrokeWeight );
    for (float x = 0; x <= width; x += 1) {
      float y = yMid;
      for (SineWave sineWave : sineWaves) {
        y -= sineWave.y(x);
      }
      if (firstPointFound) {
        line(x - 1, prevY, x, y);
      }
      firstPointFound = true;
      prevY = y;
    }
  }

  void setFirstWaveFrequency(int freq) {
    sineWaves.get(0).setFrequency(freq);
  }

  void setSecondWaveFrequency(int freq) {
    sineWaves.get(1).setFrequency(freq);
  }
}
