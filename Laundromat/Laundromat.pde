/*
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
float SideLength = 100;
float oldSides = 6;//This is used to see if the slider sides value has changed.
int MidiDevice = 0;

VKey[] keyboard = new VKey[12];
String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", };

void setup() {
  // init libraries / classes
  MidiBus.list();
  myBus = new MidiBus(this, -1, MidiDevice);


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
  wM.setRotation(wM.getRotation()+Rotation/150);
  world.setGravity(0, Gravity *25);
  world.draw();
  world.step();

  // check for contact / fire midi notes.
  for (int i = 0; i < maxBalls; i++) {
    // for (Ball b : balls) {
    if (balls[i] != null) {
      balls[i].checkContact(balls[i]);
      balls[i].startTimer();
      balls[i].updateFriction();
      if (balls[i].getX() < -5 || balls[i].getX() > width + 5|| balls[i].getY() > height + 5|| balls[i].getY() < 0) {
        world.remove(balls[i]);
        balls[i]= null;
        ballCount --;
      }
    }
  }
}

//This is called when any slider is clicked.
void controlEvent(ControlEvent Event) {
  String name = Event.getController().getName();
  if (name =="Sides"  || name == "SideLength"|| name == "DeShape") //If it is the side slider
  {
    //floor rounds the values down to the nearest integer. This is usefull because sliders
    //only output floats and we want to use ints.
    if (floor(Event.getController().getValue()) != floor(oldSides)) { //And the value has changed
      float angle = wM.getRotation();
      oldSides = Sides;
      world.remove(wM); //remove the old washing machine
      createWmRadius(int(Sides), SideLength); //create a new one in its place
      wM.setRotation(angle);
    }
  } else if (name == "MidiDevice") {
    MidiBus.findMidiDevices();
    myBus = new MidiBus(this, -1, MidiDevice);
  }
}