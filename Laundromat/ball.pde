class Ball extends FCircle {

  int midiNote;
  boolean inContact;
  int contactTimer;

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
    this.inContact = false;
    this.contactTimer = 0;
    world.add(this);
  }

  void updateFriction() {
    this.setDamping(Friction);
  }

  // semi-done: time check to turn note off on wall rolling.
  void checkContact(Ball b) {
    
    if (b.isTouchingBody(wM)) {
      this.inContact = true;
      if ((millis() - this.contactTimer) > 100) {
      myBus.sendNoteOn(0, b.midiNote, 100);
      }
      
      // necessary?
      
      if ((millis() - this.contactTimer) < 20){
      myBus.sendNoteOff(0, b.midiNote, 100);
      }
      
    } else {
      this.inContact = false;
    }
  }
  
  void startTimer(){
    if (this.inContact) {
      this.contactTimer = millis();
    }
    
    println(this.contactTimer, millis()); // millis keeps running, contactTimer updates on contact.
  }
  
}