class Ball extends FCircle {

  int midiNote;

  Ball(float irad, int note) {
    super(irad);
    
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
      myBus.sendNoteOn(0, b.midiNote, 100);
    }
  }
  
}