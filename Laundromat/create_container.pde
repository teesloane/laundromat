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