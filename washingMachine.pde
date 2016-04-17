//FCompound createWashingMachine() {
//  FBox b1 = new FBox(10, 110);
//  b1.setPosition(50, 0);
//  b1.setFill(0);
//  b1.setNoStroke();

//  FBox b2 = new FBox(10, 110);
//  b2.setPosition(-50, 0);
//  b2.setFill(0);
//  b2.setNoStroke();
  
//  FBox b3 = new FBox(110, 10);
//  b3.setPosition(0, 50);
//  b3.setFill(0);
//  b3.setNoStroke();
  
//  FBox b4 = new FBox(110, 10);
//  b4.setPosition(0, -50);
//  b4.setFill(0);
//  b4.setNoStroke();
  
//  FCompound result = new FCompound();
//  result.addBody(b1);
//  result.addBody(b2);
//  result.addBody(b3);
//  result.addBody(b4);
//  return result;
//}

FCompound createWashingMachine() {
  
  FBox b1 = new FBox(50, 50);
  FCircle c1 = new FCircle(20);
  
  b1.setStatic(true);
  
  
  
  FCompound wM = new FCompound();
    wM.addBody(b1);
    wM.addBody(c1);
    return wM;
}