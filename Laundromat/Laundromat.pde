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
  myBus = new MidiBus(this, 1, "Chill Bus");
  Fisica.init(this);
  world = new FWorld();
  cp5 = new ControlP5(this);

  size(640, 480);
  smooth();

  createWm();

  /* ====== UI CONTROLS ======= */

  // create keyboard
  for (int i = 0; i < keyboard.length; i++) {
    keyboard[i] = new VKey(width/4 + i*width/24, height-height/10, 48+i, notes[i]);
  }
  
  float sliderY = 30;

  // UI Knobs. 
  createSlider("Rotation", -10, 10, 1.5, width/2 - width/4, sliderY, false);
  createSlider("Gravity", 0, 10, 0, width/2 - width/4, sliderY*2, false);
  createSlider("Friction", 0, 1, 0, width/2 - width/4, sliderY*3, false);
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