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
  anchor.setPosition(width/2, height/2);

  // create wM
  wM = createWashingMachine();
  //wM.setPosition(200, 150);

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

  float boxWidth = 100;
  float boxHeight = 5;
  
  float xC = width/2;
  float yC = height/2;
  float bU = boxWidth/2;
  
  //bU must be /2 of boxWidth



  FBox b1 = new FBox(boxWidth, boxHeight);
  b1.setPosition(xC, yC - bU);
  b1.setFill(0);
  b1.setNoStroke();


  FBox b2 = new FBox(boxWidth, boxHeight);
  b2.setPosition(xC + bU*1.5, yC - bU / 6);
  b2.setRotation(45);
  b2.setFill(0);
  b2.setNoStroke();

  FBox b3 = new FBox(boxWidth, boxHeight);
  b3.setPosition(xC +bU*1.5, yC + bU * 1.5 );
  b3.setRotation(-45);
  b3.setFill(0);
  b3.setNoStroke();


  FBox b4 = new FBox(boxWidth, boxHeight);
  b4.setPosition(xC, yC + bU*2.35);
  b4.setRotation(0);
  b4.setFill(0);
  b4.setNoStroke();

  FBox b5 = new FBox(boxWidth, boxHeight);
  b5.setPosition(xC - bU * 1.5, yC + bU * 1.5);
  b5.setRotation(45);
  b5.setFill(0);
  b5.setNoStroke();

  FBox b6 = new FBox(boxWidth, boxHeight);
  b6.setPosition(xC - bU*1.5, yC - bU / 6);
  b6.setRotation(-45);
  b6.setFill(0);
  b6.setNoStroke();

  FCompound wM = new FCompound();
  wM.addBody(b1);
  wM.addBody(b2);
  wM.addBody(b3);
  wM.addBody(b4);
  wM.addBody(b5);
  wM.addBody(b6);

  return wM;
}