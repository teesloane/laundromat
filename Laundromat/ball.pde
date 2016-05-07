class Ball extends FCircle {

  int midiNote;

  Ball(float xPos, float yPos, float irad, int note) {
    super(irad);
    println(note);

    this.midiNote = note;

    this.setPosition(width/2, height/2);
    this.setVelocity(0, 100);
    this.setBullet(true);
    this.setRestitution(1);
    this.setNoStroke();
    this.setDamping(0);
    this.setFill(230, 126, 34);  
    world.add(this);
  }

  void updateFriction() {
    this.setDamping(Friction);
  }

  // to do: time check to turn note off on wall rolling.
  void checkContact(Ball b) {

    if (b.isTouchingBody(wM)) {
      startTimer = millis(); // every time ball hits wall, update the time at which is happened.
    }

    timeElapsed = millis() - startTimer;

    println(timeElapsed);

    // if timeElapsed > x -- turn off midi note?

    if (b.isTouchingBody(wM)) {
     myBus.sendNoteOn(0, b.midiNote, 100);
    }

  }
}