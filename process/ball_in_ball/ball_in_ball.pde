import themidibus.*;

MidiBus myBus;

/* Vars and Setup */
 
//circle 1
float c1x = 200;
float c1y = 200;
float c1r = 10;

//circle 2
float c2x = 200;
float c2y = 200;
float c2r = 100;

//gravity

float yPos = 200;
float xPos = 200;
float G = .10;
float acceleration = 0;



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
  
  yPos += acceleration;
  acceleration += G;

  boolean hit = collision(c1x, c1y, c1r, c2x, c2y, c2r);

  if (hit) {
    sendNote(0, 60, 100);
    acceleration =- acceleration/1.10 ;
  } 

  // washing machine
  ellipseMode(CENTER);
  fill(39);
  ellipse (c2x, c2y, c2r*2, c2r*2);

  // bouncing ball. 
 
  ellipseMode(CENTER);
  fill (0, 140, 32);
  ellipse(xPos, yPos, c1r*2, c1r*2);
}


/* ====== Functions ====== */

void sendNote(int channel, int pitch, int velocity) {
  myBus.sendNoteOn(channel, pitch, velocity);
}

//void delay(int time){
//  int current = millis();
//  while (millis () < current+time) Thread.yield();
//}

boolean collision(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {

  float distX = xPos - c2x;
  float distY = yPos - c2y;
  float distance = sqrt( (distX*distX) + (distY*distY));

  if (distance >= c2r - c1r) {
    return true;
  }
  
  return false;
}