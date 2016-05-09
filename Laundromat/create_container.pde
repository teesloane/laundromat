void createWm() {
  wM = createNsideWashingMachine(6, 80);
  //  wM = createNsideWashingMachineByRadius(6,80);
 // wM = createWashingMachine();
  wM.setPosition(width/2, height/2 + height/12);
  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);


}

void createWm(int Nsides, float sideLength) {
  wM = createNsideWashingMachine(Nsides, sideLength);
  //  wM = createNsideWashingMachineByRadius(6,80);
 // wM = createWashingMachine();
  wM.setPosition(width/2, height/2 + height/12);
  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);


}
void createWmRadius(int Nsides, float radius) {
  wM = createNsideWashingMachineByRadius(Nsides, radius);
  //  wM = createNsideWashingMachineByRadius(6,80);
 // wM = createWashingMachine();
  wM.setPosition(width/2, height/2 + height/12);
  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);


}


/* ===== Compound Shape : wM Creation ===== */
FCompound createWashingMachine() {
  float hexColour = 240;
  float boxLong = 80;
  float boxThin = 5;
  float dist = sqrt(3)*boxLong;
  float sideShrink = dist / 40;
  float diagX = dist / 4-2;
  float diagY = dist / 2.35;
  
  FBox left = new FBox(boxThin, boxLong);
  left.setPosition(-dist/2 + sideShrink, 0);
  left.setFill(hexColour);
  left.setNoStroke();

  FBox right = new FBox(boxThin, boxLong);
  right.setPosition(dist/2 - sideShrink, 0);
  right.setFill(hexColour);
  right.setNoStroke();

  FBox topRight = new FBox(boxThin, boxLong);
  topRight.setPosition(0, 0);
  topRight.setRotation(-45 + DeShape);
  topRight.adjustPosition(diagX, -diagY);
  topRight.setFill(hexColour);
  topRight.setNoStroke();

  FBox topLeft = new FBox(boxThin, boxLong);
  topLeft.setPosition(0, 0);
  topLeft.adjustPosition(-diagX, -diagY);
  topLeft.setRotation(45 + DeShape);
  topLeft.setFill(hexColour);
  topLeft.setNoStroke();

  FBox bottomLeft = new FBox(boxThin, boxLong);
  bottomLeft.setPosition(0, 0);
  bottomLeft.adjustPosition(-diagX, diagY);
  bottomLeft.setRotation(-45 + DeShape);
  bottomLeft.setFill(hexColour);
  bottomLeft.setNoStroke();

  FBox bottomRight = new FBox(boxThin, boxLong);
  bottomRight.setPosition(0, 0);
  bottomRight.adjustPosition(diagX, diagY);
  bottomRight.setRotation(45 + DeShape);
  bottomRight.setFill(hexColour);
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

FCompound createNsideWashingMachine(int Nsides, float sideLength) {
  float hexColour = 240;
  float boxLong = sideLength;
  float boxThin = 5;
   

  /*The inradius of the polygon. This distance from the center point to the mid point of the side.
  The '-(boxThin/2)' part brings all the sides in a little bit to clean up the corners. Serves the same
  purpose as sideShrink in the original createWashingMachine, I think.
  Does not work on triangles, the angles are too small for this method to work properly, works well
  on all other regular polygons.
  */
  float radius =((boxLong/2) * 1/(tan(PI/Nsides)))-(boxThin/2);

  FCompound wM = new FCompound();

  for(int i = 0; i< Nsides; i++){
    FBox side = new FBox(boxThin, boxLong);
    side.setPosition(radius * cos(2*PI*i/Nsides),radius * sin(2*PI*i/Nsides)); 
    side.setRotation(((TWO_PI/Nsides)*i)+ radians(-DeShape));
    
    side.setFill(hexColour);
    side.setNoStroke();
    
    wM.addBody(side);
  }
  return wM;
}

FCompound createNsideWashingMachineByRadius(int Nsides, float radius) {
  return createNsideWashingMachine(Nsides, 2*radius*tan(PI/Nsides));
}