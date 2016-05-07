class Ball extends FCircle {

  int midiNote;

  Ball(float xPos, float yPos, float irad, int note) {
    super(irad);
    println(note);

    this.midiNote = note;

    this.setPosition(width/2, height/2);
    this.setVelocity(0, 200);
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

  void checkContact(Ball b) {
    
    if (b.isTouchingBody(wM)) {
      myBus.sendNoteOn(0, b.midiNote, 127);
      
      //TODO: create time delay, - if note is rolling along sides, (contact persists) - turn off note.
      // if true for more than .5 seconds... send note off?
      // wakeUp()
      // isSleeping();
      //myBus.sendNoteOff(0, b.midiNote, 127);
    }
  }
}