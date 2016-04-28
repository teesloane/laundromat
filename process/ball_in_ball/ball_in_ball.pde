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
float G = .15;
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
    fill( 124, 100, 43); 
    sendNote(0, 60, 100);
    
    //myBus.sendNoteOn(0, 60, 127);
    
  } else {
    fill (1, 232, 4);
    //myBus.sendNoteOff(0, 60, 127);
    
  }

  // washing machine
  ellipseMode(CENTER);
  fill(39);
  ellipse (c2x, c2y, c2r*2, c2r*2);

  // mouse circle. 

  ellipseMode(CENTER);
  fill (0, 140, 32);
  ellipse(c1x, c1y, c1r*2, c1r*2);
}


/* ====== Functions ====== */

void sendNote(int channel, int pitch, int velocity) {
  myBus.sendNoteOn(channel, pitch, velocity);
  delay(200);
  myBus.sendNoteOff(channel, pitch, velocity);
}

void delay(int time){
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

boolean collision(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {

  float distX = c1x - c2x;
  float distY = c1y - c2y;
  float distance = sqrt( (distX*distX) + (distY*distY));

  if (distance >= c2r - c1r) {
      
    return true;
  }
  
  return false;
}