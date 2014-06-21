import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import beads.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class audioThreeWave extends PApplet {

// Hello_Sine.pde
// import the beads library

// create our AudioContext
AudioContext ac;

//controls
int controlColor = 255;
Checkbox onOffCheckbox, wave3Include;
Slider freqSlider1, freqSlider2, freqSlider3, secondsPerFrameSlider;

//ArrayList<SineWave> sineWaves;
SumWave  sumWave;
float secondsPerFrame;
//float secondsPerPixel;
float waveStrokeWeight = 1;
float commonAmplitude = 10;

public void setup()
{
  size(1280, 360);

  ac = new AudioContext();

  sumWave = new SumWave();
  int minFreq = 220;
  int maxFreq = 440;
  int initialFreq = 440;
  sumWave.addWave(new SineWave(commonAmplitude, initialFreq, color(255, 0, 0)));
  sumWave.addWave(new SineWave(commonAmplitude, initialFreq, color(0, 255, 0)));
  sumWave.addWave(new SineWave(commonAmplitude, initialFreq, color(255, 255, 0)));
  secondsPerFrame = 0.04f;
  int slideLength = 400;
  int slideIncrement = 1;
  int slidePixelsFromBottom = 15;
  String lbl = "Frequency (Hz)";
  int sliderX = width -slideLength - 60;
  freqSlider1 = new Slider(sliderX
    , height /4 - slidePixelsFromBottom
    , slideLength, minFreq, maxFreq
    , slideIncrement, lbl);
  freqSlider2 = new Slider(sliderX
    , height * 2/4 - slidePixelsFromBottom
    , slideLength, minFreq, maxFreq
    , slideIncrement, lbl);
  freqSlider3 = new Slider(sliderX
    , height * 3 / 4 - slidePixelsFromBottom
    , slideLength, minFreq, maxFreq
    , slideIncrement, lbl);
  wave3Include = new Checkbox(20, height * 3/4 - slidePixelsFromBottom - 25, false, "Include");
  onOffCheckbox = new Checkbox(20, height - slidePixelsFromBottom - 25, false, "Sound");
  secondsPerFrameSlider = new Slider(220, height - slidePixelsFromBottom, 
  width / 2, (float) 0.04f, (float) 1, (float) .01f, 
  "Frame width (seconds)");
  ac.out.addInput(sumWave.gain );
}

public float secondsPerPixel() {
  return secondsPerFrame / width;
}

public void draw() {
  //  if(sineWaves == null || sineWaves.size() == 0 ) return;
  background(0);

  // waves
  stroke(220);
  strokeWeight(1);
  sumWave.draw();
  freqSlider1.draw();
  freqSlider2.draw();
  freqSlider3.draw();
  wave3Include.draw();

  secondsPerFrameSlider.draw();
  onOffCheckbox.draw();

  //set controls
  sumWave.setFirstWaveFrequency(freqSlider1.value);
  sumWave.setSecondWaveFrequency(freqSlider2.value);
  sumWave.setThirdWaveFrequency(freqSlider3.value );
  sumWave.setThirdInclude(wave3Include.checked);
  secondsPerFrame = secondsPerFrameSlider.value;
  if (onOffCheckbox.checked) {
    ac.start();
  } 
  else { 
    ac.stop();
  }
}
class Checkbox {
  float x, y, boxWidth = 18;
  boolean checked = false;
  boolean pressHandled = false;
  String label;

  Checkbox(float x_, float y_, boolean checked_, String label_) {
    x = x_;
    y=y_;
    checked = checked_;
    label = label_;
  }

  public boolean mouseInCheckBox() {
    return mouseX >= x && mouseX <= x + boxWidth 
      && mouseY < y + boxWidth && mouseY > y - boxWidth;
  }

  public void draw() {
    pushMatrix();
    translate(x, y);
    if (mousePressed) {
      if (!pressHandled) {
        pressHandled = true;
      }
    } 
    else {
      if (pressHandled && mouseInCheckBox())
        checked = !checked;
      pressHandled = false;
    }

    stroke(controlColor);
    strokeWeight(2);
    noFill();
    rect(0, -boxWidth, boxWidth, boxWidth);
    fill(controlColor);
    if (checked) {
      int inset = 4;
      noStroke();
      rect(0 + inset, -boxWidth+inset, boxWidth-2*inset+1, boxWidth-2*inset+1);
    }
    textSize(boxWidth );
    text(label, boxWidth+5, 0);
    popMatrix();
  }
}
class SineWave {
  float amplitude;
  //  float phaseShift;
  float frequency;
  int clr;
  WavePlayer wavePlayer;
  boolean include = true;

  SineWave(float amp, int freq, int clr_) {
    amplitude = amp;
    clr = clr_;
    frequency = freq;
    wavePlayer = new WavePlayer(ac, freq, Buffer.SINE);
  }

  public void draw(float yStart, float dy) {
    pushMatrix();
    translate(0, yStart + dy / 2);

    //vertical lines to indicate periods
    strokeWeight(0.5f);
    stroke(100);
    float periodInPixels = 1/frequency/secondsPerPixel();
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
    boolean firstPointFound = false;
    float prevY =  - amplitude;
    stroke(clr);
    strokeWeight(waveStrokeWeight);
    for ( x = 1; x <= width; x += 1) {
      float y =  - y(x);
      if ( firstPointFound) {
        line(x - 1, prevY, x, y);
      }
      else { 
        firstPointFound = true;
      }
      prevY = y;
    }
    popMatrix();
  }

  public void setFrequency(float freq) {
    frequency = freq;
    wavePlayer.setFrequency(freq );
  }

  public void setInclude(boolean inc) {
    include = inc;
    wavePlayer.pause(!include);
  }

  public float y(float x) {
    if (!include) return 0;
    return amplitude * cos(frequency * x * secondsPerPixel() * 2 * PI);// + phaseShift);
  }
}

class SumWave {
  ArrayList<SineWave> sineWaves = new ArrayList<SineWave>();
  Gain gain = new Gain(ac, 2, 0.2f); 

  public void addWave(SineWave wave) {
    sineWaves.add(wave);
    gain.addInput(wave.wavePlayer);
  }

  public void draw() {
    float waveFrameHeight = height / (sineWaves.size() + 1);

    int waveCtr = 0;
    float waveSeparator = 0;
    // wave separators
    for (SineWave sineWave : sineWaves) {
      sineWave.draw(waveSeparator, waveFrameHeight);
      ++waveCtr;
      waveSeparator = waveCtr * waveFrameHeight;
      strokeWeight(0.5f);
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

  public void setFreq(int waveIndex, float freq) {
    sineWaves.get(waveIndex).setFrequency(freq);
  }

  public void setFirstWaveFrequency(float freq) {
    setFreq(0, freq);
  }

  public void setSecondWaveFrequency(float freq) {
    setFreq(1, freq);
  }

  public void setThirdWaveFrequency(float freq) {
    setFreq(2, freq);
  }

  public void setThirdInclude(boolean in) {
    sineWaves.get(2).setInclude(in);
  }
}
class Slider {
  float x, y, len, thickness;
  float minValue, maxValue, value, increment;
  boolean pressHandled = false;
  boolean mouseInSlider = false;
  String label;

  Slider(float x_, float y_, float len_, float min_, float max_, float inc_, String label_) {
    x = x_;
    y=y_;
    len = len_;
    minValue = min_;
    maxValue=max_;
    value = minValue;
    thickness = 6;
    increment = inc_;
    label=label_;
  }

  public void draw() {
    pushMatrix();
    translate(x, y);
    if (mousePressed) {
      if (!pressHandled) {
        mouseInSlider = mouseX >= x && mouseX <= x + len 
          && mouseY < y + thickness && mouseY > y - thickness;
        pressHandled = true;
      } 
      if (mouseInSlider) {
        float v = minValue + (maxValue - minValue) * (mouseX - x) / len;
        value = increment * (int) round(v /  increment);
        if (value < minValue) value = minValue;
        if (value > maxValue) value = maxValue;
      }
    } 
    else {
      mouseInSlider = false;
      pressHandled = false;
      //      println("pressHandled="+pressHandled + "  mouseInSlider="+mouseInSlider);
    }

    stroke(200);
    strokeWeight(thickness);
    line(0, 0, len, 0);
    noStroke();
    fill(100);
    ellipse( ((float) value - minValue) / (maxValue - minValue) * len, 0, thickness * 2, thickness * 2);

    fill(255);
    int txtSize = 18;
    //units
    String valueText;
    if (increment >= 1.0f)
      valueText = "" + (int) round(value);
    else
      valueText = "" + value;
    text(valueText, len + 10, txtSize / 3);
    //label
    text(label, - (textWidth(label) + 10), txtSize/3);
    popMatrix();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "audioThreeWave" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
