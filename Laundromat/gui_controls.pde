/* ========= Call this function to create a slider. ========== */

void createSlider(String knobName, float rangeA, float rangeZ, float defValue, float posX, float posY) {

  Slider control = cp5.addSlider(knobName)

    .setRange(rangeA, rangeZ)
    .setValue(defValue)
    .setPosition(posX, posY)
    .setDecimalPrecision(0)
    .setSize(width/2, 15)
    .setColorForeground(sliderForeground)
    .setColorBackground(sliderBackground)
    .setColorActive(sliderActive);
}

void createInterface() {
  // create keyboard
  for (int i = 0; i < keyboard.length; i++) {
    keyboard[i] = new VKey(width/4 + i*width/24, height-height/10, 48+i, notes[i]);
  }

  // UI Knobs.
  float sliderY = 30;
  createSlider("Rotation", -10, 10, 1.5, width/2 - width/4, sliderY);
  createSlider("Gravity", 0, 10, 0, width/2 - width/4, sliderY*2);
  createSlider("Friction", 0, 1, 0, width/2 - width/4, sliderY*3);
}



/* ========= Class for creating a key in the keyboard ========== */

class VKey {

  /*
  * Change button color based on whether sharp or not
   * note: buttons must have text to differntiate.
   */
  CallbackListener cb;

  int keySize = 20;
  float x;
  float y;
  int midiNote;

  int whiteFg = color(230, 234, 144);
  int whiteBg = color(230, 234, 144);
  int whiteActive = color(210, 214, 124);

  int blackBg = (color(52, 152, 219));
  int blackFg = (color(32, 112, 202));
  int blackActive = color(70, 64, 74);

  VKey(float xPos, float yPos, int note, String id) {
    x = xPos;
    y = yPos;
    final int midiNote = note;

    cp5.addButton(id)
      .setPosition(x, y)
      .setSize(keySize, keySize)
      .setColorForeground(blackFg)
      .setColorBackground(blackBg)
      .setColorActive(blackActive)
      .addCallback(new CallbackListener() {
      void controlEvent(CallbackEvent theEvent) {
        switch(theEvent.getAction()) {
          case(ControlP5.ACTION_PRESSED):

          if (ballCount == maxBalls) {
            return;
          }

          if (ballCount <= maxBalls) {
            balls[ballCount] = new Ball(0, 0, 10, midiNote);
            ballCount += 1;

            // to do: if one away from max balls, delete last ball.).
          }

          break;
        }
      }
    }
    );
  }
}