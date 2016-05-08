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