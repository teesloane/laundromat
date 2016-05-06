//ControlP5 cp5;

class VKey {

  /*
  * Change button color based on whether sharp or not
   * pushing button triggers note.
   * pushing button creates ball.
   */
  CallbackListener cb;

  int keySize = 20;
  float x;
  float y;
  int midiNote;

  int whiteFg = color(230, 234, 144);
  int whiteBg = color(230, 234, 144);
  int whiteActive = color(210, 214, 124);

  int blackFg = color(30, 34, 44);
  int blackBg = color(30, 34, 44);
  int blackActive = color(70, 64, 74);

  VKey(float xPos, float yPos, int note) {
    x = xPos;
    y = yPos;
    int midiNote = note;

    cp5.addButton("").setId(1)
      .setPosition(x, y)
      .setSize(keySize, keySize)
      .setColorForeground(blackFg)
      .setColorBackground(blackBg)
      .setColorActive(blackActive)
      .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent theEvent) {
        switch(theEvent.getAction()) {
          case(ControlP5.ACTION_PRESSED): 
          new Ball(0, 0, 10, midiNote);
          break;
        }
      }
      }
    );
  }
}