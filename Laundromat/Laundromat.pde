import fisica.*;
import themidibus.*;
import controlP5.*;

FWorld world;
FCompound wM;
FBox anchor;
FRevoluteJoint joint;

MidiBus myBus;

ControlP5 cp5;

float rotSpeed = 0;
Knob rotationSpeed;

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

  // create keyboard
  for (int i = 0; i < keyboard.length; i++) {
    keyboard[i] = new VKey(width/4 + i*width/24, height-height/10, 37+i, notes[i]);
  }
  
  rotationSpeed = cp5.addKnob("rotSpeed")
    .setRange(-0.05, 0.05)
    .setValue(0)
    .setPosition(50, 50)
    .setRadius(25)
    .setDragDirection(Knob.HORIZONTAL);
}

void draw() {
  background(255);
  wM.adjustRotation(rotSpeed);
  
  

  world.draw();
  world.step();
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