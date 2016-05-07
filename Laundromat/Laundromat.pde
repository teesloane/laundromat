import fisica.*;
import themidibus.*;
import controlP5.*;

FWorld world;
FCompound wM;
FBox anchor;
FRevoluteJoint joint;

int maxBalls = 10;

Ball[] balls = new Ball[maxBalls];

MidiBus myBus;

ControlP5 cp5;
float Rotation = 2;
float Gravity = 5;

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
    keyboard[i] = new VKey(width/4 + i*width/24, height-height/10, 37+i, notes[i]);
  }

  // Rotation Knob
  cp5.addKnob("Rotation")
    .setRange(-10, 10)
    .setValue(2)
    .setPosition(50, 50)
    .setRadius(25)
    .setDragDirection(Knob.HORIZONTAL);

  // Gravity Knob
  cp5.addKnob("Gravity")
    .setRange(0, 10)
    .setValue(5)
    .setPosition(50, 125)
    .setRadius(25)
    .setDragDirection(Knob.HORIZONTAL);

  // Spring Knob (not finished)
  cp5.addKnob("Spring")
    .setRange(0, 10)
    .setValue(5)
    .setPosition(50, 200)
    .setRadius(25)
    .setDragDirection(Knob.HORIZONTAL);
}

//

void draw() {
  background(55);
  wM.adjustRotation(Rotation/150);

  world.setGravity(0, Gravity *25);
  world.draw();
  world.step();


  for (Ball b : balls) {
    if (b != null) {
      b.checkContact(b);
    }
  }
}

/*===== Contact Detection ======= */

//void contactStarted(FContact c) {
// FBody ball = null;
// if (c.getBody1() == wM) {
//   ball = c.getBody2();
// } else if (c.getBody2() == wM) {
//   ball = c.getBody1();
// }

// myBus.sendNoteOn(0, 50, 127);
// //myBus.sendNoteOff(0, 50, 127);
// // on contact: send midi note.
//}

//void contactEnded(FContact c) {
// // discontinued contact : send midi note off.
//}