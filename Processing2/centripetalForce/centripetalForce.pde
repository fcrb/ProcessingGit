color bgColor = color(0);
float massKg = 20;
float radiusMeters = 5;
float maxRadiusMeters = 10.0;
float angularSpeedRPM = 10;
int millisLastParameterChange = 0;
float angleLastParameterChange = 0;
boolean parametersChanged = true;

interface JavaScript {
  void showValues(float mass, float radius, float rpm, String force);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {  
  size(480, 480);
  frameRate(60);
}

void draw() {
  background(bgColor);

  //inform browser 
  if (javascript!=null && parametersChanged) {
    javascript.showValues(massKg, radiusMeters, angularSpeedRPM, formatFloat(forceNewtons(), 2)+" N");
    angleLastParameterChange = angleRadians();
    millisLastParameterChange = millis();
    parametersChanged = false;
  }

  //draw spinner
  translate(width/2, height/2);
  float pixelRadius = width / 2 * 0.9 * radiusMeters / maxRadiusMeters;
  strokeWeight(5);
  stroke(150);
  float xTip = pixelRadius * cos(angleRadians());
  float yTip = - pixelRadius * sin(angleRadians());
  line(0, 0, xTip, yTip);
  noStroke();
  fill(255);
  ellipse(0, 0, 10, 10);//center hub

  translate(xTip, yTip);
  rotate(-angleRadians());
  rectMode(CENTER);
  float rectSize = sqrt(massKg) * 3;
  rect(0, 0, rectSize, rectSize);
}

float elapsedSeconds() {
  return 0.001 * (millis() - millisLastParameterChange);
}

float angleRadians() {
  return elapsedSeconds() * angularSpeedRadiansPerSecond() + angleLastParameterChange;
}

float angularSpeedRadiansPerSecond() {
  return angularSpeedRPM /  60.0 * 2 * PI;
}

float angularAcceleration() {
  return radiusMeters * angularSpeedRadiansPerSecond() * angularSpeedRadiansPerSecond();
}

float forceNewtons() {
  return massKg *  angularAcceleration();
}

void setRPM(float rpm) {
  angularSpeedRPM = rpm;
  parametersChanged = true;
}

void setMass(float mass) {
  massKg = mass;
  parametersChanged = true;
}

void setRadius(float r) {
  radiusMeters = r;
  parametersChanged = true;
}


//Utilities
String formatFloat(float x, int numPlaces) {
  int power = 1;
  for (int i = 0; i < numPlaces; ++i)
    power *= 10;
  int expanded = (int) (x * power + 0.5);
  int whole = (int) (expanded / power);
  String frac = ""+ (expanded % power);
  while (frac.length () < numPlaces)
    frac = "0"+frac;
  return ""+whole+"."+frac;
}

String floatAsInt(float x) {
  if (x < 1000000000)
    return "" + (int) (x  + 0.5);
  return "" + x;
}

