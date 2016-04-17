import themidibus.*;
import controlP5.*;
import fisica.*;

FWorld world;

FCompound pop;
FCompound washingMachine;

void setup() {
  size(400, 400);
  smooth();
  
  Fisica.init(this);
  Fisica.setScale(10);  
  
  world = new FWorld();
  world.setEdges();
  
  washingMachine = createWashingMachine();
  washingMachine.setPosition(width/2, height/2);
  world.add(washingMachine);

}


void draw() {
  background (255);
  
  world.step();
  world.draw();
}