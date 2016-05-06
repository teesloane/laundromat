class Ball {
  float rad;
  float x;
  float y;
  int midiNote;

  Ball(float xPos, float yPos, float irad, int note) {
    xPos = x;
    yPos = y;
    rad = irad;
    midiNote = note;
    println(midiNote);

    FCircle b = new FCircle(rad);
    b.setPosition(width/2, height/2);
    b.setVelocity(0, 200);
    b.setBullet(true);
    b.setRestitution(1.2);
    b.setNoStroke();
    b.setFill(200, 30, 90);
    world.add(b);
  }

  void contactStarted(FContact c) {

    FBody ball = null;
    if (c.getBody1() == wM) {
      ball = c.getBody2();
    } else if (c.getBody2() == wM) {
      ball = c.getBody1();
    }
    println("contact with D");
  }
}