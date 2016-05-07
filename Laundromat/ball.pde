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
    b.setRestitution(1.1);
    b.setNoStroke();
    b.setFill(230, 126, 34);
    world.add(b);

    //println(b.isTouchingBody(wM));
  }


  void checkContact(Ball b) {

    println("contact!!");
   

  }
}