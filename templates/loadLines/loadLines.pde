color bgColor = color(130, 200, 140);

void setup() {
  size(640, 480);
  String lines[] = loadStrings("http://mrbenson.org/pde/loadLines/getAmazonLandingPage.php");
//  String lines[] = loadStrings("http://mrbenson.org/pde/loadLines/index.html");
//  String lines[] = loadStrings("http://127.0.0.1:8888/phpinfo.php"); //launch MAMP before running this sketch
//  String lines[] = loadStrings("http://www.amazon.com");
  println("there are " + lines.length + " lines");
//  for (int i = 0 ; i < lines.length; i++) {
//    println(lines[i]);
//  }
}

void draw() {
  background(bgColor);
}

