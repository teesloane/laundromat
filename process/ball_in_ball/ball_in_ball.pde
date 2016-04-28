import themidibus.*;

MidiBus myBus;

float c1x = 0;
float c1y = 0;
float c1r = 30;

float c2x = 300;
float c2y = 200;
float c2r = 100;



void setup() {
  size (500, 500);
  noStroke();

  MidiBus.list();

  myBus = new MidiBus(this, -1, "Chill Bus");
}

void draw() {
  background(230);

  c1x = mouseX;
  c1y = mouseY;

  boolean hit = circleCircle(c1x, c1y, c1r, c2x, c2y, c2r);

  if (hit) {
    fill( 124, 100, 43); 
    myBus.sendNoteOn(0, 60, 127);
    
  } else {
    fill (1, 232, 4);
    myBus.sendNoteOff(0, 60, 127);
  }

  // washing machine
  ellipse (c2x, c2y, c2r*2, c2r*2);

  // mouse circle. 

  fill (0, 140, 32);
  ellipse(c1x, c1y, c1r*2, c1r*2);
}

boolean circleCircle(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {

  float distX = c1x - c2x;
  float distY = c1y - c2y;
  float distance = sqrt( (distX*distX) + (distY*distY));

  if (distance >= c1r+c2r) {
    return true;
  }
  
  return false;
}