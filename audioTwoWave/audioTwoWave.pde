// Hello_Sine.pde
// import the beads library
import beads.*;
// create our AudioContext
AudioContext ac;

//controls
int controlColor = 255;
Checkbox onOffCheckbox;
Slider freqSlider1, freqSlider2;

//ArrayList<SineWave> sineWaves;
SumWave  sumWave;
float secondsPerFrame;
float secondsPerPixel;
float waveStrokeWeight = 2;

void setup()
{
  size(640, 360);

  ac = new AudioContext();

  sumWave = new SumWave();
  int minFreq = 220;
  int maxFreq = 880;
  int initialFreq = 440;
  sumWave.addWave(new SineWave(25, initialFreq, color(255, 0, 0)));
  sumWave.addWave(new SineWave(25, initialFreq, color(0, 255, 0)));
  secondsPerFrame = 0.04;
  secondsPerPixel = secondsPerFrame / width;
  int slideLength = 100;
  int slideIncrement = 10;
  int slidePixelsFromBottom = 15;
  String lbl = "Frequency (Hz)";
  int sliderX = width -slideLength - 60;
  freqSlider1 = new Slider(sliderX
    , height /3 - slidePixelsFromBottom
    , slideLength, minFreq, maxFreq
    , slideIncrement, lbl);
  freqSlider2 = new Slider(sliderX
    , height * 2/3 - slidePixelsFromBottom
    , slideLength, minFreq, maxFreq
    , slideIncrement, lbl);
  onOffCheckbox = new Checkbox(20, height - slidePixelsFromBottom - 25, false, "Sound");
  ac.out.addInput(sumWave.gain );
}

void draw() {
  //  if(sineWaves == null || sineWaves.size() == 0 ) return;
  background(0);

  // waves
  stroke(220);
  strokeWeight(1);
  sumWave.draw();
  freqSlider1.draw();
  freqSlider2.draw();
  onOffCheckbox.draw();

  //set controls
  sumWave.setFirstWaveFrequency(freqSlider1.value);
  sumWave.setSecondWaveFrequency(freqSlider2.value);
    if (onOffCheckbox.checked) {
    ac.start();
  } 
  else { 
    ac.stop();
  }

}
