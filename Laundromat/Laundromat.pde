import fisica.*;
import themidibus.*;
import controlP5.*;

FWorld world;
FCompound wM;
FBox anchor;
FRevoluteJoint joint;
MidiBus myBus;
ControlP5 cp5;
VKey myKey, myKey2;

void setup() {
  size(500, 500);
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
  
  // create keys
  myKey = new VKey(100, 100, 48, "C");
  myKey2 = new VKey(150, 100, 52, "E");

}

void draw() {
  background(255);
  wM.adjustRotation(0.025);

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