import fisica.*;
import themidibus.*;
import controlP5.*;

FWorld world;
FCompound wM;
FBox anchor;
FRevoluteJoint joint;

int ballCount = 0;
int maxBalls = 30;

Ball[] balls = new Ball[maxBalls];

MidiBus myBus;

// Knob / UI setup.
ControlP5 cp5;
int knobForeground = color(220);
int knobActive = color(255);
int knobBackground = color(100, 110, 130);

// Knob Sets
float Rotation = 2;
float Gravity = 5;
float Friction = 0;
float DeShape = 0;

VKey[] keyboard = new VKey[12];
String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", };

void setup() {
  size(640, 480);
  smooth();

  // init libraries / classes
  myBus = new MidiBus(this, 1, "Chill Bus");
  Fisica.init(this);
  world = new FWorld();
  cp5 = new ControlP5(this);

  // create washing machine
  wM = createWashingMachine();
  wM.setPosition(width/2, height/2);
  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);

  /* ====== UI CONTROLS ======= */

  // create keyboard
  for (int i = 0; i < keyboard.length; i++) {
    keyboard[i] = new VKey(width/4 + i*width/24, height-height/10, 48+i, notes[i]);
  }

  // Rotation Knob
  createKnob("Rotation", -10, 10, 1.5, 50, 150);
  createKnob("Gravity", 0, 10, 0, 125, 150);
  createKnob("Friction", 0, 1, 0, 50, 225);
  createKnob("DeShape", -20, 20, 0, 125, 225);
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