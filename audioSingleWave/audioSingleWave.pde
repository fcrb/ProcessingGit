// Hello_Sine.pde
// import the beads library
import beads.*;
// create our AudioContext
AudioContext ac;

//controls
int controlColor = 255;
Checkbox onOffCheckbox;
Slider freqSlider;

//SumWave  sumWave;
float secondsPerFrame;
float secondsPerPixel;
float waveStrokeWeight = 2;
SineWave wave;

void setup()
{
  size(640, 180);

  ac = new AudioContext();

  //  sumWave = new SumWave();
  int minFreq = 880;
  int maxFreq = 23000;
  int initialFreq = minFreq;
  wave = new SineWave(height *0.4, initialFreq, color(255, 0, 0));
  secondsPerFrame = 0.0003;
  secondsPerPixel = secondsPerFrame / width;
  int slideIncrement = 10;
  int slidePixelsFromBottom = 15;
  String lbl = "Frequency (Hz)";
  int sliderX = 160;
  int slideLength = width - sliderX - 70;
  freqSlider = new Slider(sliderX
    , height - slidePixelsFromBottom
    , slideLength, minFreq, maxFreq
    , slideIncrement, lbl);
  onOffCheckbox = new Checkbox(20, height - slidePixelsFromBottom - 25, false, "Sound");
  Gain gain = new Gain(ac, 1, 0.4); 
  gain.addInput(wave.wavePlayer);
  ac.out.addInput(gain );
  // ac.start();
}

void draw() {
  background(0);

  // waves
  stroke(220);
  strokeWeight(1);
  wave.draw(0, height);
  freqSlider.draw();
  onOffCheckbox.draw();

  //frequency slider
  wave.setFrequency(freqSlider.value);
  if (onOffCheckbox.checked) {
    ac.start();
  } 
  else { 
    ac.stop();
  }
}
