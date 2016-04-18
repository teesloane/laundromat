import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

void setup() {
  size(400, 400);
  smooth();
  
  MidiBus.list(); // List available midi ports
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, -1, "Chill Bus"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
   
}

float yPos = 25;
float G = .15;
float acceleration = 0;

void draw() {
  //animateShape();
  background(0);
  makeBall();
  
  //gravity shit
  yPos += acceleration;
  acceleration += G;
  
  if (yPos > height - 25) {
    acceleration =- acceleration /1.15; 
    myBus.sendNoteOn(0, 60, 127);
  }
    
}


void makeBall() {
  ellipse (width/2, yPos, 50, 50);
  fill(255);
}