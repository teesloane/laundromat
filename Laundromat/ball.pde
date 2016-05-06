//void createBall(int midiNote) {

//  FCircle b = new FCircle(10);
//  b.setPosition(width/2, height/2);
//  b.setVelocity(0, 200);
//  b.setBullet(true);
//  b.setRestitution(1.2);
//  b.setNoStroke();
//  b.setFill(200, 30, 90);
//  world.add(b);
//}


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
    fill( 3, 42, 123);
    ellipse(c.getX(), c.getY(), 20, 20);
    myBus.sendNoteOn(0, this.midiNote, 127);
    //myBus.sendNoteOff(0, 50, 127);
    // on contact: send midi note.
  }

  void contactPersisted(FContact c) {
    // continued contact: retain midi note?
  }

  void contactEnded(FContact c) {
    // discontinued contact : send midi note off.
  }
}