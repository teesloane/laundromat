import fisica.*;
import themidibus.*; //Import the library

FWorld world;
FBox obstacle; // eventually a compound.

float numBalls = 5;

void setup() {
  size(500, 500);
  smooth();

  Fisica.init(this);
  world = new FWorld();

  // create wM
  obstacle = new FBox(150, 2);
  obstacle.setPosition(width/2, height/2);
  obstacle.setStatic(true); // < negates gravity. Key.
  world.add(obstacle);


  // create balls
  for (int i = 0; i < numBalls; i++) {
    FCircle b = new FCircle(20);
    b.setPosition(width/2 + random(-50, 50), 50);
    b.setVelocity(0, 200);
    b.setRestitution(0);
    b.setNoStroke();
    b.setFill(200, 30, 90);
    world.add(b);
  }
}

void draw() {
  background(255);  
  world.draw();
  world.step();
}


void contactStarted(FContact c) {
  // on contact: send midi note.
}

void contactPersisted(FContact c) {
  // continued contact: retain midi note?
}

void contactEnded(FContact c) {
  // discontinued contact : send midi note off.
}