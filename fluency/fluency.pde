GameController currentController;
GameController nullController;
boolean userNameInitialized = false;
String userName_ = null;
HashMap<String, GameController>  controllers;
ArrayList<GameController>  gameControllers;
float spaceBetweenTiles = 10.0;
float headerAndFooterHeight = 60;
float tileWidth;
float distanceBetweenAnswers;
//int answersPerRow;
String timesSymbol = "\u00D7";
String equivSymbol = "\u2261";
ArrayList<TraceBall> tracers;
int numTracers = 80;

interface JavaScript {
  void showValues();
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

void setup() {
  size(400, 520);
  controllers = new HashMap<String, GameController>();
  gameControllers = new ArrayList<GameController>();

  nullController = addController(new NullController());
  currentController = nullController;

  addController(new AdditionOnlyController());
  addController(new BinaryController());
  addController(new SubtractionOnlyController());
  addController(new AdditionController());
  addController(new GCFController()); 
  addController(new LCMController()); 
  addController(new LogBaseTenController()); 
  addController(new MultiplicationController()); 
  addController(new FactoringController()); 
  addController(new ModulusController()); 
  addController(new ModulusNineController()); 
  addController(new MultiplyNegativesController()); 
  addController(new ReduceFractionsController()); 
  addController(new SquaresController()); 
  addController(new TwoDigitAdditionController()); 

  if (inJavascriptMode()) {
    currentController = nullController;
  }
  currentController.restart();

  frameRate(30);
  tracers = new ArrayList<TraceBall>();
  for (int i = 0 ; i < numTracers; ++i) {
    float easing = (i  + 20.0 ) / (  numTracers + 30.0);
    tracers.add(new TraceBall( easing));
  }
}

void draw() {
  currentController.drawView();
}

GameController addController(GameController c) {
  gameControllers.add(c);
  if (c.name().length() > 0)
    controllers.put(c.name(), c);
  return c;
}

void printConsole(String s) {
//  if (!inJavascriptMode())
//   // println(s);
  // console.log(s);
}

boolean inJavascriptMode() {
  return true;
}

void mouseReleased() {
  currentController.handleMouseRelease();
}


void restart() {
  currentController.restart();
}

void showScoreReport() {
  currentController = nullController;
  restart();
}

String roundFloat(float f, int numPlaces) {
  int wholePart = (int) f;
  float fracPart = f - wholePart;
  for (int i = 0; i < numPlaces; ++i)
    fracPart *= 10;
  //fracPart += 0.5;
  String fracPartOfAnswer = "" + ((int)fracPart);
  while (fracPartOfAnswer.length () < numPlaces)
    fracPartOfAnswer ="0"+fracPartOfAnswer;
  return "" + wholePart + "." + fracPartOfAnswer;
}

String roundFloatPadded(float f, int numPlaces, int stringLength) {
  String padded = "                " + roundFloat(f, numPlaces);
  return padded.substring(padded.length() - stringLength);
}

String intPadded(int n, int stringLength) {
  String padded = "                 " + n;
  return padded.substring(padded.length() - stringLength);
}


void selectPractice(String controllerName) {
  printConsole(controllerName);
  GameController selectedController = controllers.get(controllerName);
  printConsole(""+selectedController);
  if (selectedController == null)
    selectedController = nullController;
  currentController = selectedController;
  currentController.restart();
}

String userName() {
  if (!inJavascriptMode())
    return "";   
  if (!userNameInitialized) {
    String lines[] = loadStrings("mrb_username.php");
  //  console.log(lines[0]);
    if (lines.length > 0) {
      userName_ = lines[0];
    } 
    else { 
      userName_ = "";
    }
    userNameInitialized = true;
  }
  return userName_;
}
