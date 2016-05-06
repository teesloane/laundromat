//ControlP5 cp5;

class VKey {
  int keySize = 20;
  float x;
  float y;
  int midiNote;
  
  int[] sharps = {37, 39, 42, 44, 46};

  int whiteCFG = color(230, 234, 144);
  int whiteCBG = color(230, 234, 144);
  int whiteCActive = color(210, 214, 124);

  int blackFg = color(30, 34, 44);
  int blackBg = color(30, 34, 44);
  int blackActive = color(210, 54, 64);

  VKey(float xPos, float yPos, int note) {
    x = xPos;
    y = yPos;
    int midiNote = note;
    

    println(note, sharps.length);
    // create a black key if midinote is a sharp. 
    for (int i = 0; i < sharps.length; i++) {
      if (midiNote == sharps[i]) {
        cp5.addButton("")
         .setPosition(x, y)
         .setSize(keySize, keySize)
         .setColorForeground(blackFg)
         .setColorBackground(blackBg)
         .setColorActive(blackActive);
      }
    }
 
    
  
  }

  void keyColour() {

  }

  void sendMidiNote(){

  }

}