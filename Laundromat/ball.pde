void createBall() {
  for (int i = 0; i < numBalls; i++) {
    FCircle b = new FCircle(10);
    b.setPosition(width/2, height/2);
    b.setVelocity(0, 200);
    b.setBullet(true);
    b.setRestitution(1.2);
    b.setNoStroke();
    b.setFill(200, 30, 90);
    world.add(b);
  }
}