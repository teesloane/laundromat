/**
 *  Compound
 *
 *  by Ricard Marxer
 *
 *  This example shows how to create compound bodies 
 *  which are bodies made of multiple shapes.
 */

import fisica.*;

FWorld world;

FCompound pop;
FCompound cage;

void setup() {
  size(400, 400);
  smooth();

  Fisica.init(this);
  Fisica.setScale(10);

  world = new FWorld();
  world.setEdges();
  world.remove(world.top);

  pop = createPop();
  pop.setPosition(width/2, height/2);
  pop.setBullet(true);
  world.add(pop);

  cage = createCage();
  cage.setPosition(width/2, height/2);
  cage.setRotation(PI/6);
  cage.setBullet(true);
  world.add(cage);
  
  for (int i=0; i<10; i++) {
    FCircle c = new FCircle(7);
    c.setPosition(width/2-10+random(-5, 5), height/2-10+random(-5, 5));
    c.setBullet(true);
    c.setNoStroke();
    c.setFillColor(color(#FF9203));
    world.add(c);
  }

  rectMode(CENTER);
}

void draw() {
  background(255);

  world.step();
  world.draw();
}

FCompound createPop() {  
  FBox b = new FBox(6, 60);
  b.setFillColor(color(#1F716B));
  b.setNoStroke();
  FCircle c = new FCircle(20);
  c.setPosition(0, -30);
  c.setFillColor(color(#FF0051));
  c.setNoStroke();
  
  FCompound result = new FCompound();
  result.addBody(b);
  result.addBody(c);
  
  return result;
}

FCompound createCage() {
  FBox b1 = new FBox(10, 110);
  b1.setPosition(50, 0);
  b1.setFill(0);
  b1.setNoStroke();

  FBox b2 = new FBox(10, 110);
  b2.setPosition(-50, 0);
  b2.setFill(0);
  b2.setNoStroke();
  
  FBox b3 = new FBox(110, 10);
  b3.setPosition(0, 50);
  b3.setFill(0);
  b3.setNoStroke();
  
  FBox b4 = new FBox(110, 10);
  b4.setPosition(0, -50);
  b4.setFill(0);
  b4.setNoStroke();
  
  FCompound result = new FCompound();
  result.addBody(b1);
  result.addBody(b2);
  result.addBody(b3);
  result.addBody(b4);
  return result;
}


void keyPressed() {
  try {
    saveFrame("screenshot.png");
  } 
  catch (Exception e) {
  }
}