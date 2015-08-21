// Hello_Sine.pde
// import the beads library
import beads.*;
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

void setup()
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
  secondsPerFrame = 0.04;
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
  width / 2, (float) 0.04, (float) 1, (float) .01, 
  "Frame width (seconds)");
  ac.out.addInput(sumWave.gain );
}

float secondsPerPixel() {
  return secondsPerFrame / width;
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
