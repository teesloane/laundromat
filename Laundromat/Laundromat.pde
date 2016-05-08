/* 
  *For New Users: 
  *Don't forget to change your midi device.
  *Eventually there will be a midi selector as part of the ui. 
  *Todo on github: https://github.com/teesloane/laundromat/issues/4
  *Contributions welcome!
*/

import fisica.*;
import themidibus.*;
import controlP5.*;

FWorld world;
FCompound wM;
FBox anchor;
FRevoluteJoint joint;

int ballCount = 0;
int maxBalls = 12;

Ball[] balls = new Ball[maxBalls];

MidiBus myBus;
String selectedMidiDevice = "Chill_Bus"; // < < <  Change this to the name of your midi device.

// Knob / UI setup.
ControlP5 cp5;
int sliderForeground = (color(52, 152, 219));
int sliderActive = (color(42, 142, 209));
int sliderBackground = color(100, 110, 130);

// Knob Sets
float Rotation = 2;
float Gravity = 5;
float Friction = 0;
float DeShape = 0;

VKey[] keyboard = new VKey[12];
String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", };

void setup() {
  // init libraries / classes
  myBus = new MidiBus(this, 1, selectedMidiDevice);
  Fisica.init(this);
  world = new FWorld();
  cp5 = new ControlP5(this);

  size(640, 480);
  smooth();

  createWm();
  createInterface();
}


void draw() {
  background(55);

  wM.adjustRotation(Rotation/150);

  world.setGravity(0, Gravity *25);
  world.draw();
  world.step();

  // check for contact / fire midi notes.
  for (Ball b : balls) {
    if (b != null) {
      b.checkContact(b);
      b.updateFriction();
    }
  }
  
}