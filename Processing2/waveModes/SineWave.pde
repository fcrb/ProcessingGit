class SineWave {
  float amplitude;
  float phase;
  int mode;
  int clr;

  SineWave(float amp, float phase_, int mode_, int clr_) {
    amplitude = amp;
    phase = phase_;
    clr = clr_;
    mode = mode_;
  }

  void draw(float yStart, float dy) {
    pushMatrix();
    translate(0, yStart + dy / 2);

    //draw unshifted wave
    float prevY = 0;
    stroke(100);
    strokeWeight(waveStrokeWeight);
    for (float x = 1; x <= width; x += 1) {
      float y_ =  - yNoShift(x);
      line(x - 1, prevY, x, y_);
      prevY = y_;
    }
    //draw actual, phase shifted wave
     prevY = 0;
    stroke(clr);
    strokeWeight(waveStrokeWeight);
    for (float x = 1; x <= width; x += 1) {
      float y_ =  - y(x);
      line(x - 1, prevY, x, y_);
      prevY = y_;
    }
    popMatrix();
  }

  void setMode(int m) {
    mode = m;
  }

  void setPhase(float p) {
    phase = p;
  }
  
  float timeIncrement() {
    return seconds() * 0.1 * mode * simulationSpeed;
  }

  float amp(float x) {
    return amplitude * sin(x / width * PI * mode);
  }

  float y(float x) {
    return amp(x) * sin(timeIncrement() + phase);
  }

  float yNoShift(float x) {
    return amp(x) * sin(timeIncrement());
  }
}

class SumWave {
  ArrayList<SineWave> sineWaves = new ArrayList<SineWave>();

  void addWave(SineWave wave) {
    sineWaves.add(wave);
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
    float prevY = yMid;
    stroke(color(255, 0, 255));
    strokeWeight(waveStrokeWeight );
    for (float x = 0; x <= width; x += 1) {
      float y = yMid;
      for (SineWave sineWave : sineWaves) {
        y -= sineWave.y(x);
      }
      line(x - 1, prevY, x, y);
      prevY = y;
    }
  }

  void setFirstWaveMode(int m) {
    sineWaves.get(0).setMode(m);
  }

  void setSecondWaveMode(int m) {
    sineWaves.get(1).setMode(m);
  }

  void setSecondWavePhase(int m) {
    sineWaves.get(1).setPhase(m * PI / 180);
  }
}
