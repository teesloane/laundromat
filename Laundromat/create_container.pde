void createWm(int Nsides, float sideLength) {
  wM = createNsideWashingMachine(Nsides, sideLength);
  wM.setPosition(width/2, height/2 + height/12);
  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);
}
void createWmRadius(int Nsides, float radius) {
  wM = createNsideWashingMachineByRadius(Nsides, radius);
  wM.setPosition(width/2, height/2 + height/12);
  wM.setBullet(true);
  wM.setStatic(true);
  world.add(wM);
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

  for (int i = 0; i< Nsides; i++) {
    FBox side = new FBox(boxThin, boxLong);
    side.setPosition(radius * cos(2*PI*i/Nsides), radius * sin(2*PI*i/Nsides));
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