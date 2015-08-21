//controls
int controlColor = 255;
Slider modeSlider1, modeSlider2, speedSlider;
Checkbox pauseCheckbox;
//Slider phaseSlider2;

SumWave  sumWave;  
float waveStrokeWeight = 2;
float simulationSpeed = 1;
float sec = -1;
float simStartTime;

void setup()
{
  size(640, 360);

  sumWave = new SumWave();
  int minMode = 1;
  int maxMode = 10;
  sumWave.addWave(new SineWave(height /12, 0, 1, color(255, 0, 0)));
  sumWave.addWave(new SineWave(height /12, 0, 2, color(0, 255, 0)));
  int slideLength = 180;
  int slideIncrement = 1;
  int slidePixelsFromBottom = 15;
  String lbl = "Modes";
  int sliderX = width -slideLength - 40;
  modeSlider1 = new Slider(sliderX
    , height /3 - slidePixelsFromBottom
    , slideLength, minMode, maxMode
    , slideIncrement, lbl);
  modeSlider2 = new Slider(sliderX
    , height * 2/3 - slidePixelsFromBottom
    , slideLength, minMode, maxMode
    , slideIncrement, lbl);
  speedSlider = new Slider(sliderX
    , height  - slidePixelsFromBottom
    , slideLength, 1, 100
    , 1, "sim speed");
  pauseCheckbox = new Checkbox(20, height - slidePixelsFromBottom - 25, false, "Pause");
  //  phaseSlider2 = new Slider(175
  //    , height * 2/3 - slidePixelsFromBottom
  //    , 80, 0, 360
  //    , 10, "phase shift (deg)");
  simStartTime = millis();
}

float seconds() {
  if (pauseCheckbox.checked) {
    if (sec < 0) {
      sec = millis() * 0.001;
    } 
    return sec;
  } 
  else {
    sec = -1;
    return millis() * 0.001;
  }
}


void draw() {
  background(0);

  // waves
  stroke(220);
  strokeWeight(1);
  sumWave.draw();
  modeSlider1.draw();
  modeSlider2.draw();
  speedSlider.draw();
//  pauseCheckbox.draw();
  //  phaseSlider2.draw();

  //set controls
  sumWave.setFirstWaveMode(modeSlider1.value);
  sumWave.setSecondWaveMode(modeSlider2.value);
  simulationSpeed = speedSlider.value;
  //  sumWave.setSecondWavePhase(phaseSlider2.value);
}
