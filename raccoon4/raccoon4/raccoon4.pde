Raccoon rocky;
ArrayList<Food> foods;

void setup() { 
  size(640, 240);
  rocky = new Raccoon(width/2, height/2);
  rocky.setScale(0.5);
  int numberFoods = 1000;
  foods = new ArrayList<Food>();
  for (int i = 0; i < numberFoods; ++i) {
    foods.add(new Food(0, 0).teleport());
  }
}

void draw() {
  background(0);
  noStroke();
  float rockyGoToX =  mouseX, rockyGoToY = mouseY;
  Food closestFood = rocky.goAfterFood(foods);
  if (!mousePressed) {
    rockyGoToX =  closestFood.x; 
    rockyGoToY = closestFood.y;
  }
  rocky.easeTowards(rockyGoToX, rockyGoToY).rotateTowards(rockyGoToX, rockyGoToY).drawIt();
  for (Food food: foods) {
    food.drawIt();
  }
}

class Raccoon {
  float x, y;//coordinates of Raccoon, representing point between the eyes
  float scale;//a multiplier that allows us to draw a raccoon at any scale
  float rotationAngleInRadians = 0;

  Raccoon(float x_, float y_) {
    x = x_;
    y = y_;
    scale = 1;
  }

  void drawIt() {
    pushMatrix();
    translate(x, y);
    rotate(rotationAngleInRadians);
    float baseSize = width * scale;

    //draw body
    fill(140, 70, 20);
    ellipse(0, -baseSize * 0.06, -baseSize * 0.06, baseSize * 0.12);

    //draw tail
    float fillColor = 50;
    for (int i = 0; i < 9; ++i) {
      fill(fillColor);
      fillColor = 255-fillColor;
      ellipse(0, -baseSize * (0.12 + 0.005 * i), -baseSize * 0.02, baseSize * 0.03);
    }

    //draw nose
    fill(140, 70, 20);
    triangle(0, baseSize * 0.04, -baseSize * 0.02, 0, baseSize * 0.02, 0);
    fill(255, 0, 0);
    float noseRadius = baseSize * 0.01;
    ellipse(0, baseSize * 0.04, noseRadius, noseRadius);

    //draw ears, referenced from ears (drawn later)
    float eyeDiameter = baseSize * 0.02;
    float leftEyecenter =  - eyeDiameter/2;
    float rightEyecenter =  eyeDiameter/2;
    float eyeHeightToWidthRatio = 3;
    float eyeHeight = 2 * eyeDiameter;
    float earBaseHeight =  -eyeHeight/2;
    fill(100, 50, 20);//dark brown
    for (int sign = -1; sign < 2; sign += 2) {
      beginShape();
      vertex(sign * eyeDiameter/2, earBaseHeight * 1.5);
      vertex(sign * eyeDiameter/4, earBaseHeight );
      vertex(sign * eyeDiameter* 0.75, earBaseHeight );
      vertex(sign * eyeDiameter/2, earBaseHeight * 1.5);
      // etc;
      endShape();
    }

    //draw white eyes
    fill(255);
    ellipse(leftEyecenter, 0, eyeDiameter, eyeHeight);
    ellipse(rightEyecenter, 0, eyeDiameter, eyeHeight);

    //draw black pupils
    fill(0);
    float pupilDiameter = eyeDiameter * 0.6;
    ellipse(leftEyecenter, pupilDiameter, pupilDiameter, pupilDiameter);
    ellipse(rightEyecenter, pupilDiameter, pupilDiameter, pupilDiameter);
    popMatrix();
  }

  Food goAfterFood(ArrayList<Food> foods) {
    float minDist = 1000000;
    Food closestFood = null;
    for (Food food: foods) {
      float d = food.moveAwayFrom(x, y);
      if (d < minDist) {
        minDist = d;
        closestFood = food;
      }
    }
    return closestFood;
  }


  Raccoon rotateTowards(float pointToX, float pointToY) {
    //a bit of trig...
    float newDirection = atan( (pointToY - y) / (pointToX - x) ) ;
    // because we drew our raccoon already rotated facing down...
    newDirection -= PI/2;

    //now, deal with the fact that atan may be off by 180 degrees,
    //so we may need to add PI radians
    if (pointToX == x) {
      if ( pointToY < y ) {
        newDirection += PI;
      }
    } 
    else  if (pointToX < x) {
      newDirection += PI;
    }
    //ease towards existing direction
    float angleEasing = 0.05;
    if (abs(newDirection-rotationAngleInRadians) > PI) {
      newDirection += (newDirection > rotationAngleInRadians) ? - 2 * PI : 2 * PI;
    }
    rotationAngleInRadians = angleEasing * newDirection + (1-angleEasing) * rotationAngleInRadians;
    return this;
  }

  Raccoon easeTowards(float pointToX, float pointToY) {
    float easing = 0.1;
    x += easing * (pointToX - x);
    y += easing * (pointToY - y);
    return this;
  }

  Raccoon setScale(float s) {
    scale = s;
    return this;
  }
}

class Food {
  float x, y;//coordinates of Raccoon, representing point between the eyes
  float scale;//a multiplier that allows us to draw a raccoon at any scale

    Food(float x_, float y_) {
    x = x_;
    y = y_;
    scale = 1;
  }

  void drawIt() {
    pushMatrix();
    translate(x, y);
    float radius = width * scale * 0.002;
    if (radius < 1) radius = 1;
    fill(255, 0, 0);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }

  float moveAwayFrom(float pointToX, float pointToY) {
    float s = width * scale * 0.001;
    float dist = distance( pointToX, pointToY);

    x +=  s * (x - pointToX ) / dist / dist * width * 0.005;
    y +=  s * (y - pointToY) /  dist / dist * width * 0.005;
    if (x < width * 0.01 ) {
      x =  width * 0.01;
    } 
    else if (x > width * 0.99 ) {
      x =  width * 0.99;
    } 
    if (y < height * 0.01 ) {
      y =  height * 0.01;
    } 
    else if (y > height * 0.99 ) {
      y =  height * 0.99;
    } 
    if (dist < 10) {
      teleport();
      dist = distance( pointToX, pointToY);
    }
    //drift towards center
    x +=  s * (width/2 - x ) / dist ;
    y +=  s * (height/2 - y) /  dist;
    return dist;
  }

  float distance(float pointToX, float pointToY) {
    return sqrt((pointToX-x) * (pointToX-x) + (pointToY -y)* (pointToY -y));
  }

  Food teleport() {
    return teleportToEllipse();
  }

  Food teleportToEdge() {
    if (random(2)>1) {
      x = random(width);
      y = (random(2)>1) ?   height : 0;
    } 
    else {
      x = (random(2)>1) ?   width : 0;
      y = random(height);
    }
    return this;
  }
  Food teleportToEllipse() {
    float a = random(2 * PI);
    x = width / 2 * (1 + cos(a));
    y = height / 2 * (1 + sin(a));
    return this;
  }
}


