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
float Sides = 6;
float oldSides = 6;//This is used to see if the slider sides value has changed.

VKey[] keyboard = new VKey[12];
String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", };

void setup() {
  // init libraries / classes
  MidiBus.list();
  myBus = new MidiBus(this, 1, selectedMidiDevice);
  Fisica.init(this);
  world = new FWorld();
  cp5 = new ControlP5(this);

  size(640, 480);
  smooth();

  createWmRadius(int(Sides), 100);
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
      b.startTimer();
      b.updateFriction();
    }
  }
}

//This is called when any slider is clicked.
void controlEvent(ControlEvent Event) {
  if (Event.getController().getName()=="Sides") //If it is the side slider
  {
    //floor rounds the values down to the nearest integer. This is usefull because sliders 
    //only output floats and we want to use ints.
    if (floor(Event.getController().getValue()) != floor(oldSides)) { //And the value has changed

      oldSides = Sides;
      world.remove(wM); //remove the old washing machine
      createWmRadius(int(Sides), 100); //create a new one in its place
    }
  }
}