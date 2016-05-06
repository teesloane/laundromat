import fisica.*;
import themidibus.*;
import controlP5.*;

FWorld world;
FCompound wM;
FBox anchor;
FRevoluteJoint joint;

MidiBus myBus;

ControlP5 cp5;

VKey myKey;

float numBalls = 4;

void setup() {
  // Midi Setup
  MidiBus.list();
  myBus = new MidiBus(this, 1, "Chill Bus");
  
  // Fisica Setup:
  Fisica.init(this);
  world = new FWorld();

  // CP5 Setup:
  cp5 = new ControlP5(this);
  
  myKey = new VKey(100, 100, 30);
  
  size(500, 500);
  smooth();

  
  // create wM
  wM = createWashingMachine();
  wM.setPosition(width/2, height/2);

  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);


  // create balls
  for (int i = 0; i < numBalls; i++) {
    FCircle b = new FCircle(10);
    b.setPosition(width/2, height/2);
    b.setVelocity(0, 200);
    b.setBullet(true);
    b.setRestitution(1.2);
    b.setNoStroke();
    b.setFill(200, 30, 90);
    world.add(b);
  }
}

void draw() {
  background(255);
  wM.adjustRotation(0.025);

  world.draw();
  world.step();
}

/*===== Contact Detection ======= */

void contactStarted(FContact c) {
  FBody ball = null;
  if (c.getBody1() == wM) {
    ball = c.getBody2();
  } else if (c.getBody2() == wM) {
    ball = c.getBody1();
  }

  myBus.sendNoteOn(0, 50, 127);
  //myBus.sendNoteOff(0, 50, 127);
  // on contact: send midi note.
}

void contactPersisted(FContact c) {
  // continued contact: retain midi note?
}

void contactEnded(FContact c) {
  // discontinued contact : send midi note off.
}


/* ===== Compound Shape : wM Creation ===== */
FCompound createWashingMachine() {

  float boxLong = 80;
  float boxThin = 5;
  float dist = sqrt(3)*boxLong;
  float diagX = dist / 4;
  float diagY = dist / 2.35;

  FBox left = new FBox(boxThin, boxLong);
  left.setPosition(-dist/2, 0);
  //left.setRotation(45);
  left.setFill(0);
  left.setNoStroke();

  FBox right = new FBox(boxThin, boxLong);
  right.setPosition(dist/2, 0);
  right.setFill(0);
  right.setNoStroke();

  FBox topRight = new FBox(boxThin, boxLong);
  topRight.setPosition(0, 0);
  topRight.setRotation(-45);
  topRight.adjustPosition(diagX, -diagY);
  topRight.setFill(0);
  topRight.setNoStroke();

  FBox topLeft = new FBox(boxThin, boxLong);
  topLeft.setPosition(0, 0);
  topLeft.adjustPosition(-diagX, -diagY);
  topLeft.setRotation(45);
  topLeft.setFill(0);
  topLeft.setNoStroke();

  FBox bottomLeft = new FBox(boxThin, boxLong);
  bottomLeft.setPosition(0, 0);
  bottomLeft.adjustPosition(-diagX, diagY);
  bottomLeft.setRotation(-45);
  bottomLeft.setFill(0);
  bottomLeft.setNoStroke();


  FBox bottomRight = new FBox(boxThin, boxLong);
  bottomRight.setPosition(0, 0);
  bottomRight.adjustPosition(diagX, diagY);
  bottomRight.setRotation(45);
  bottomRight.setFill(0);
  bottomRight.setNoStroke();

  FCompound wM = new FCompound();
  wM.addBody(left);
  wM.addBody(right);
  wM.addBody(topRight);
  wM.addBody(topLeft);
  wM.addBody(bottomLeft);
  wM.addBody(bottomRight);

  return wM;
}