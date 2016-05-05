import fisica.*;
import themidibus.*; //Import the library

FWorld world;
FCompound wM; // eventually a compound.
FBox anchor;
FRevoluteJoint joint;

  MidiBus myBus;

float numBalls = 0;

void setup() {
  MidiBus.list();
  myBus = new MidiBus(this, 1, "Chill Bus");
  size(500, 500);
  smooth();

  Fisica.init(this);
  world = new FWorld();

  anchor = new FBox(30, 30);
  anchor.setStatic(true);
  anchor.setFill(234, 23, 23);
  anchor.setPosition(width/2, height/2);

  // create wM
  wM = createWashingMachine();
  wM.setPosition(width/2, height/2);

  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);

  joint = new FRevoluteJoint(wM, anchor);
  joint.setAnchor(width/2, height/2);
  joint.setEnableMotor(true);


  world.add(anchor);

  // create balls
  for (int i = 0; i < numBalls; i++) {
    FCircle b = new FCircle(10);
    b.setPosition(random(190, 320), random(150, 250));
    b.setVelocity(0, 200);
    b.setBullet(true);
    b.setRestitution(1);
    b.setNoStroke();
    b.setFill(200, 30, 90);
    world.add(b);
  }
}

void draw() {
  background(255);

   //world.add(joint);

   //wM.adjustRotation(0.03);

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

  float xC = 0;
  float yC = 0;

  float bU = 50;

  float dist = sqrt(3)*boxLong;

  float ort = 1.3;
  //bU must be /2 of boxWidth

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
  topRight.adjustPosition(dist / 4, -dist / 2.35);
  topRight.setFill(0);
  topRight.setNoStroke();

  FBox topLeft = new FBox(boxThin, boxLong);
  topLeft.setPosition(0, 0);
  topLeft.adjustPosition(-dist / 4, -dist / 2.35);
  topLeft.setRotation(45);
  topLeft.setFill(0);
  topLeft.setNoStroke();

  FBox bottomLeft = new FBox(boxThin, boxLong);
  bottomLeft.setPosition(0, 0);
  bottomLeft.adjustPosition(-dist / 4, dist / 2.35);
  bottomLeft.setRotation(-45);
  bottomLeft.setFill(0);
  bottomLeft.setNoStroke();


  FBox bottomRight = new FBox(boxThin, boxLong);
  bottomRight.setPosition(0, 0);
  bottomRight.adjustPosition(dist / 4, dist / 2.35);
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