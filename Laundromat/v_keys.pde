//ControlP5 cp5;

class VKey {
  int keySize = 20;
  float x;
  float y;
  int midiNote;

  int whiteCFG = color(230, 234, 144);
  int whiteCBG = color(230, 234, 144);
  int whiteCActive = color(210, 214, 124);

  int blackCFG = color(30, 34, 44);
  int blackCBG = color(30, 34, 44);
  int blackCActive = color(510, 54, 64);

  VKey(float xPos, float yPos, int note) { // why not name classes same as the ones declared above?
    x = xPos;
    y = yPos;
    int midiNote = note;

    cp5.addButton("")
      .setPosition(x, y)
      .setSize(keySize, keySize)
      .setColorForeground(whiteCFG)
      .setColorBackground(whiteCBG)
      .setColorActive(whiteCActive);
  }

  void keyColour() {

  }

  void sendMidiNote(){

  }

}
